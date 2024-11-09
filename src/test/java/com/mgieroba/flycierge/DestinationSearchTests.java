package com.mgieroba.flycierge;

import com.mgieroba.flycierge.model.exception.ExternalServiceOriginNotSupportedException;
import com.mgieroba.flycierge.model.search.DestinationSearch;
import com.mgieroba.flycierge.model.search.SearchResult;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@SpringBootTest
public class DestinationSearchTests extends BasicIntegrationTest {

    @Test
    public void testNormalDestinationSearch() throws Exception {
        insertAirportsAndAirlinesFromItineraries(exampleReturnedData);
        when(amadeusService.findOffers(any())).thenReturn(exampleReturnedData);
        when(amadeusService.getPriceMetric(any())).thenThrow(ExternalServiceOriginNotSupportedException.class);

        api.search(exampleSearch);

        DestinationSearch matchingDestinationSearch = DestinationSearch.builder()
            .origin(exampleSearch.getOrigin())
            .departureRangeStart(exampleSearch.getDepartureDate().minusDays(3))
            .departureRangeEnd(exampleSearch.getDepartureDate().plusDays(3))
            .isReturn(false)
            .build();

        SearchResult matchedResult = api.searchDestination(matchingDestinationSearch);
        assertEquals(1, matchedResult.getItineraries().size());
        assertNull(matchedResult.getPriceMetric());

        DestinationSearch notMatchingDestinationSearch = DestinationSearch.builder()
            .origin(exampleSearch.getOrigin())
            .departureRangeStart(exampleSearch.getDepartureDate().plusDays(1))
            .departureRangeEnd(exampleSearch.getDepartureDate().plusDays(2))
            .isReturn(false)
            .build();

        SearchResult notMatchedResult = api.searchDestination(notMatchingDestinationSearch);
        assertEquals(0, notMatchedResult.getItineraries().size());
        assertNull(notMatchedResult.getPriceMetric());
    }
}
