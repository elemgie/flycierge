import React, { useContext, useMemo } from 'react';
import { tss } from 'tss-react';

import Dialog from '@mui/material/Dialog';
import DialogContent from '@mui/material/DialogContent';
import DialogTitle from '@mui/material/DialogTitle';
import Box from '@mui/material/Box';
import Divider from '@mui/material/Divider';
import Typography from '@mui/material/Typography';

import { Itinerary, Flight } from 'models';
import { AirportContext, AirlineContext } from 'components';
import { timeElapsedString } from 'utils';

const useStyles = tss.create({
    dialogContent: {
        backgroundColor: '#F1F1F1',
    },
    itineraryCard: {
        margin: 8,
    },
    flightCard: {
        margin: 8,
        padding: 8,
        borderRadius: 5,
        borderStyle: 'solid',
        borderColor: 'grey',
        borderWidth: 2,
        display: 'flex',
        flexDirection: 'row',
        backgroundColor: 'white',
        justifyContent: 'space-between'
    },
    verticalDivider: {
        height: '3vh',
        borderRightWidth: 2,
        alignSelf: 'start',
        margin: 8
    },
    airlineBox: {
        justifyContent: 'center',
        alignItems: 'center'
    },
    rowHeader: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center'
    }
});

interface FlightCardProps {
    flight: Flight;
}

function PureFlightCard({ flight }: FlightCardProps) {
    const { classes } = useStyles();

    const airlinesMap = useContext(AirlineContext);
    const airportsMap = useContext(AirportContext);

    const flightDurationString = useMemo(() => 
        timeElapsedString(flight.landingDateTime.diff(flight.startDateTime, 's')), [flight]);

    return <Box className={classes.flightCard}>
        <Box display='flex' flexDirection='column'>
            <Box display='flex' flexDirection='row'>
                <Box>
                    <Typography align='right'>{flight.startDateTime.format("HH:mm")}</Typography>
                    <Typography align='right' color='grey' variant='body2'>{flight.startDateTime.format("ddd DD MMM")}</Typography>
                </Box>
                <Box marginLeft={1}>
                    <Typography fontWeight='bold'>{flight.origin} | {airportsMap[flight.origin].city}</Typography>
                    <Typography color='grey' variant='body2'>{airportsMap[flight.origin].name}</Typography>
                </Box>
            </Box>
            <Box display='flex' flexDirection='row' alignItems='center' justifyContent='center'>
                <Divider orientation='vertical' className={classes.verticalDivider} flexItem/>
                <Typography variant='body2' color='grey'>{flightDurationString}</Typography>
            </Box>
            <Box display='flex' flexDirection='row'>
                <Box>
                    <Typography align='right'>{flight.landingDateTime.format("HH:mm")}</Typography>
                    <Typography align='right' color='grey' variant='body2'>{flight.landingDateTime.format("ddd DD MMM")}</Typography>
                </Box>
                <Box marginLeft={1}>
                    <Typography fontWeight='bold'>{flight.destination} | {airportsMap[flight.destination].city}</Typography>
                    <Typography color='grey' variant='body2'>{airportsMap[flight.destination].name}</Typography>
                </Box>
            </Box>
        </Box>
        <Box className={classes.airlineBox} display='flex' flexDirection='column' width='30%'>
            <Typography>{airlinesMap[flight.airline].name}</Typography>
            <Typography variant='body2' color='grey'>{flight.airline}{flight.number}</Typography>
        </Box>
    </Box>;
}

const FlightCard = React.memo(PureFlightCard);

interface OneWayFlightsCardProps {
    flights: Flight[];
}

function PureOneWayFlightsCard({ flights }: OneWayFlightsCardProps) {
    const { classes } = useStyles();

    const airportsMap = useContext(AirportContext);
    const lastFlight = flights[flights.length - 1];
    const routeOrigin = airportsMap[flights[0].origin];
    const routeDestination = airportsMap[lastFlight.destination];
    const durationString = timeElapsedString(
        lastFlight.landingDateTime.diff(flights[0].startDateTime, 's'));

    return <Box className={classes.itineraryCard}>
        <Box className={classes.rowHeader}>
            <Typography fontWeight='bold'>
                {`${routeOrigin.city} → ${routeDestination.city}`}
            </Typography>
            <Typography fontWeight='bold' variant='body2'>
                {durationString}
            </Typography>
        </Box> 
        {flights.map(fl => <FlightCard flight={fl} />)}
    </Box>;
}

const OneWayFlightsCard = React.memo(PureOneWayFlightsCard);

interface ItineraryDialogParams {
    itinerary: Itinerary;
    onClose: () => void;
}

function PureItineraryDialog({ itinerary, onClose }: ItineraryDialogParams) {
    const { classes } = useStyles();

    return <Dialog open onClose={onClose} fullWidth>
        <DialogTitle>
            <Box className={classes.rowHeader}>
                <Typography variant='h5'>Itinerary details</Typography>
                <Typography variant='h5'>{itinerary.price.value.toFixed(2)} {itinerary.price.currency}</Typography>
            </Box>
        </DialogTitle>
        <DialogContent className={classes.dialogContent}>
            <OneWayFlightsCard flights={itinerary.outboundFlights} />
            {itinerary.returnFlights.length > 0 && <>
                <Divider orientation='horizontal'/>
                <OneWayFlightsCard flights={itinerary.returnFlights} />
            </>}
        </DialogContent>
    </Dialog>;
}

export const ItineraryDialog = React.memo(PureItineraryDialog);