package com.mgieroba.flycierge.service.amadeus;

import com.amadeus.Amadeus;
import com.amadeus.Params;
import com.amadeus.exceptions.ResponseException;
import com.amadeus.referenceData.Locations;
import com.amadeus.resources.FlightOfferSearch;
import com.amadeus.resources.Location;
import com.mgieroba.flycierge.model.Airport;
import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Price;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.search.DestinationSearch;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.service.DestinationSearchService;
import com.mgieroba.flycierge.service.FlightSearchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Service
public class AmadeusService implements FlightSearchService, DestinationSearchService {

    private final Amadeus amadeus;

    public AmadeusService(
        @Value("${amadeus.clientId}") String amadeusClientId,
        @Value("${amadeus.clientSecret}") String amadeusClientSecret
    ) {
        this.amadeus = Amadeus
            .builder(amadeusClientId, amadeusClientSecret)
            .setHostname("production")
            .build();
    }

    public List<Airport> findAirports(String keyword) {
        try {
            Location[] fetchedLocations = amadeus.referenceData.locations.get(Params
                .with("keyword", keyword)
                .and("subType", Locations.AIRPORT));
            return Arrays.stream(fetchedLocations).map(location -> Airport.builder()
                .iataCode(location.getIataCode())
                .name(location.getName())
                .city(location.getAddress().getCityName())
                .country(location.getAddress().getCountryName())
                .countryCode(location.getAddress().getCountryCode())
                .build())
            .toList();
        } catch (ResponseException exc) {
            log.error("Error while searching airports for {}", keyword, exc);
            throw new RuntimeException(exc);
        }
    }

    public List<RichItinerary> findOffers(Search search) throws RuntimeException {
        try {
            Params amadeusRequestParams = Params
                .with("originLocationCode", search.getOrigin())
                .and("destinationLocationCode", search.getDestination())
                .and("departureDate", search.getDepartureDate().toString())
                .and("adults", search.getAdultNumber())
                .and("nonStop", search.isDirect());
            if (search.getReturnDate() != null) {
                amadeusRequestParams = amadeusRequestParams.and("returnDate", search.getReturnDate().toString());
            }

            FlightOfferSearch[] flightOfferSearches = amadeus.shopping.flightOffersSearch.get(amadeusRequestParams);

            return Arrays.stream(flightOfferSearches).map(this::parseFlightOfferSearch).toList();
        } catch (ResponseException exc) {
            throw new RuntimeException(exc);
        }
    }

    public List<RichItinerary> findDestinations(DestinationSearch search) {
        return List.of();
    }

    private RichItinerary parseFlightOfferSearch(FlightOfferSearch search) {
        List<FlightOfferSearch.Itinerary> itineraries = Arrays.asList(search.getItineraries());
        List<Flight> destinationFlights = Arrays.stream(itineraries.getFirst().getSegments())
            .map(this::parseFlight).toList();
        List<Flight> returnFlights = itineraries.size() == 1 ? List.of() :
            Arrays.stream(itineraries.getLast().getSegments()).map(this::parseFlight).toList();
        Price price = Price.builder()
            .value(search.getPrice().getTotal())
            .currency(search.getPrice().getCurrency())
            .build();
        return RichItinerary.builder()
            .outboundFlights(destinationFlights)
            .returnFlights(returnFlights)
            .price(price)
            .build();
    }

    private Flight parseFlight(FlightOfferSearch.SearchSegment searchSegment) {
        return Flight.builder()
            .number(searchSegment.getNumber())
            .origin(searchSegment.getDeparture().getIataCode())
            .destination(searchSegment.getArrival().getIataCode())
            .airline(searchSegment.getCarrierCode())
            .startDateTime(LocalDateTime.parse(searchSegment.getDeparture().getAt()))
            .landingDateTime(LocalDateTime.parse(searchSegment.getArrival().getAt()))
            .build();
    }
}
