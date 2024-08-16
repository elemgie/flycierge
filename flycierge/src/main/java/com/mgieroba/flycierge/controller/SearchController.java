package com.mgieroba.flycierge.controller;

import com.mgieroba.flycierge.model.Airline;
import com.mgieroba.flycierge.model.Airport;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.RoutePriceMetric;
import com.mgieroba.flycierge.model.search.DestinationSearch;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.model.search.SearchResult;
import com.mgieroba.flycierge.repository.AirlineRepository;
import com.mgieroba.flycierge.repository.AirportRepository;
import com.mgieroba.flycierge.repository.SearchRepository;
import com.mgieroba.flycierge.service.QueryResolver;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@RestController
@AllArgsConstructor
public class SearchController {

    private final SearchRepository searchRepository;
    private final QueryResolver queryResolver;
    private final AirportRepository airportRepository;
    private final AirlineRepository airlineRepository;

    @PostMapping("/search")
    public SearchResult search(@RequestBody Search searchRequest) {
        searchRequest.setCreateTs(getNowTs());
        Search search = searchRepository.create(searchRequest);
        airportRepository.bumpSearchCount(searchRequest.getOrigin());

        CompletableFuture<List<RichItinerary>> itinerariesFuture = queryResolver.findItineraries(search);
        CompletableFuture<RoutePriceMetric> priceMetricsFuture = queryResolver.calculateRoutePriceMetricsForSearch(search);

        return new SearchResult(itinerariesFuture.join(), priceMetricsFuture.join());
    }

    @PostMapping("/search-destination")
    public SearchResult searchDestination(@RequestBody DestinationSearch searchRequest) {
        searchRequest.setCreateTs(getNowTs());
        airportRepository.bumpSearchCount(searchRequest.getOrigin());

        return new SearchResult(queryResolver.findDestinations(searchRequest), null);
    }

    @GetMapping("/airports")
    public List<Airport> fetchAirports() {
        return airportRepository.findAll();
    }

    @GetMapping("/airlines")
    public List<Airline> fetchAirlines() {
        return airlineRepository.findAll();
    }

    private long getNowTs() {
        return Instant.now().getEpochSecond();
    }
}
