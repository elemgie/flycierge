package com.mgieroba.flycierge.model;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class Airline {
    private long airlineId;
    private String name;
    private String iataCode;
    private String icaoCode;
    private String logoUrl;
}
