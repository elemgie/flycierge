package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Itinerary;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

@Repository
@AllArgsConstructor
public class ItineraryRepository {
    private JdbcClient db;

    public Itinerary create(Itinerary itinerary) {
        String sql = """
            WITH maybe_old_itinerary AS (
                SELECT itinerary_id FROM itinerary
                WHERE flights_hash = :flights_hash
            ), maybe_new_itinerary AS (
                INSERT INTO itinerary (flights_hash)
                VALUES (:flights_hash)
                ON CONFLICT DO NOTHING
                RETURNING itinerary_id
            ), upserted_itinerary AS (
                SELECT itinerary_id FROM maybe_old_itinerary
                UNION
                SELECT itinerary_id FROM maybe_new_itinerary
            ), outbound_flights AS (
                INSERT INTO itinerary_flight (itinerary_id, flight_id, is_return_flight)
                SELECT itinerary_id, UNNEST(ARRAY[:outbound_flights]::BIGINT[]), false FROM upserted_itinerary
                ON CONFLICT DO NOTHING
                RETURNING itinerary_id
            ), return_flights AS (
                INSERT INTO itinerary_flight (itinerary_id, flight_id, is_return_flight)
                SELECT itinerary_id, UNNEST(ARRAY[:return_flights]::BIGINT[]), true FROM upserted_itinerary
                ON CONFLICT DO NOTHING
                RETURNING itinerary_id
            )
            SELECT itinerary_id FROM outbound_flights
            UNION
            SELECT itinerary_id FROM return_flights
            UNION
            SELECT itinerary_id FROM upserted_itinerary
            LIMIT 1
            """;
        long itineraryId = db.sql(sql)
            .param("outbound_flights", itinerary.getOutboundFlights().stream().map(Flight::getFlightId).toList())
            .param("return_flights", itinerary.getReturnFlights().stream().map(Flight::getFlightId).toList())
            .param("flights_hash", itinerary.getFlightsHash())
            .query(Long.class)
            .single();
        itinerary.setItineraryId(itineraryId);
        return itinerary;
    }
}
