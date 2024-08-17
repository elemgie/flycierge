import  { useCallback, useState, useEffect } from 'react';
import { tss } from 'tss-react';
import Grid from '@mui/material/Grid';

import { SearchPanel, TopBar, ItineraryPanel } from 'components';
import { SearchResult } from 'models';

import Typography from '@mui/material/Typography';

import moment from 'moment';
import 'moment/locale/en-gb';

const useStyles = tss.create({
  mainContainer: {
    backgroundColor: '#FAF2D3',
    display: 'flex',
    flexDirection: 'column',
    minHeight: '100vh',
    width: '100vw',
    gridGap: 8,
    alignItems: 'center'
  },
  topBar: {
  },
  searchPanel: {
    maxWidth: "100%",
    display: 'flex',
    margin: '8px'
  },
  mainPanel: {
    display: 'flex',
    flexDirection: 'row'
  }
});

function Flycierge() {
  const { classes } = useStyles();
  moment.locale('en-gb');

  const [searchResult, setSearchResult] = useState<SearchResult | null>(null);
  const [isFetching, setIsFetching] = useState<boolean>(false);

  return (
    <Grid className={classes.mainContainer}>
      <div className={classes.topBar}>
        <TopBar />
      </div>
      <div className={classes.searchPanel}>
        <SearchPanel setIsFetching={setIsFetching} setSearchResult={setSearchResult} isFetching={isFetching}/>
      </div>
      <div className={classes.mainPanel}>
        <ItineraryPanel itineraries={searchResult?.itineraries || null} isFetching={isFetching} showFullDates/>
      </div>
    </Grid>
  );
}

export default Flycierge;
