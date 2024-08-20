package com.mgieroba.flycierge.worker;

import com.mgieroba.flycierge.model.Airline;
import com.mgieroba.flycierge.model.Airport;
import com.mgieroba.flycierge.repository.AirlineRepository;
import com.mgieroba.flycierge.repository.AirportRepository;
import com.mgieroba.flycierge.service.cirium.CiriumService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
@AllArgsConstructor
public class AirportAirlineFetcherWorker {

    private AirportRepository airportRepository;
    private AirlineRepository airlineRepository;

    private CiriumService ciriumClient;

    @Scheduled(fixedDelayString="P30D")
    public void refreshAirports() {
        log.info("Beginning refreshing airports");
        List<Airport> fetchedAirports = ciriumClient.fetchAirports();
        fetchedAirports.forEach(airportRepository::upsert);
        log.info("Successfully refreshed airports");
    }

    @Scheduled(fixedDelayString="P30D")
    public void refreshAirlines() {
        log.info("Beginning refreshing airlines");
        List<Airline> fetchedAirlines = ciriumClient.fetchAirlines();
        fetchedAirlines.forEach(airlineRepository::upsert);
        log.info("Successfully refreshed airlines");
    }
}
