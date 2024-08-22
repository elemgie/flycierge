package com.mgieroba.flycierge.repository;

import com.mgieroba.flycierge.model.search.Search;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@AllArgsConstructor
public class SearchRepository {
    private final JdbcClient db;

    public List<Search> findAll() {
        return db.sql("SELECT * FROM search")
            .query(Search.class)
            .list();
    }

    public Search create(Search search) {
        String sql = """
            INSERT INTO search(origin, destination, departure_date, return_date, adult_number, create_ts,
                find_nearest_to_origin, find_nearest_to_destination)
            VALUES (:origin, :destination, :departure_date, :return_date, :adult_number, :create_ts,
                :find_nearest_to_origin, :find_nearest_to_destination)
            RETURNING *
            """;
        return db.sql(sql)
            .params(Map.of(
                "origin", search.getOrigin(),
                "destination", search.getDestination(),
                "departure_date", search.getDepartureDate(),
                "adult_number", search.getAdultNumber(),
                "create_ts", search.getCreateTs(),
                "find_nearest_to_origin", search.isFindNearestToOrigin(),
                "find_nearest_to_destination", search.isFindNearestToDestination()
            ))
            .param("return_date", search.getReturnDate())
            .query(Search.class)
            .single();
    }
}
