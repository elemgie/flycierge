package com.mgieroba.flycierge.model;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.util.ArrayList;

@SuperBuilder
@Getter
@Setter
public class RichItinerary extends Itinerary {

    public RichItinerary(long itineraryId) {
        this.itineraryId = itineraryId;
        this.outboundFlights = new ArrayList<>();
        this.returnFlights = new ArrayList<>();
    }

    private Price price;
}
