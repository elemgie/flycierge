package com.mgieroba.flycierge.model.search;

import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.RoutePriceMetric;
import jakarta.annotation.Nullable;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

/**
 * Returned for every search request consisting of found itineraries (with prices) and (possibly) price metrics
 * For destination search there is no price band as there are multiple different routes considered
 * There might be no price band for ordinary search if the route is not supported
 */
@AllArgsConstructor
@Getter
public class SearchResult {
    private List<RichItinerary> itineraries;
    @Nullable private RoutePriceMetric priceMetrics;
}
