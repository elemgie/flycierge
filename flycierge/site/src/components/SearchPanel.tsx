import React, { useState, useCallback, useMemo, useContext } from 'react';
import { tss } from 'tss-react';

import Grid from '@mui/material/Grid';
import Button from '@mui/material/Button';
import { DatePicker } from '@mui/x-date-pickers';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Select, { SelectChangeEvent } from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import Checkbox from '@mui/material/Checkbox';
import FormControlLabel from '@mui/material/FormControlLabel';

import moment, { Moment } from 'moment';

import { SimpleSearchParams, DestinationSearchParams, SearchResult, EMPTY_SEARCH_RESPONSE, Itinerary } from 'models';
import { AirportChooser, AirportContext } from 'components';
import { Client } from 'client';

const useStyles = tss.create({
    mainGrid: {
        '> div > div': {
            backgroundColor: 'white'
        },
        alignItems: 'start',
        justifyContent: 'center',
        width: '60vw',
        marginTop: 8,
    },
    datePicker: {
        width: '21%'
    },
})

const client = new Client(process.env.REACT_APP_SERVER_URL as string);

const dateFormat = 'YYYY-MM-DDTHH:mm:ss';
const parseItineraryDates = (itinerary: Itinerary) => {
    itinerary.outboundFlights.forEach((fl: any) => {
      fl.startDateTime = moment(fl.startDateTime, dateFormat);
      fl.landingDateTime = moment(fl.landingDateTime, dateFormat);
    });
    if (itinerary.returnFlights) {
        itinerary.returnFlights.forEach((fl: any) => {
        fl.startDateTime = moment(fl.startDateTime, dateFormat);
        fl.landingDateTime = moment(fl.landingDateTime, dateFormat);
      });
    }
    return itinerary;
  };


interface SearchPanelProps {
    setIsFetching: (value: boolean) => void;
    isFetching: boolean;
    setSearchResult: (results: SearchResult | null) => void;
}

