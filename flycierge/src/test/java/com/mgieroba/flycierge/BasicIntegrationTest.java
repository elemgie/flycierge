package com.mgieroba.flycierge;

import com.mgieroba.flycierge.controller.SearchController;
import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Price;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.service.amadeus.AmadeusService;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.jdbc.core.simple.JdbcClient;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public abstract class BasicIntegrationTest {
    @Autowired protected JdbcClient db;
    @MockBean protected AmadeusService amadeusService;
    @Autowired protected SearchController api;

    protected final List<RichItinerary> exampleReturnedData = List.of(
        RichItinerary.builder()
            .outboundFlights(List.of(
                Flight.builder()
                    .number("1234")
                    .airline("AB")
                    .startDateTime(LocalDateTime.parse("2024-09-10T16:00:00"))
                    .landingDateTime(LocalDateTime.parse("2024-09-10T17:05:00"))
                    .origin("WRO")
                    .destination("WAW")
                    .build(),
                Flight.builder()
                    .number("5678")
                    .airline("AB")
                    .startDateTime(LocalDateTime.parse("2024-09-10T17:55:00"))
                    .landingDateTime(LocalDateTime.parse("2024-09-10T20:15:00"))
                    .origin("WAW")
                    .destination("BGY")
                    .build())
            )
            .returnFlights(List.of())
            .price(Price.builder()
                .currency("PLN")
                .value(359.95)
                .build())
            .build());

    protected final Search exampleSearch = Search.builder()
        .adultNumber(1)
        .origin("WRO")
        .destination("BGY")
        .departureDate(LocalDate.parse("2024-09-10"))
        .build();

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
