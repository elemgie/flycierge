package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.Flight;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
@AllArgsConstructor
public class FlightRepository {
    private JdbcClient db;

    public Flight create(Flight flight) {
        String sql = """
            WITH already_existing_flight AS (
                SELECT * FROM flight
                WHERE origin = :origin
                AND destination = :destination
                AND airline = :airline
                AND number = :number
                AND start_date_time = :start_date_time
            ), created_flight AS (
                INSERT INTO flight(origin, destination, number, airline, start_date_time, landing_date_time)
                VALUES (:origin, :destination, :number, :airline, :start_date_time, :landing_date_time)
                ON CONFLICT DO NOTHING
                RETURNING *
            )
            SELECT * FROM created_flight
            UNION
            SELECT * FROM already_existing_flight
            """;
        return db.sql(sql)
            .params(Map.of(
                "origin", flight.getOrigin(),
                "destination", flight.getDestination(),
                "number", flight.getNumber(),
                "airline", flight.getAirline(),
                "start_date_time", flight.getStartDateTime(),
                "landing_date_time", flight.getLandingDateTime()
            )).query(Flight.class)
            .single();
    }
}
