import React, { useMemo } from 'react';
import { tss } from 'tss-react';

import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';

import { SearchResult } from 'models';

const useStyles = tss.create({
    mainPanel: {
        marginLeft: 24,
        marginTop: 8,
        padding: 8,
        borderColor: 'grey',
        borderStyle: 'solid',
        borderWidth: 1,
        borderRadius: 10,
        display: 'flex',
        flexDirection: 'column',
        maxHeight: '5rem',
        width: '15vw',
        backgroundColor: '#F1F1F1',
    }
})

interface PriceMetricPanelProps {
    searchResult: SearchResult | null;
}

function PurePriceMetricPanel({ searchResult }: PriceMetricPanelProps) {
    const { classes } = useStyles();

    const metric = useMemo(() => searchResult?.priceMetric, [searchResult?.priceMetric]);
    const lowestFoundPrice = useMemo(() => 
        searchResult?.itineraries
            .map(it => it.price.value)
            .reduce((acc, price) => Math.min(acc, price), Number.MAX_VALUE) || Number.MAX_VALUE,
        [searchResult?.itineraries]);

    const priceAnalysisText = useMemo(() => {
        if (!metric)
            return null;
        if (lowestFoundPrice < metric.firstQuartile) {
            return { color: 'green', text: 'This is a great deal!' };
        }
        if (lowestFoundPrice > metric.thirdQuartile) {
            return { color: 'red', text: 'This is rather much for that route' };
        }
        return { color: 'grey', text: 'Price is within the usual range' };
    }, [lowestFoundPrice, metric]);

    if (!metric || !searchResult?.itineraries || searchResult?.itineraries.length === 0) {
        return <></>;
    }

    return <Box className={classes.mainPanel}>
            <Typography fontWeight='bold' color={priceAnalysisText?.color}>{priceAnalysisText?.text}</Typography>
            <Typography>{`The median price for this route is ${metric.secondQuartile} ${metric.currency}`}</Typography>
        </Box>;
}

export const PriceMetricPanel = React.memo(PurePriceMetricPanel);