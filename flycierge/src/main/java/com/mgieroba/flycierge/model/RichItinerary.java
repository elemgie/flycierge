package com.mgieroba.flycierge.model;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Getter
@Setter
public class RichItinerary extends Itinerary {
    private Price price;
}
