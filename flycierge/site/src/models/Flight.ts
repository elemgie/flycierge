import { Moment } from 'moment';

export type Flight = {
    flightId: number;
    number: string;
    airline: string;
    origin: string;
    destination: string;
    startDateTime: Moment;
    landingDateTime: Moment;
}