package com.mgieroba.flycierge.model;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class Airport {
    private long airportId;
    private String name;
    private String city;
    private String country;
    private String countryCode;
    private String iataCode;
    private String icaoCode;
    private double longitude;
    private double latitude;
    private String timeZoneRegionName;
}
