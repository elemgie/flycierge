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
            WITH itinerary_id AS (
                INSERT INTO itinerary DEFAULT VALUES
                RETURNING itinerary_id
            ), outbound_flights AS (
                INSERT INTO itinerary_flight (itinerary_id, flight_id, is_return_flight)
                SELECT itinerary_id, UNNEST(ARRAY[:outbound_flights]::BIGINT[]), false FROM itinerary_id
                RETURNING itinerary_id
            ), return_flights AS (
                INSERT INTO itinerary_flight (itinerary_id, flight_id, is_return_flight)
                SELECT itinerary_id, UNNEST(ARRAY[:return_flights]::BIGINT[]), true FROM itinerary_id
                RETURNING itinerary_id
            )
            SELECT itinerary_id FROM outbound_flights
            UNION
            SELECT itinerary_id FROM return_flights
            LIMIT 1
            """;
        long itineraryId = db.sql(sql)
            .param("outbound_flights", itinerary.getOutboundFlights().stream().map(Flight::getFlightId).toList())
            .param("return_flights", itinerary.getReturnFlights().stream().map(Flight::getFlightId).toList())
            .query(Long.class)
            .single();
        itinerary.setItineraryId(itineraryId);
        return itinerary;
    }
}
