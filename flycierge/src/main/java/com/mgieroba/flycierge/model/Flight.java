package com.mgieroba.flycierge.model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
public class Flight {
    private long flightId;
    private String number;
    private String airline;
    private String origin;
    private String destination;
    private LocalDateTime startDateTime;
    private LocalDateTime landingDateTime;
}
