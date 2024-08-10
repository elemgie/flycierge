package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.Airline;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@AllArgsConstructor
public class AirlineRepository {
    private JdbcClient db;

    public void upsert(Airline airline) {
        String sql = """
            INSERT INTO airline(name, iata_code, icao_code)
            VALUES (:name, :iata_code, :icao_code)
            ON CONFLICT(iata_code)
            DO UPDATE SET name = EXCLUDED.name
            """;
        db.sql(sql)
            .params(Map.of(
                "name", airline.getName(),
                "iata_code", airline.getIataCode(),
                "icao_code", airline.getIcaoCode()))
            .update();
    }

    public List<Airline> findAll() {
        String sql = "SELECT * FROM airline";
        return db.sql(sql)
            .query(Airline.class)
            .list();
    }
}
