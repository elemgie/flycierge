import { Moment } from 'moment';


export type SearchParams = {
    origin: string;
    destination: string;
    departureDate: string;
    returnDate: string | null;
    adultNumber: number;
}