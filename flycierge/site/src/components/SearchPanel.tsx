import React, { useState, useCallback, useMemo } from 'react';
import { tss } from 'tss-react';

import TextField from '@mui/material/TextField';
import Grid from '@mui/material/Grid';
import Button from '@mui/material/Button';
import { DatePicker , LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterMoment } from '@mui/x-date-pickers/AdapterMoment';
import { Moment } from 'moment';

import { SearchParams } from 'models';

const useStyles = tss.create({
    mainGrid: {
        '> div > div': {
            backgroundColor: 'white'
          },
        alignItems: 'center',
    }
})

interface SearchPanelProps {
    onSearch: (params: SearchParams) => void;
}

function PureSearchPanel({ onSearch } : SearchPanelProps) {
    const { classes } = useStyles();

    const [origin, setOrigin] = useState<string>('');
    const [destination, setDestination] = useState<string>('');
    const [departureDate, setDepartureDate] = useState<Moment | null>(null);
    const [returnDate, setReturnDate] = useState<Moment | null>(null);
    const [datePickerError, setDatePickerError] = useState<string | null>(null);
    const [adultNumber, setAdultNumber] = useState<number>(1);

    const handleOriginChange = useCallback((evt: React.ChangeEvent<HTMLInputElement>) => 
        setOrigin(evt.target.value), []);

    const handleDestinationChange = useCallback((evt: React.ChangeEvent<HTMLInputElement>) => 
        setDestination(evt.target.value), []);

    const handleDepartureDateChange = useCallback((date: Moment | null) =>
        setDepartureDate(date), []);

    const handleReturnDateChange = useCallback((date: Moment | null) =>
        setReturnDate(date), []);

    const handleSearchClick = useCallback(() => {
        if (departureDate) {
            onSearch({origin, destination, departureDate: departureDate.format('YYYY-MM-DD'),
                returnDate: returnDate?.format('YYYY-MM-DD') || null, adultNumber});
            }
    }, [origin, destination, departureDate, returnDate, adultNumber]);

    const [open, setOpen] = useState(false);

    const isSearchValid = useMemo(() => {
        return origin && destination && departureDate && !datePickerError;
    }, [origin, destination, departureDate, datePickerError]);

    return (
        <Grid container wrap="nowrap" direction="row" spacing={1} className={classes.mainGrid}>
            <Grid item>
                <TextField label="From" value={origin} onChange={handleOriginChange}/>
            </Grid>
            <Grid item>
                <TextField label="To" value={destination} onChange={handleDestinationChange}/>
            </Grid>
            <Grid item>
                <LocalizationProvider dateAdapter={AdapterMoment}>
                    <DatePicker label="Departure date" onChange={handleDepartureDateChange} onError={setDatePickerError} disablePast format='DD-MM-YYYY'/>
                </LocalizationProvider>
            </Grid>
            <Grid item>
                <LocalizationProvider dateAdapter={AdapterMoment}>
                    <DatePicker label="Return date" open={open} onClose={() => setOpen(false)} onChange={handleReturnDateChange} disablePast
                    slotProps={{textField: {
                        onClick: () => setOpen(true)
                    }}}
                    />
                </LocalizationProvider>
            </Grid>
            <Grid item>
                <Button
                    variant="contained"
                    disabled={!isSearchValid}
                    onClick={handleSearchClick}>
                        SEARCH
                </Button>
            </Grid>
        </Grid>
    );
}

export const SearchPanel = React.memo(PureSearchPanel);