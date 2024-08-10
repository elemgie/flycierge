import { Moment } from 'moment';


export type SearchParams = {
    origin: string;
    destination: string;
    departureDate: Moment;
    returnDate: Moment | null;
    adultNumber: number;
}