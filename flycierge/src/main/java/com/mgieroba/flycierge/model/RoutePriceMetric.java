package com.mgieroba.flycierge.model;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Builder
@Getter
public class RoutePriceMetric {
    private double routePriceMetricId;
    private String origin;
    private String destination;
    private LocalDate departureDate;
    private String currency;
    private boolean oneWay;
    private double minimalValue;
    private double firstQuartile;
    private double secondQuartile;
    private double thirdQuartile;
    private double maximalValue;
    private long createTs;
}
