import React, {} from 'react';
import { tss } from 'tss-react';

import Box from '@mui/material/Box';

const useStyles = tss.create({
    mainPanel: {
        marginRight: 24,
        marginTop: 8,
        justifySelf: 'center',
        borderColor: 'grey',
        borderStyle: 'solid',
        borderWidth: 1,
        borderRadius: 10,
        display: 'flex',
        maxHeight: '20vh',
        width: '20vw',
        backgroundColor: '#F1F1F1'
    }
})

function PureFilterPanel() {
    const { classes } = useStyles();

    return <Box className={classes.mainPanel}>
    </Box>
}

export const FilterPanel = React.memo(PureFilterPanel);