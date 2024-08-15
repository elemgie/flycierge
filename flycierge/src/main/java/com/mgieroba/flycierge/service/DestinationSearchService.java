package com.mgieroba.flycierge.service;

import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.search.DestinationSearch;
import com.mgieroba.flycierge.repository.RichItineraryRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@AllArgsConstructor
@Service
public class DestinationSearchService {

    private RichItineraryRepository richItineraryRepository;

    public List<RichItinerary> findDestinations(DestinationSearch search) {
        List<RichItinerary> destinationSearchItineraries = richItineraryRepository.findCheapestFromInGivenDepartureInterval(
            search.getOrigin(),
            search.getDepartureRangeStart(),
            search.getDepartureRangeEnd()
        );

        return destinationSearchItineraries.stream()
            .filter(it -> it.getReturnFlights().isEmpty() != search.isReturn())
            .toList();
    }
}
