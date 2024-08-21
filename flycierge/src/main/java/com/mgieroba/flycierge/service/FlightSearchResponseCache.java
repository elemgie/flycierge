package com.mgieroba.flycierge.service;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.mgieroba.flycierge.model.search.Search;
import com.mgieroba.flycierge.model.search.SearchResult;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.util.Optional;

@Service
@NoArgsConstructor
@Scope(value = ConfigurableBeanFactory.SCOPE_SINGLETON)
public class FlightSearchResponseCache {

    @EqualsAndHashCode
    private static class SearchParams {
        private final String origin;
        private final String destination;
        private final LocalDate departureDate;
        private final LocalDate returnDate;
        private final int adultNumber;

        public SearchParams(Search search) {
            this.origin = search.getOrigin();
            this.destination = search.getDestination();
            this.departureDate = search.getDepartureDate();
            this.returnDate = search.getReturnDate();
            this.adultNumber = search.getAdultNumber();
            }
        }

    private final Cache<FlightSearchResponseCache.SearchParams, SearchResult> cache = Caffeine.newBuilder()
        .expireAfterWrite(Duration.ofMinutes(15))
        .maximumSize(1000)
        .build();

    public Optional<SearchResult> getFor(Search search) {
        SearchParams params = new SearchParams(search);
        SearchResult maybeResult = cache.getIfPresent(params);
        return Optional.ofNullable(maybeResult);
    }

    public void put(Search search, SearchResult result) {
        SearchParams params = new SearchParams(search);
        cache.put(params, result);
    }

}
