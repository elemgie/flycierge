package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.Airport;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@AllArgsConstructor
public class AirportRepository {
    private JdbcClient db;

    public void upsert(Airport airport) {
        String sql = """
            INSERT INTO airport(name, city, country, country_code, iata_code, icao_code, longitude, latitude, time_zone_region_name)
            VALUES (:name, :city, :country, :country_code, :iata_code, :icao_code, :longitude, :latitude, :time_zone_region_name)
            ON CONFLICT(iata_code)
            DO UPDATE SET name = EXCLUDED.name
            """;
        db.sql(sql)
            .params(Map.of(
                "name", airport.getName(),
                "city", airport.getCity(),
                "country", airport.getCountry(),
                "country_code", airport.getCountryCode(),
                "iata_code", airport.getIataCode(),
                "icao_code", airport.getIcaoCode(),
                "longitude", airport.getLongitude(),
                "latitude", airport.getLatitude(),
                "time_zone_region_name", airport.getTimeZoneRegionName()))
            .update();
    }

    public Airport findByIata(String origin) {
        String sql = """
            SELECT * FROM airport
            WHERE iata_code = :origin
            """;
        return db.sql(sql)
            .param("origin", origin)
            .query(Airport.class)
            .single();
    }

    public List<Airport> findAll() {
        String sql = "SELECT * FROM airport";
        return db.sql(sql)
            .query(Airport.class)
            .list();
    }

    public void bumpSearchCount(String airportIataCode) {
        String sql = """
            UPDATE airport SET search_count = search_count + 1
            WHERE iata_code = :iata_code
            """;
        db.sql(sql)
            .param("iata_code", airportIataCode)
            .update();
    }
}