package com.mgieroba.flycierge;

import com.mgieroba.flycierge.model.exception.ExternalServiceOriginNotSupportedException;
import com.mgieroba.flycierge.model.search.SearchResult;
import com.mgieroba.flycierge.service.FlightSearchResponseCache;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.when;

@SpringBootTest(
    webEnvironment = SpringBootTest.WebEnvironment.MOCK,
    classes = Server.class)
@AutoConfigureMockMvc
public class FlightSearchTests extends BasicIntegrationTest {

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
