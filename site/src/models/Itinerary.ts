import { Flight, Price } from 'models';

export type Itinerary = {
    itineraryId: number;
    outboundFlights: Flight[];
    returnFlights: Flight[];
    price: Price;
}