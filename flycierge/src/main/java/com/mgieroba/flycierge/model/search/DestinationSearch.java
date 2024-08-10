package com.mgieroba.flycierge.model.search;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class DestinationSearch {
    private String origin;
    private LocalDate departureRangeStart;
    private LocalDate departureRangeEnd;
    private int durationDaysRangeStart;
    private int durationsDaysRangeEnd;
    private boolean isReturn;
    private long createTs;
}
