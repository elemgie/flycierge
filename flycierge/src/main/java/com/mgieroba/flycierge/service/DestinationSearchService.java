package com.mgieroba.flycierge.service;

import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.search.DestinationSearch;

import java.util.List;

public interface DestinationSearchService {
    List<RichItinerary> findDestinations(DestinationSearch destinationSearch);
}
