package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.Price;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
@AllArgsConstructor
public class PriceRepository {

    private JdbcClient db;

    public Price create(Price price) {
        String sql = """
            INSERT INTO price (itinerary_id, value, currency)
            VALUES (:itinerary_id, :value, :currency)
            RETURNING *
            """;
        return db.sql(sql)
            .params(Map.of(
                "itinerary_id", price.getItineraryId(),
                "value", price.getValue(),
                "currency", price.getCurrency()
            ))
            .query(Price.class)
            .single();
    }
}
