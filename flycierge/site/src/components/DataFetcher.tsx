import React, { createContext, useEffect, useState, useMemo } from 'react';
import { Client } from 'client';

import { Airport, Airline } from 'models';

export const AirportContext = createContext<Record<string, Airport>>({});
export const AirlineContext = createContext<Record<string, Airline>>({});

export function DataFetcher({ children }: React.PropsWithChildren) {
    const client = new Client('http://localhost:8080');

    const [airports, setAirports] = useState<Airport[]>();
    const [airlines, setAirlines] = useState<Airline[]>();

    useEffect(() => {
        client.fetchData<Airport[]>('/airports').then(airports => setAirports(airports));
        client.fetchData<Airline[]>('/airlines').then(airlines => setAirlines(airlines));
    }, []);

    const airportsMap = useMemo(() => {
        if (!airports) {
            return {};
        }
        return airports.reduce((result: Record<string, Airport>, airport: Airport) => {
            result[airport.iataCode] = airport;
            return result;
        }, {});
    }, [airports]);

    const airlinesMap = useMemo(() => {
        if (!airlines) {
            return {};
        }
        return airlines.reduce((result: Record<string, Airline>, airline: Airline) => {
            result[airline.iataCode] = airline;
            return result;
        }, {});
    }, [airlines]);

    return (
        <AirportContext.Provider value={airportsMap}>
            <AirlineContext.Provider value={airlinesMap}>
                {children}
            </AirlineContext.Provider>
        </AirportContext.Provider>
    );
}