import { Itinerary, PriceMetric } from 'models';

export type SimpleSearchParams = {
    origin: string;
    destination: string;
    departureDate: string;
    returnDate: string | null;
    adultNumber: number;
    findNearestToOrigin: boolean;
    findNearestToDestination: boolean;
}

export type DestinationSearchParams = {
    origin: string;
    departureRangeStart: string;
    departureRangeEnd: string;
    adultNumber: number;
    isReturn: boolean;
}

export type SearchResult = {
    itineraries: Itinerary[];
    priceMetric: PriceMetric | null;
}

export const EMPTY_SEARCH_RESPONSE = {
    itineraries: [],
    priceMetric: null
}