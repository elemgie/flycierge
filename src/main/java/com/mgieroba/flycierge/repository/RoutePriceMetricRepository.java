package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.RoutePriceMetric;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Map;
import java.util.Optional;

@AllArgsConstructor
@Repository
public class RoutePriceMetricRepository {

    private JdbcClient db;

    public RoutePriceMetric upsert(RoutePriceMetric metric) {
        String sql = """
            INSERT INTO route_price_metric (origin, destination, departure_date, currency, one_way,
                minimal_value, first_quartile, second_quartile, third_quartile, maximal_value)
            VALUES (:origin, :destination, :departure_date, :currency, :one_way, :minimal_value, :first_quartile,
                :second_quartile, :third_quartile, :maximal_value)
            ON CONFLICT (origin, destination, departure_date, one_way)
            DO UPDATE SET
            currency = EXCLUDED.currency, minimal_value = EXCLUDED.minimal_value, first_quartile = EXCLUDED.first_quartile,
            second_quartile = EXCLUDED.second_quartile, third_quartile = EXCLUDED.third_quartile,
            maximal_value = EXCLUDED.maximal_value, create_ts = EXTRACT(EPOCH FROM NOW())
            RETURNING *
            """;
        return db.sql(sql)
            .params(Map.of(
                "origin", metric.getOrigin(),
                "destination", metric.getDestination(),
                "departure_date", metric.getDepartureDate(),
                "currency", metric.getCurrency(),
                "one_way", metric.isOneWay(),
                "minimal_value", metric.getMinimalValue(),
                "first_quartile", metric.getFirstQuartile(),
                "second_quartile", metric.getSecondQuartile(),
                "third_quartile", metric.getThirdQuartile(),
                "maximal_value", metric.getMaximalValue()
            ))
            .query(RoutePriceMetric.class)
            .single();
    }

    public Optional<RoutePriceMetric> findByRouteParams(String origin, String destination,
                                                        LocalDate departureDate, boolean isOneWay) {
        String sql = """
            SELECT * FROM route_price_metric
            WHERE origin = :origin
            AND destination = :destination
            AND departure_date = :departure_date
            AND one_way = :one_way
            """;
        return db.sql(sql)
            .params(Map.of(
                "origin", origin,
                "destination", destination,
                "departure_date", departureDate,
                "one_way", isOneWay
            ))
            .query(RoutePriceMetric.class)
            .optional();
    }
}
