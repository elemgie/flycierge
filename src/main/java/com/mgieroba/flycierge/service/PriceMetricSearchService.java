package com.mgieroba.flycierge.service;

import com.mgieroba.flycierge.model.RoutePriceMetric;
import com.mgieroba.flycierge.model.exception.ExternalServiceOriginNotSupportedException;
import com.mgieroba.flycierge.model.search.Search;

public interface PriceMetricSearchService {
    RoutePriceMetric getPriceMetric(Search search) throws ExternalServiceOriginNotSupportedException;
}
