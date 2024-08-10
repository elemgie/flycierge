import React, { useMemo, PropsWithChildren, useContext } from 'react';
import { tss } from 'tss-react';

import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import Tooltip from '@mui/material/Tooltip';
import Chip from '@mui/material/Chip';
import Stack from '@mui/material/Stack';

import { Itinerary, Flight } from 'models';
import { timeElapsedString } from 'utils';
import { AirportContext, AirlineContext } from 'components';

const useStyles = tss.create({
    mainBox: {
        borderColor: 'grey',
        borderStyle: 'solid',
        borderWidth: 1,
        borderRadius: 10,
        boxShadow: "1px 1px 1px 1px black",
        width: '100%',
        justifyContent: 'space-between',
        display: 'flex',
        flexDirection: 'row',
        backgroundColor: 'rgba(245,247,249)',
    },
    sumBox: {
        width: '80%',
        display: 'flex',
        flexDirection: 'column'
    },
    flightsBox: {
        borderRadius: 2,
        display: 'flex',
        flexDirection: 'column',
        width: '82%',
        flexWrap: 'nowrap',
        padding: 8,
        justifyContent: 'center'
    },
    priceBox: {
        borderRadius: 2,
        alignItems: 'center',
        justifyContent: 'center',
        width: '20%',
        display: 'flex',
        flexWrap: 'nowrap',
        padding: 8
    },
    locations: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between',
        flexWrap: 'nowrap'
    },
    schedules: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        flexWrap: 'nowrap'
    },
    locationsDivider: {
        flexGrow: 1,
        alignSelf: 'center',
        marginLeft: 8,
        marginRight: 8,
        borderBottomWidth: 2
    },
    verticalDivider: {
        borderRightWidth: 2,
        color: 'grey'
    },
    directChip: {
        backgroundColor: "#5CD2E6"
    },
    airlineBox: {
        alignItems: 'center',
        justifyContent: 'center',
        display: 'flex',
        width: '18%',
        padding: 8,
        textAlign: 'center'
    },
    airlineTypography: {
        wordBreak: 'break-word'
    }
})

const isDirectFlight = (flights: Flight[]) => flights.length === 1;

interface LayoverTooltipProps extends PropsWithChildren {
    flights: Flight[];
    children: JSX.Element;
}

function PureLayoverTooltip({ flights, children }: PropsWithChildren<LayoverTooltipProps>) {

    const layoversInfo = useMemo(() => flights.slice(0, -1).map((flight, idx) => {
        const nextFlight = flights[idx + 1];
        const layoverDurationString = timeElapsedString(nextFlight.startDateTime.diff(flight.landingDateTime, 's'));
        const layoverString = flight.destination === nextFlight.origin ?
            `Layover at ${flight.destination} (${layoverDurationString})` :
            `Layover ${flight.destination} → ${nextFlight.origin} (${layoverDurationString})`;
        return <span>{layoverString}</span>
    }), [flights]);

    return <Tooltip title={<Stack direction='column'>{layoversInfo}</Stack>} arrow placement='top' slotProps={{popper: {modifiers: [{name: 'offset', options: { offset: [0, -8]}}]}}}>
        {children}
    </Tooltip>
}

const LayoverTooltip = React.memo(PureLayoverTooltip);

interface OneWayFlightsCardProps {
    flights: Flight[];
}

function PureOneWayFlightsCard({ flights }: OneWayFlightsCardProps) {
    const { classes } = useStyles();

    const airportsMap = useContext(AirportContext);
    const airlinesMap = useContext(AirlineContext);

    const airlines = useMemo(() => flights.filter(
        (it, idx) => idx === 0 || it.airline !== flights[idx - 1].airline)
        .map(it => airlinesMap[it.airline]?.name || it.airline), [flights, airlinesMap]);
        
    const tripDurationSeconds = useMemo(() => 
        flights[flights.length - 1].landingDateTime.diff(flights[0].startDateTime, 'seconds'), [flights]);

    const lastFlight = useMemo(() => flights[flights.length - 1], [flights]);

    return <Box display='flex' flexDirection='row'>
            <Box className={classes.airlineBox}>
                <Typography className={classes.airlineTypography} variant='body2'>{Array.from(airlines).join(' + ')}</Typography>
            </Box>
            <Box className={classes.flightsBox}>
                <Box className={classes.locations}>
                    <Tooltip title={airportsMap[flights[0].origin]?.name}>
                        <Typography>{flights[0].origin}</Typography>
                    </Tooltip>
                    <Divider flexItem className={classes.locationsDivider}>
                        {isDirectFlight(flights) ?
                            <Chip className={classes.directChip} label="Direct" size="small"/> :
                            <LayoverTooltip flights={flights}>
                                <Chip label={`${flights.length - 1} stop${flights.length > 2 ? 's' : ''}`} size="small"/>
                            </LayoverTooltip>
                        }
                    </Divider>
                    <Tooltip title={airportsMap[lastFlight.destination]?.name}>
                        <Typography>{lastFlight.destination}</Typography>
                    </Tooltip>
                </Box>
                <Box className={classes.schedules}>
                    <Typography>{flights[0].startDateTime.format('HH:mm')}</Typography>
                    <Typography variant='caption' color='grey'>{timeElapsedString(tripDurationSeconds)}</Typography>
                    <Typography>{lastFlight.landingDateTime.format('HH:mm')}</Typography>
                </Box>
        </Box>
    </Box>
}

const OneWayFlightsCard = React.memo(PureOneWayFlightsCard);

interface ItineraryCardProps {
    itinerary: Itinerary;
}

function PureItineraryCard ({ itinerary }: ItineraryCardProps) {
    const { classes } = useStyles();

    return <Box className={classes.mainBox}>
        <Box className={classes.sumBox}>
            <OneWayFlightsCard flights={itinerary.outboundFlights}/>
            {itinerary.returnFlights.length > 0 && 
                <>
                    <Divider />
                    <OneWayFlightsCard flights={itinerary.returnFlights}/>
                </>
            }
        </Box>
        <Box className={classes.verticalDivider}>
            <Divider orientation='vertical'/>
        </Box>
        <Box className={classes.priceBox}>
            <Typography variant='body1' fontSize='1.3em'>{itinerary.price.value.toFixed(2) + ' ' + itinerary.price.currency}</Typography>
        </Box>
    </Box>;
}

export const ItineraryCard = React.memo(PureItineraryCard);