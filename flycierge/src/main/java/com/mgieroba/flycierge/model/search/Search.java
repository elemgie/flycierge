package com.mgieroba.flycierge.model.search;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class Search {
    private long searchId;
    private String origin;
    private String destination;
    private LocalDate departureDate;
    private LocalDate returnDate;
    private int adultNumber;
    private long createTs;

    public boolean isReturn() {
        return returnDate != null;
    }
}
