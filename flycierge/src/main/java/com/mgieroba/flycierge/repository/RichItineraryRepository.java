package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Price;
import com.mgieroba.flycierge.model.RichItinerary;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@AllArgsConstructor
public class RichItineraryRepository {

    private JdbcClient db;

    @Getter
    private static class ChapestDestinationsResponseDTO extends Flight {
        private long itineraryId;
        private String flightsHash;
        private long priceId;
        private long value;
        private String currency;
        private long priceCreateTs;
        private boolean isReturnFlight;
    }


    /**
     * Retrieves itineraries for specific origin starting within some date range.
     * Finds only those with price updated within the last 24 hours
     *
     * @param origin IATA code of the origin airport
     * @param departureRangeStart Beginning (inclusive) of the departure date range
     * @param departureRangeEnd Ending (inclusive) of the departure date range
     * @return List of itineraries (both one way and return) starting at origin for the given date range
     */
    public List<RichItinerary> findCheapestFromInGivenDepartureInterval(String origin, LocalDate departureRangeStart, LocalDate departureRangeEnd) {
        String sql = """
            WITH first_itinerary_flight AS (
                SELECT itinerary.itinerary_id, MIN(flight.start_date_time) AS start_time
                FROM itinerary
                JOIN itinerary_flight USING (itinerary_id)
                JOIN flight USING (flight_id)
                WHERE NOT itinerary_flight.is_return_flight
                GROUP BY itinerary_id
            ), matching_itineraries AS (
                SELECT itinerary.itinerary_id, itinerary.flights_hash
                FROM itinerary
                JOIN itinerary_flight USING (itinerary_id)
                JOIN flight USING (flight_id)
                JOIN first_itinerary_flight ON first_itinerary_flight.itinerary_id = itinerary.itinerary_id
                AND first_itinerary_flight.start_time = flight.start_date_time
                WHERE flight.origin = :origin
                AND first_itinerary_flight.start_time::DATE BETWEEN :departure_range_start AND :departure_range_end
            ), fresh_price_matching_itineraries AS (
                SELECT DISTINCT ON(price.itinerary_id) matching_itineraries.flights_hash, price.*
                FROM matching_itineraries
                JOIN price USING (itinerary_id)
                WHERE price.create_ts >= EXTRACT(EPOCH FROM NOW()) - :price_max_age_seconds
                ORDER BY price.itinerary_id, price.create_ts DESC
            )
            SELECT fp.flights_hash, fp.value, fp.currency, fp.price_id, fp.itinerary_id, fp.create_ts AS price_create_ts, if.is_return_flight, flight.*
            FROM fresh_price_matching_itineraries fp
            JOIN itinerary_flight if USING (itinerary_id)
            JOIN flight USING (flight_id)
            ORDER BY flight.start_date_time ASC;
            """;
        List<ChapestDestinationsResponseDTO> dtoList = db.sql(sql)
            .param("origin", origin)
            .param("departure_range_start", departureRangeStart)
            .param("departure_range_end", departureRangeEnd)
            .param("price_max_age_seconds", 86400)
            .query(ChapestDestinationsResponseDTO.class)
            .list();

        Map<Long, RichItinerary> richItineraryMap = new HashMap<>();
        dtoList.forEach(dto -> {
            RichItinerary richItinerary = richItineraryMap.computeIfAbsent(
                dto.getItineraryId(),
                RichItinerary::new
            );
            richItinerary.setFlightsHash(dto.getFlightsHash());

            Flight flight = Flight.builder()
                .flightId(dto.getFlightId())
                .airline(dto.getAirline())
                .number(dto.getNumber())
                .origin(dto.getOrigin())
                .destination(dto.getDestination())
                .startDateTime(dto.getStartDateTime())
                .landingDateTime(dto.getLandingDateTime())
                .createTs(dto.getCreateTs())
                .build();

            // "ORDER BY flight.start_date_time ASC" guarantees proper flight order in the below lists
            if (dto.isReturnFlight()) {
                richItinerary.getReturnFlights().add(flight);
            } else {
                richItinerary.getOutboundFlights().add(flight);
            }

            if (richItinerary.getPrice() == null) {
                richItinerary.setPrice(Price.builder()
                    .value(dto.getValue())
                    .currency(dto.getCurrency())
                    .priceId(dto.getPriceId())
                    .createTs(dto.getPriceCreateTs())
                    .build());
            }
        });

        return new ArrayList<>(richItineraryMap.values());
    }
}
