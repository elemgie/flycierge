import React, { useCallback, useState } from 'react';
import { tss } from 'tss-react';

import Box from '@mui/material/Box';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import Typography from '@mui/material/Typography';
import Stack from '@mui/material/Stack';
import CircularProgress from '@mui/material/CircularProgress';

import { Itinerary } from 'models';
import { ItineraryCard } from 'components';
import { ItineraryDialog } from './ItineraryDialog';

const useStyles = tss.create({
    mainPanel: {
        borderColor: 'grey',
        borderRadius: 5,
        borderWidth: 2,
        borderStyle: 'solid',
        alignSelf: 'center',
        justifySelf: 'center',
        width: '40vw',
        margin: 8,
        backgroundColor: '#F1F1F1',
    },
    infoBox: {
        display: 'flex',
        backgroundColor: 'white',
        justifyContent: 'center',
        padding: 8
    },
    itineraryList: {
        maxHeight: '68vh',
        overflowY: 'scroll'
    }
})

interface ItineraryPanelProps {
    itineraries: Itinerary[] | null;
    isFetching: boolean;
    showFullDates?: boolean;
}

function PureItineraryPanel ( { itineraries, isFetching, showFullDates } : ItineraryPanelProps) {
    const { classes, cx } = useStyles();
    const itineraryComparator = useCallback((a: Itinerary, b: Itinerary) => a.price.value - b.price.value, []);

    const [dialogItinerary, setDialogItinerary] = useState<Itinerary | null>(null);

    const handleItineraryClick = useCallback((itinerary: Itinerary) => setDialogItinerary(itinerary), []);
    const handleItineraryDialogClose = useCallback(() => setDialogItinerary(null), []);

    if (isFetching) {
        return <Box className={cx(classes.mainPanel, classes.infoBox)}>
            <Stack direction='row' justifyContent='center' alignItems='center' spacing={2}>
                <Typography fontSize='2.5rem'>Looking for the best flights</Typography>
                <CircularProgress />
            </Stack>
        </Box>
    }

    if (!itineraries) {
        return <></>;
    }

    if (itineraries.length === 0) {
        return <Box className={cx(classes.mainPanel, classes.infoBox)}>
                <Typography fontSize='2rem'>
                    No flights matching provided criteria were found
                </Typography>
        </Box>
    }

    return <Box className={classes.mainPanel}>
        <List className={classes.itineraryList}>
            {itineraries.sort(itineraryComparator).map(it => <ListItem id={it.itineraryId + ''}>
                <ItineraryCard
                    itinerary={it}
                    showFullDates={showFullDates}
                    onClick={() => handleItineraryClick(it)}
                />
            </ListItem>
            )}
        </List>
        {dialogItinerary && <ItineraryDialog itinerary={dialogItinerary} onClose={handleItineraryDialogClose} /> }
    </Box>
}

export const ItineraryPanel = React.memo(PureItineraryPanel);