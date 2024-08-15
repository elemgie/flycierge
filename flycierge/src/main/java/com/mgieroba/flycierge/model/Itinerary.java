package com.mgieroba.flycierge.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.util.List;

@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
public class Itinerary {
    protected long itineraryId;
    protected List<Flight> outboundFlights;
    protected List<Flight> returnFlights;
    protected String flightsHash;

    public String getOrigin() {
        return outboundFlights.getFirst().getOrigin();
    }

    public String getDestination() {
        return outboundFlights.getLast().getDestination();
    }
}
