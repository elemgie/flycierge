import React, { useCallback, ChangeEvent } from 'react';
import { tss } from 'tss-react';

import Box from '@mui/material/Box';
import FormControl from '@mui/material/FormControl';
import FormLabel from '@mui/material/FormLabel';
import FormControlLabel from '@mui/material/FormControlLabel';
import RadioGroup from '@mui/material/RadioGroup';
import Radio from '@mui/material/Radio';
import Divider from '@mui/material/Divider';
import Typography from '@mui/material/Typography';
import Slider from '@mui/material/Slider';

const useStyles = tss.create({
    mainPanel: {
        marginRight: 24,
        marginTop: 8,
        padding: 8,
        borderColor: 'grey',
        borderStyle: 'solid',
        borderWidth: 1,
        borderRadius: 10,
        display: 'flex',
        flexDirection: 'column',
        width: '15vw',
        height: '50vh',
        backgroundColor: '#F1F1F1'
    }
})

interface FilterPanelProps {
    setMaxPrice: (val: number) => void;
    setMaxFlightNumberString: (val: string) => void;
    setSorterChoice: (val: string) => void;
    maxPrice: number;
    maxFlightNumberString: string;
    sorterChoice: string;
}

function PureFilterPanel({ maxPrice, maxFlightNumberString, sorterChoice, setMaxPrice, setMaxFlightNumberString, setSorterChoice }: FilterPanelProps) {
    const { classes } = useStyles();

    const handleMaxFlightNumberChange = useCallback((_event: ChangeEvent<HTMLInputElement>, val: string) =>
        setMaxFlightNumberString(val), [setMaxFlightNumberString]);

    const handleMaxPriceChange = useCallback((_event: any, val: number | number[]) =>
        setMaxPrice(val as number), [setMaxPrice]);

    const handleSortertChoiceChange = useCallback((_event: ChangeEvent<HTMLInputElement>, val: string) => setSorterChoice(val), [setSorterChoice]);

    return <Box className={classes.mainPanel}>
        <Typography fontWeight='bold' marginBottom={1}>Filters</Typography>
        <FormControl>
            <FormLabel>Max number of flights on one way</FormLabel>
            <RadioGroup
                value={maxFlightNumberString}
                onChange={handleMaxFlightNumberChange}
            >
                <FormControlLabel value='any' control={<Radio />} label="Any" />
                <FormControlLabel value='1' control={<Radio />} label="Direct" />
                <FormControlLabel value='2' control={<Radio />} label="2" />
                <FormControlLabel value='3' control={<Radio />} label="3" />
            </RadioGroup>
        </FormControl>
        <FormControl>
            <FormLabel>Max price</FormLabel>
            <Slider value={maxPrice} step={1} max={10000} onChange={handleMaxPriceChange} size='small' valueLabelDisplay="auto"/>
        </FormControl>
        <Divider orientation='horizontal' sx={{marginTop: 1, marginBottom: 1}}/>
        <FormControl>
            <FormLabel>Sort flights</FormLabel>
            <RadioGroup
                value={sorterChoice}
                onChange={handleSortertChoiceChange}
            >
                <FormControlLabel value='cheapest' control={<Radio />} label="Cheapest" />
                <FormControlLabel value='earliest' control={<Radio />} label="Earliest" />
                <FormControlLabel value='latest' control={<Radio />} label="Latest" />
            </RadioGroup>
        </FormControl>
    </Box>;
}

export const FilterPanel = React.memo(PureFilterPanel);