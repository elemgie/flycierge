package com.mgieroba.flycierge.controller;

import com.mgieroba.flycierge.model.Airline;
import com.mgieroba.flycierge.model.Airport;
import com.mgieroba.flycierge.model.search.DestinationSearch;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.repository.AirlineRepository;
import com.mgieroba.flycierge.repository.AirportRepository;
import com.mgieroba.flycierge.repository.SearchRepository;
import com.mgieroba.flycierge.service.QueryResolver;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

@RestController
@AllArgsConstructor
public class SearchController {

    private final SearchRepository searchRepository;
    private final QueryResolver queryResolver;
    private final AirportRepository airportRepository;
    private final AirlineRepository airlineRepository;

    @PostMapping("/search")
    public List<RichItinerary> search(@RequestBody Search searchRequest) {
        searchRequest.setCreateTs(getNowTs());
        Search search = searchRepository.create(searchRequest);
        List<RichItinerary> itineraries = queryResolver.findItineraries(search);
//      price history download
        return itineraries;
    }

    @PostMapping("/search-destination")
    public List<RichItinerary> searchDestination(@RequestBody DestinationSearch searchRequest) {
        searchRequest.setCreateTs(getNowTs());
        return queryResolver.findDestinations(searchRequest);
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
        return LocalDateTime.now().atZone(ZoneId.of("Europe/Warsaw")).toEpochSecond();
    }
}
