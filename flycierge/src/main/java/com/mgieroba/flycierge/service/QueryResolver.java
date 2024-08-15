package com.mgieroba.flycierge.service;

import com.mgieroba.flycierge.model.Flight;
import com.mgieroba.flycierge.model.Itinerary;
import com.mgieroba.flycierge.model.Price;
import com.mgieroba.flycierge.model.RichItinerary;
import com.mgieroba.flycierge.model.RoutePriceMetric;
import com.mgieroba.flycierge.model.exception.ExternalServiceOriginNotSupportedException;
import com.mgieroba.flycierge.model.search.DestinationSearch;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.repository.FlightRepository;
import com.mgieroba.flycierge.repository.ItineraryRepository;
import com.mgieroba.flycierge.repository.PriceRepository;
import com.mgieroba.flycierge.repository.RoutePriceMetricRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;

@Service
@AllArgsConstructor
@Slf4j
public class QueryResolver {
    private final FlightSearchService flightSearchService;
    private final DestinationSearchService internalDestinationSearchService;
    private final PriceMetricSearchService priceMetricSearchService;
    private final ItineraryRepository itineraryRepository;
    private final FlightRepository flightRepository;
    private final PriceRepository priceRepository;
    private final RoutePriceMetricRepository routePriceMetricRepository;

    private final long ROUTE_PRICE_METRIC_MAX_AGE = Duration.ofDays(3).toSeconds();

    public CompletableFuture<List<RichItinerary>> findItineraries(Search search) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                List<RichItinerary> itineraries = flightSearchService.findOffers(search);
                return saveItineraries(itineraries);
            } catch (RuntimeException exc) {
                log.error("Error while searching for flights for search id: {}", search.getSearchId(), exc);
                return List.of();
            }
        }, t -> Thread.ofVirtual().start(t));
    }

    public List<RichItinerary> findDestinations(DestinationSearch search) {
        return internalDestinationSearchService.findDestinations(search);
    }

    public CompletableFuture<RoutePriceMetric> calculateRoutePriceMetricsForSearch(Search search) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                Optional<RoutePriceMetric> maybeRoutePriceMetric = routePriceMetricRepository.findByRouteParams(
                    search.getOrigin(), search.getDestination(), search.getDepartureDate(), !search.isReturn());

                if (maybeRoutePriceMetric.isEmpty() || shouldRefreshRoutePriceMetric(maybeRoutePriceMetric.get())) {
                    return routePriceMetricRepository.upsert(priceMetricSearchService.getPriceMetric(search));
                }

                return maybeRoutePriceMetric.get();
            } catch (ExternalServiceOriginNotSupportedException exc) {
                return null;
            } catch (RuntimeException exc) {
                log.error("Error while getting price metrics for search id: {}", search.getSearchId(), exc);
                return null;
            }
        }, t -> Thread.ofVirtual().start(t));
    }

    private boolean shouldRefreshRoutePriceMetric(RoutePriceMetric metric) {
        return Instant.now().getEpochSecond() - metric.getCreateTs() > ROUTE_PRICE_METRIC_MAX_AGE;
    }

    private List<RichItinerary> saveItineraries(List<RichItinerary> itineraries) {
        return itineraries.stream().map(itinerary -> {
            List<Flight> outboundFlights = itinerary.getOutboundFlights().stream().map(flightRepository::create).toList();
            List<Flight> returnFlights = itinerary.getReturnFlights().stream().map(flightRepository::create).toList();
            Itinerary savedItinerary = itineraryRepository.create(
                Itinerary.builder()
                    .outboundFlights(outboundFlights)
                    .returnFlights(returnFlights)
                    .flightsHash(calculateItineraryFlightsHash(outboundFlights, returnFlights))
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

    private String calculateItineraryFlightsHash(List<Flight> outboundFlights, List<Flight> returnFlights) {
        BiFunction<String, Flight, String> accumulator = (acc, flight) -> acc.isBlank() ? String.valueOf(flight.getFlightId()) : acc + '/' + flight.getFlightId();
        BinaryOperator<String> _combiner = (acc1, acc2) -> acc1 + '/' + acc2;
        String outboundFlightsHash = outboundFlights.stream().reduce("", accumulator , _combiner);
        if (returnFlights.isEmpty())
            return outboundFlightsHash;
        String returnFlightsHash = returnFlights.stream().reduce("", accumulator, _combiner);
        return outboundFlightsHash + '|' + returnFlightsHash;
    }
}