function PureFlightSearchPanel({ isFetching, setIsFetching, setSearchResult } : SearchPanelProps) {
    const { classes } = useStyles();

    const airportsMap = useContext(AirportContext);

    const [origin, setOrigin] = useState<string>('');
    const [destination, setDestination] = useState<string>('');
    const [departureDate, setDepartureDate] = useState<Moment | null>(null);
    const [returnDate, setReturnDate] = useState<Moment | null>(null);
    const [datePickerError, setDatePickerError] = useState<string | null>(null);
    const [adultNumber, setAdultNumber] = useState<number>(1);
    const [findNearestOrigins, setFindNearestOrigins] = useState<boolean>(false);
    const [findNearestDestinations, setFindNearestDestinations] = useState<boolean>(false);


    const handleOriginChange = useCallback((input: string) =>
        setOrigin(input), []);

    const handleDestinationChange = useCallback((input: string) =>
        setDestination(input), []);

    const handleDepartureDateChange = useCallback((date: Moment | null) => setDepartureDate(date), []);

    const handleReturnDateChange = useCallback((date: Moment | null) => setReturnDate(date), []);

    const handleNearestOriginsChange = useCallback((_evt: any, checked: boolean) => setFindNearestOrigins(checked), []);

    const handleNearestDestinationChange = useCallback((_evt: any, checked: boolean) => setFindNearestDestinations(checked), []);

    const validateOrigin = useMemo(() => !!airportsMap[origin], [airportsMap, origin]);

    const validateDestination = useMemo(() => !!airportsMap[destination] && destination !== origin,
    [airportsMap, destination, origin]);

    const handleSearch = useCallback(async (params: SimpleSearchParams) => {
        setSearchResult(null);
        setIsFetching(true);
        let response: SearchResult;
        try {
            response = await client.fetchData<SearchResult>('/search', 'POST', params);
            response.itineraries = response.itineraries.map(parseItineraryDates);
        } catch (error) {
            response = EMPTY_SEARCH_RESPONSE;
        }
        setSearchResult(response);
        setIsFetching(false);
      }, [setSearchResult, setIsFetching]);

    const handleSearchClick = useCallback(() => {
        if (departureDate) {
            handleSearch({origin, destination, departureDate: departureDate.format('YYYY-MM-DD'),
                returnDate: returnDate?.format('YYYY-MM-DD') || null, adultNumber,
                findNearestToOrigin: findNearestOrigins, findNearestToDestination: findNearestDestinations});
            }
    }, [origin, destination, departureDate, returnDate, adultNumber, handleSearch, findNearestOrigins, findNearestDestinations]);

    const [openDepartureDatePicker, setOpenDepartureDatePicker] = useState(false);
    const [openReturnDatePicker, setOpenReturnDatePicker] = useState(false);

    const isSearchValid = useMemo(() => {
        return validateOrigin && validateDestination && departureDate && !datePickerError;
    }, [validateOrigin, validateDestination, departureDate, datePickerError]);

    return (
            <Grid container wrap="nowrap" direction="row" spacing={1} className={classes.mainGrid}>
                <Grid item width="24%">
                    <AirportChooser label="From" value={origin} onChange={handleOriginChange}/>
                    <FormControlLabel label='Add nearby airports' control={
                        <Checkbox value={findNearestOrigins} onChange={handleNearestOriginsChange}/>
                    }/>
                </Grid>
                <Grid item width="24%" flexDirection='column'>
                    <AirportChooser label="To" value={destination} onChange={handleDestinationChange}/>
                    <FormControlLabel label='Add nearby airports' control={
                        <Checkbox value={findNearestDestinations} onChange={handleNearestDestinationChange}/>
                    }/>
                </Grid>
                <Grid item className={classes.datePicker}>
                    <DatePicker label="Departure date"
                        open={openDepartureDatePicker}
                        onClose={() => setOpenDepartureDatePicker(false)}
                        onChange={handleDepartureDateChange}
                        onError={setDatePickerError}
                        maxDate={returnDate ? returnDate : undefined}
                        disablePast
                        format='DD-MM-YYYY'
                        slotProps={{
                            openPickerIcon: {
                                onClick: () => setOpenDepartureDatePicker(true)
                            },
                            textField: {
                                onClick: () => setOpenDepartureDatePicker(true)
                            },
                            field: {
                                clearable: true
                            }
                        }}
                    />
                </Grid>
                <Grid item className={classes.datePicker}>
                    <DatePicker label="Return date"
                        open={openReturnDatePicker}
                        onClose={() => setOpenReturnDatePicker(false)}
                        onChange={handleReturnDateChange}
                        onError={setDatePickerError}
                        minDate={departureDate ? departureDate : undefined}
                        disablePast
                        format='DD-MM-YYYY'
                        slotProps={{
                            openPickerIcon: {
                                onClick: () => setOpenReturnDatePicker(true)
                            },
                            textField: {
                                onClick: () => setOpenReturnDatePicker(true)
                            },
                            field: {
                                clearable: true
                            }
                        }}
                    />
                </Grid>
                <Grid item>
                    <Button
                        variant="contained"
                        disabled={!isSearchValid || isFetching}
                        onClick={handleSearchClick}>
                            SEARCH
                    </Button>
                </Grid>
            </Grid>
    );
}

const FlightSearchPanel = React.memo(PureFlightSearchPanel);

