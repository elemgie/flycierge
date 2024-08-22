package com.mgieroba.flycierge.service;

import com.mgieroba.flycierge.model.Airport;

import java.util.List;

public interface AirportResolverService {
    List<String> getIataOfRelevantAirportsByRadius(Airport origin, long distance);
}
