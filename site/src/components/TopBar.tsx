import React from 'react';
import { tss } from 'tss-react';

import Typography from '@mui/material/Typography';

const useStyles = tss.create({
    topBar: {
        borderBottomWidth: '2px',
        borderBottomStyle: 'solid',
        borderBottomColor: 'rgba(100, 100, 100, 0.3)',
        display: 'inline-flex',
        width: '100vw',
        backgroundColor: 'white'
    }
})

function PureTopBar() {
    const { classes } = useStyles();

    return (
        <div className={classes.topBar}>
            <Typography margin={1} fontWeight={500} fontSize={28} maxWidth='200px' padding={1} borderColor='grey' border={1} borderRadius={2}>Flycierge</Typography>
        </div>
    );
}

export const TopBar = React.memo(PureTopBar);