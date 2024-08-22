package com.mgieroba.flycierge.service.amadeus;

import com.amadeus.Amadeus;
import com.amadeus.Params;
import com.amadeus.exceptions.ResponseException;
import com.amadeus.resources.FlightOfferSearch;
import com.amadeus.resources.ItineraryPriceMetric;
import com.amadeus.resources.Location;
import com.mgieroba.flycierge.model.Airport;
import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Price;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.RoutePriceMetric;
import com.mgieroba.flycierge.model.exception.ExternalServiceOriginNotSupportedException;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.service.AirportResolverService;
import com.mgieroba.flycierge.service.FlightSearchService;
import com.mgieroba.flycierge.service.PriceMetricSearchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
public class AmadeusService implements FlightSearchService, PriceMetricSearchService, AirportResolverService {

    private final Amadeus amadeus;
    private final String AMADEUS_NOT_SUPPORTED_ROUTE_CODE = "22443";

    public AmadeusService(
        @Value("${amadeus.clientId}") String amadeusClientId,
        @Value("${amadeus.clientSecret}") String amadeusClientSecret
    ) {
        this.amadeus = Amadeus
            .builder(amadeusClientId, amadeusClientSecret)
            .setHostname("production")
            .build();
    }

    public List<RichItinerary> findOffers(Search search) throws RuntimeException {
        try {
            Params amadeusRequestParams = Params
                .with("originLocationCode", search.getOrigin())
                .and("destinationLocationCode", search.getDestination())
                .and("departureDate", search.getDepartureDate().toString())
                .and("adults", search.getAdultNumber());
            if (search.getReturnDate() != null) {
                amadeusRequestParams = amadeusRequestParams.and("returnDate", search.getReturnDate().toString());
            }

            FlightOfferSearch[] flightOfferSearches = amadeus.shopping.flightOffersSearch.get(amadeusRequestParams);

            return Arrays.stream(flightOfferSearches).map(this::parseFlightOfferSearch).toList();
        } catch (ResponseException exc) {
            throw new RuntimeException(exc);
        }
    }

    public List<RichItinerary> findMultipleParamsOffers(Search search, List<String> originIatas, List<String> destinationIatas) {
        ArrayList<RichItinerary> results = new ArrayList<>();
        for (String originIata: originIatas) {
            for (String destinationIata: destinationIatas) {
                search.setOrigin(originIata);
                search.setDestination(destinationIata);
                List<RichItinerary> result = findOffers(search);
                results.addAll(result);
            }
        }
        return results;
    }

    public RoutePriceMetric getPriceMetric(Search search) throws ExternalServiceOriginNotSupportedException {
        try {
            Params amadeusRequestParams = Params
                .with("originIataCode", search.getOrigin())
                .and("destinationIataCode", search.getDestination())
                .and("departureDate", search.getDepartureDate())
                .and("oneWay", !search.isReturn());

            ItineraryPriceMetric[] priceMetrics = amadeus.analytics.itineraryPriceMetrics.get(amadeusRequestParams);

            if (priceMetrics.length == 0) {
                throw new ExternalServiceOriginNotSupportedException();
            }

            List<RoutePriceMetric> parsedPriceMetrics = Arrays.stream(priceMetrics).map(this::parsePriceMetric).toList();

            // API returns list but nowhere is it specified why would there be more than one record
            // It hasn't yet occurred for it to return more than one record
            return parsedPriceMetrics.getFirst();

        } catch (ResponseException exc) {
            if (exc.getCode().equals(AMADEUS_NOT_SUPPORTED_ROUTE_CODE)) {
                throw new ExternalServiceOriginNotSupportedException();
            } else {
                throw new RuntimeException(exc);
            }
        }
    }

    public List<String> getIataOfRelevantAirportsByRadius(Airport origin, long distance) {
        try {
            Params params = Params
                .with("latitude", origin.getLatitude())
                .and("longitude", origin.getLongitude())
                .and("radius", distance);

            Location[] locations = amadeus.referenceData.locations.airports.get(params);
            return Arrays.stream(locations).map(Location::getIataCode).limit(3).toList();
        } catch (ResponseException exc) {
            log.error("Exception during search for nearest airports", exc);
            return List.of(origin.getIataCode());
        }
    }

    private RoutePriceMetric parsePriceMetric(ItineraryPriceMetric metric) {
        Map<String, Double> priceQuartiles = Arrays.stream(metric.getPriceMetrics())
            .collect(Collectors.toMap(
                ItineraryPriceMetric.PriceMetrics::getQuartileRanking,
                pm -> Double.parseDouble(pm.getAmount())
            ));
        return RoutePriceMetric.builder()
            .origin(metric.getOrigin().getIataCode())
            .destination(metric.getDestination().getIataCode())
            .departureDate(LocalDate.parse(metric.getDepartureDate()))
            .oneWay(metric.getOneWay())
            .currency(metric.getCurrencyCode())
            .minimalValue(priceQuartiles.get("MINIMUM"))
            .firstQuartile(priceQuartiles.get("FIRST"))
            .secondQuartile(priceQuartiles.get("MEDIUM"))
            .thirdQuartile(priceQuartiles.get("THIRD"))
            .maximalValue(priceQuartiles.get("MAXIMUM"))
            .build();
    }

    private RichItinerary parseFlightOfferSearch(FlightOfferSearch search) {
        List<FlightOfferSearch.Itinerary> itineraries = Arrays.asList(search.getItineraries());
        List<Flight> outboundFlights = Arrays.stream(itineraries.getFirst().getSegments())
            .map(this::parseFlight).toList();
        List<Flight> returnFlights = itineraries.size() == 1 ? List.of() :
            Arrays.stream(itineraries.getLast().getSegments()).map(this::parseFlight).toList();
        Price price = Price.builder()
            .value(search.getPrice().getTotal())
            .currency(search.getPrice().getCurrency())
            .build();
        return RichItinerary.builder()
            .outboundFlights(outboundFlights)
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
