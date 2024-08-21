package com.mgieroba.flycierge;

import com.mgieroba.flycierge.controller.SearchController;
import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Price;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.exception.ExternalServiceOriginNotSupportedException;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.model.search.SearchResult;
import com.mgieroba.flycierge.service.FlightSearchResponseCache;
import com.mgieroba.flycierge.service.amadeus.AmadeusService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.when;

@SpringBootTest(
    webEnvironment = SpringBootTest.WebEnvironment.MOCK,
    classes = Server.class)
@AutoConfigureMockMvc
@TestPropertySource(locations = "classpath:application.test.properties")
public class FlightSearchTests extends BasicIntegrationTest {

    @MockBean private AmadeusService amadeusService;
    @Autowired private SearchController api;

    private final List<RichItinerary> exampleReturnedData = List.of(
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

    private final Search exampleSearch = Search.builder()
        .adultNumber(1)
        .origin("WRO")
        .destination("BGY")
        .departureDate(LocalDate.parse("2024-09-10"))
        .build();

    @BeforeEach
    public void reset() {
        Mockito.reset(amadeusService);
        FlightSearchResponseCache cache = new FlightSearchResponseCache();
        ReflectionTestUtils.setField(api, "responseCache", cache);
    }

    @Test
    public void basicSearchTest() throws Exception {
        insertAirportsAndAirlinesFromItineraries(exampleReturnedData);
        when(amadeusService.findOffers(any())).thenReturn(exampleReturnedData);
        when(amadeusService.getPriceMetric(any())).thenThrow(ExternalServiceOriginNotSupportedException.class);

        SearchResult result = api.search(exampleSearch);
        assertEquals(
            exampleReturnedData.getFirst().getOutboundFlights().getFirst().getNumber(),
            result.getItineraries().getFirst().getOutboundFlights().getFirst().getNumber()
        );
        assertNull(result.getPriceMetric());

        assertEquals(2, db.sql("SELECT COUNT(*) FROM flight").query(Long.class).single());
        assertEquals(1, db.sql("SELECT COUNT(*) FROM itinerary").query(Long.class).single());
    }

    @Test
    public void basicSearchDuplicationTest() throws Exception {
        insertAirportsAndAirlinesFromItineraries(exampleReturnedData);
        when(amadeusService.findOffers(any())).thenReturn(exampleReturnedData);
        when(amadeusService.getPriceMetric(any())).thenThrow(ExternalServiceOriginNotSupportedException.class);

        api.search(exampleSearch);
        api.search(exampleSearch);
        api.search(exampleSearch);

        assertEquals(2, db.sql("SELECT COUNT(*) FROM flight").query(Long.class).single());
        assertEquals(1, db.sql("SELECT COUNT(*) FROM itinerary").query(Long.class).single());
        assertEquals(2, db.sql("SELECT COUNT(*) FROM itinerary_flight").query(Long.class).single());
    }

    @Test
    public void basicSearchResultCachingTest() throws Exception {
        insertAirportsAndAirlinesFromItineraries(exampleReturnedData);
        when(amadeusService.findOffers(any())).thenReturn(exampleReturnedData);
        when(amadeusService.getPriceMetric(any())).thenThrow(ExternalServiceOriginNotSupportedException.class);

        api.search(exampleSearch);
        api.search(exampleSearch);
        api.search(exampleSearch);

        Mockito.verify(amadeusService, times(1)).findOffers(any());
    }
}
