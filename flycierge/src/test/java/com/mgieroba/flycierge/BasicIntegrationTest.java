package com.mgieroba.flycierge;

import com.mgieroba.flycierge.model.RichItinerary;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.simple.JdbcClient;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public abstract class BasicIntegrationTest {
    @Autowired protected JdbcClient db;

    @BeforeEach
    public void clearDatabase() {
        String truncateCommandProducerSql = """
            WITH table_names AS (
                SELECT table_name
                FROM information_schema.tables
                WHERE table_schema='public'
                AND table_type='BASE TABLE'
            )
            SELECT 'TRUNCATE TABLE ' ||  table_name || ' CASCADE;' FROM table_names;
            """;
        db.sql(truncateCommandProducerSql).query(String.class).list().forEach(truncateCommand ->
            db.sql(truncateCommand).update());
        db.sql("ALTER SEQUENCE the_sequence RESTART WITH 1").update();
    }

    protected void insertAirportsAndAirlinesFromItineraries(List<RichItinerary> itineraries) {
        Set<String> airportIataSet = new HashSet<>();
        Set<String> airlineIataSet = new HashSet<>();

        itineraries.forEach(it -> it.getOutboundFlights().forEach(flight -> {
            airportIataSet.add(flight.getOrigin());
            airportIataSet.add(flight.getDestination());
            airlineIataSet.add(flight.getAirline());
        }));
        itineraries.forEach(it -> it.getReturnFlights().forEach(flight -> {
            airportIataSet.add(flight.getOrigin());
            airportIataSet.add(flight.getDestination());
            airlineIataSet.add(flight.getAirline());
        }));
        String airportSql = """
            INSERT INTO airport (name, iata_code, icao_code, city, country, country_code)
            SELECT 'test_name', unnest(ARRAY[:airports]), unnest(ARRAY[:airports]) || '/', 'test_city', 'test_country', 'AB'
            """;
        db.sql(airportSql)
            .param("airports", airportIataSet.stream().toList())
            .update();

        String airlineSql = """
            INSERT INTO airline (name, iata_code, icao_code)
            SELECT 'test_name', unnest(ARRAY[:airlines]), unnest(ARRAY[:airlines]) || '/'
            """;
        db.sql(airlineSql)
            .param("airlines", airlineIataSet.stream().toList())
            .update();
    }
}