function PureDestinationSearchPanel({ isFetching, setIsFetching, setSearchResult } : SearchPanelProps) {
    const { classes } = useStyles();

    const airportsMap = useContext(AirportContext);

    const [origin, setOrigin] = useState<string>('');
    const [departureDateRangeStart, setDepartureDateRangeStart] = useState<Moment | null>(null);
    const [departureDateRangeEnd, setDepartureDateRangeEnd] = useState<Moment | null>(null);
    const [isReturn, setIsReturn] = useState<boolean>(false);
    const [isReturnSelectString, setIsReturnSelectString] = useState<string>('one-way');
    const [adultNumber, setAdultNumber] = useState<number>(1);
    const [datePickerError, setDatePickerError] = useState<string | null>(null);
    const [findNearestOrigins, setFindNearestOrigins] = useState<boolean>(false);

    const handleIsReturnNumberChange = useCallback((event: SelectChangeEvent) => {
        setIsReturnSelectString(event.target.value);
        setIsReturn(event.target.value === 'return');
    }, []);

    const handleOriginChange = useCallback((input: string) =>
        setOrigin(input), []);

    const handleDepartureDateRangeStartChange = useCallback((date: Moment | null) =>
        setDepartureDateRangeStart(date), []);

    const handleDepartureDateRangeEndChange = useCallback((date: Moment | null) =>
        setDepartureDateRangeEnd(date), []);

    const handleFindNearestOriginsChange = useCallback((_evt: any, checked: boolean) =>
        setFindNearestOrigins(checked), []);

    const validateOrigin = useMemo(() => !!airportsMap[origin], [airportsMap, origin]);

    const handleSearch = useCallback(async (params: DestinationSearchParams) => {
        setSearchResult(null);
        setIsFetching(true);
        let response: SearchResult;
        try {
            response = await client.fetchData<SearchResult>('/search-destination', 'POST', params);
            response.itineraries = response.itineraries.map(parseItineraryDates);
        } catch (error) {
            response = EMPTY_SEARCH_RESPONSE;
        }
        setSearchResult(response);
        setIsFetching(false);
      }, [setSearchResult, setIsFetching]);

    const handleSearchClick = useCallback(() => {
        if (departureDateRangeStart && departureDateRangeEnd) {
            handleSearch({origin, departureRangeEnd: departureDateRangeEnd.format('YYYY-MM-DD'),
                departureRangeStart: departureDateRangeStart.format('YYYY-MM-DD'), adultNumber, isReturn,
                findNearestToOrigin: findNearestOrigins});
            }
    }, [origin, departureDateRangeStart, departureDateRangeEnd, isReturn, adultNumber, handleSearch]);

    const [openDepartureDatePicker, setOpenDepartureDatePicker] = useState(false);
    const [openReturnDatePicker, setOpenReturnDatePicker] = useState(false);

    const isSearchValid = useMemo(() => {
        return validateOrigin && departureDateRangeStart && departureDateRangeEnd && !datePickerError;
    }, [validateOrigin, departureDateRangeStart, departureDateRangeEnd, datePickerError]);

    return (
            <Grid container wrap="nowrap" direction="row" spacing={1} className={classes.mainGrid}>
                <Grid item width="24%">
                    <Select value={isReturnSelectString} onChange={handleIsReturnNumberChange} fullWidth>
                        <MenuItem value={'one-way'}>One way</MenuItem>
                        <MenuItem value={'return'}>Return</MenuItem>
                    </Select>
                </Grid>
                <Grid item width="24%">
                    <AirportChooser label="From" value={origin} onChange={handleOriginChange}/>
                    <FormControlLabel label='Add nearby airports' control={
                        <Checkbox value={findNearestOrigins} onChange={handleFindNearestOriginsChange}/>
                    }/>
                </Grid>
                <Grid item className={classes.datePicker}>
                    <DatePicker label="Departure range start"
                        open={openDepartureDatePicker}
                        onClose={() => setOpenDepartureDatePicker(false)}
                        onChange={handleDepartureDateRangeStartChange}
                        onError={setDatePickerError}
                        maxDate={departureDateRangeEnd ? departureDateRangeEnd : undefined}
                        disablePast
                        format='DD-MM-YYYY'
                        slotProps={{
                            openPickerIcon: {
                                onClick: () => setOpenDepartureDatePicker(true)
                            },
                            textField: {
                                onClick: () => setOpenDepartureDatePicker(true)
                            },
                            field: {
                                clearable: true
                            }
                        }}
                    />
                </Grid>
                <Grid item className={classes.datePicker}>
                    <DatePicker label="Departure range end"
                        open={openReturnDatePicker}
                        onClose={() => setOpenReturnDatePicker(false)}
                        onChange={handleDepartureDateRangeEndChange}
                        onError={setDatePickerError}
                        minDate={departureDateRangeStart ? departureDateRangeStart : undefined}
                        disablePast
                        format='DD-MM-YYYY'
                        slotProps={{
                            openPickerIcon: {
                                onClick: () => setOpenReturnDatePicker(true)
                            },
                            textField: {
                                onClick: () => setOpenReturnDatePicker(true)
                            },
                            field: {
                                clearable: true
                            }
                        }}
                    />
                </Grid>
                <Grid item>
                    <Button
                        variant="contained"
                        disabled={!isSearchValid || isFetching}
                        onClick={handleSearchClick}>
                            SEARCH
                    </Button>
                </Grid>
            </Grid>
    );
}

const DestinationSearchPanel = React.memo(PureDestinationSearchPanel);

function PureSearchPanel(props : SearchPanelProps) {
    const [tabValue, setTabValue] = useState<number>(0);

    const handleTabChange = useCallback((_evt: React.SyntheticEvent, newValue: number) => {
        setTabValue(newValue);
      }, [])

    return (
        <Grid container wrap="nowrap" direction="column">
            <Tabs value={tabValue} onChange={handleTabChange}>
                <Tab value={0} label="Flight Search" />
                <Tab value={1} label="Destination Search" />
            </Tabs>
            {tabValue === 0 && <FlightSearchPanel {...props} />}
            {tabValue === 1 && <DestinationSearchPanel {...props} />}
        </Grid>
    );
}

export const SearchPanel = React.memo(PureSearchPanel);