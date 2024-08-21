package com.mgieroba.flycierge.model.search;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Builder
public class DestinationSearch {
    private long destinationSearchId;
    private String origin;
    private LocalDate departureRangeStart;
    private LocalDate departureRangeEnd;
    @Setter(AccessLevel.NONE) private boolean isReturn;
    private long createTs;

    // Needed due to a specific Lombok convention for naming getter/setter of a boolean field; Lombok would create 'setReturn'
    public void setIsReturn(boolean isReturn) {
        this.isReturn = isReturn;
    }
}
