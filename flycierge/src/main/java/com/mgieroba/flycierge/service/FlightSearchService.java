package com.mgieroba.flycierge.service;

import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.search.Search;

import java.util.List;

public interface FlightSearchService {
    List<RichItinerary> findOffers(Search search);
    List<RichItinerary> findMultipleParamsOffers(Search search, List<String> originIatas, List<String> destinationIatas);
}
