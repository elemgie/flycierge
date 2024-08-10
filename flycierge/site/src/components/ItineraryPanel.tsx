import React from 'react';
import { tss } from 'tss-react';

import Box from '@mui/material/Box';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';

import { Itinerary } from 'models';
import { ItineraryCard } from 'components';

const useStyles = tss.create({
    mainPanel: {
        borderColor: 'grey',
        borderRadius: 3,
        borderWidth: 2,
        borderStyle: 'solid',
        alignSelf: 'center',
        width: '40vw',
        margin: 8
    }
})

interface ItineraryPanelProps {
    itineraries: Itinerary[] | null;
}

function PureItineraryPanel ( { itineraries } : ItineraryPanelProps) {
    const { classes } = useStyles();

    if (!itineraries) {
        return <></>;
    }
    return <Box alignSelf='center' justifySelf='center' className={classes.mainPanel}>
        <List>
            {itineraries.map(it => <ListItem id={it.itineraryId + ''}>
                <ItineraryCard itinerary={it} />
            </ListItem>
            )}
        </List>
    </Box>
}

export const ItineraryPanel = React.memo(PureItineraryPanel);