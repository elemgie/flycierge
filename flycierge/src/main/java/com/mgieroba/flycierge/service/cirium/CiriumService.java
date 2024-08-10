package com.mgieroba.flycierge.service.cirium;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectReader;
import com.mgieroba.flycierge.model.Airline;
import com.mgieroba.flycierge.model.Airport;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@NoArgsConstructor
public class CiriumService {
    private final OkHttpClient httpClient = new OkHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();

    @Value("${cirium.appId}") private String ciriumAppId;
    @Value("${cirium.apiKey}") private String ciriumApiKey;
    private final String baseUrl = "https://api.flightstats.com/flex/";
    private final String activeAirportsEndpoint = "airports/rest/v1/json/active";
    private final String activeAirlinesEndpoint = "airlines/rest/v1/json/active";

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    private static class CiriumAirport {
        private String iata;
        private String icao;
        private String name;
        private String city;
        private String countryName;
        private String countryCode;
        private String timeZoneRegionName;
        private double latitude;
        private double longitude;
    }

    public List<Airport> fetchAirports() {
        Request request = new Request.Builder()
            .url(baseUrl + activeAirportsEndpoint)
            .header("Accept", "application/json")
            .header("appId", ciriumAppId)
            .header("appKey", ciriumApiKey)
            .build();

        try (Response response = httpClient.newCall(request).execute()) {
            JsonNode airportJsonArray = mapper.readTree(response.body().byteStream()).path("airports");
            ArrayList<Airport> airportList = new ArrayList<>();
            for (JsonNode airportNode : airportJsonArray) {
                CiriumAirport ciriumAirport = mapper.treeToValue(airportNode, CiriumAirport.class);
                if (isStringNullOrEmpty(ciriumAirport.iata) || isStringNullOrEmpty(ciriumAirport.icao)) {
                     continue; // no passenger traffic airport (general aviation)
                }
                airportList.add(
                    Airport.builder()
                        .iataCode(ciriumAirport.iata)
                        .icaoCode(ciriumAirport.icao)
                        .country(ciriumAirport.countryName)
                        .countryCode(ciriumAirport.countryCode)
                        .name(ciriumAirport.name)
                        .city(ciriumAirport.city)
                        .latitude(ciriumAirport.latitude)
                        .longitude(ciriumAirport.longitude)
                        .timeZoneRegionName(ciriumAirport.timeZoneRegionName)
                        .build());
            }
            return airportList;
        } catch (IOException | NullPointerException exc) {
            log.error("Error during fetching airports from Cirium", exc);
            throw new RuntimeException(exc);
        }
    }

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    private static class CiriumAirline {
        private String iata;
        private String icao;
        private String name;
    }

    public List<Airline> fetchAirlines() {
        Request request = new Request.Builder()
            .url(baseUrl + activeAirlinesEndpoint)
            .header("appId", ciriumAppId)
            .header("appKey", ciriumApiKey)
            .build();

        ObjectReader airlineReader = mapper.readerFor(CiriumAirline.class)
            .with(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);

        try (Response response = httpClient.newCall(request).execute()) {
            JsonNode airlineJsonArray = mapper.readTree(response.body().byteStream()).path("airlines");
            ArrayList<Airline> airlineList = new ArrayList<>();
            for (JsonNode airlineNode : airlineJsonArray) {
                CiriumAirline ciriumAirline = airlineReader.readValue(airlineNode);
                if (isStringNullOrEmpty(ciriumAirline.iata) || isStringNullOrEmpty(ciriumAirline.icao)) {
                    continue;
                }
                airlineList.add(
                    Airline.builder()
                        .iataCode(ciriumAirline.iata)
                        .icaoCode(ciriumAirline.icao)
                        .name(ciriumAirline.name)
                        .build());
            }
            return airlineList;
        } catch (IOException | NullPointerException exc) {
            log.error("Error during fetching airlines from Cirium", exc);
            throw new RuntimeException(exc);
        }
    }

    private boolean isStringNullOrEmpty(String text) {
        return text == null || text.isEmpty();
    }
}
