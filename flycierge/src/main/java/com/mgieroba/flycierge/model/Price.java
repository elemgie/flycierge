package com.mgieroba.flycierge.model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Builder
public class Price {
    private long priceId;
    @Setter private long itineraryId;
    private double value;
    private String currency;
    private long createTs;
}
