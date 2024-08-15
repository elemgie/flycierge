package com.mgieroba.flycierge.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Flight {
    protected long flightId;
    protected String number;
    protected String airline;
    protected String origin;
    protected String destination;
    protected LocalDateTime startDateTime;
    protected LocalDateTime landingDateTime;
    protected long createTs;
}