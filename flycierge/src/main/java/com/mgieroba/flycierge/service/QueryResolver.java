package com.mgieroba.flycierge.service;

import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Itinerary;
import com.mgieroba.flycierge.model.Price;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.search.DestinationSearch;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.repository.FlightRepository;
import com.mgieroba.flycierge.repository.ItineraryRepository;
import com.mgieroba.flycierge.repository.PriceRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
@Slf4j
public class QueryResolver {
    private final FlightSearchService flightSearchService;
    private final DestinationSearchService destinationSearchService;
    private final ItineraryRepository itineraryRepository;
    private final FlightRepository flightRepository;
    private final PriceRepository priceRepository;

    public List<RichItinerary> findItineraries(Search search) {
        try {
            List<RichItinerary> itineraries = flightSearchService.findOffers(search);
            return saveItineraries(itineraries);
        } catch (RuntimeException exc) {
            log.error("Error while searching for flights for search id: {}", search.getSearchId(), exc);
            return List.of();
        }
    }

    public List<RichItinerary> findDestinations(DestinationSearch search) {
        return destinationSearchService.findDestinations(search);
    }

    private List<RichItinerary> saveItineraries(List<RichItinerary> itineraries) {
        return itineraries.stream().map(itinerary -> {
            List<Flight> outboundFlights = itinerary.getOutboundFlights().stream().map(flightRepository::create).toList();
            List<Flight> returnFlights = itinerary.getReturnFlights().stream().map(flightRepository::create).toList();
            Itinerary savedItinerary = itineraryRepository.create(
                Itinerary.builder()
                    .outboundFlights(outboundFlights)
                    .returnFlights(returnFlights)
                    .build());
            Price price = itinerary.getPrice();
            price.setItineraryId(savedItinerary.getItineraryId());
            price = priceRepository.create(price);
            return (RichItinerary) RichItinerary.builder()
                .itineraryId(savedItinerary.getItineraryId())
                .outboundFlights(outboundFlights)
                .returnFlights(returnFlights)
                .price(price)
                .build();
        }).toList();
    }
}
