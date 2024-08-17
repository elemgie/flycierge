import  { useState } from 'react';
import { tss } from 'tss-react';

import Grid from '@mui/material/Grid';
import Stack from '@mui/material/Stack';

import { SearchPanel, TopBar, ItineraryPanel, PriceMetricPanel, FilterPanel } from 'components';
import { SearchResult } from 'models';

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
  contentBox: {
    width: '100vw'
  },
  filterPanel: {
    width: '28vw',
    justifySelf: 'start',
    display: 'flex',
    justifyContent: 'end'
  },
  priceMetricPanel: {
    width: '28vw',
    justifySelf: 'end',
    display: 'flex',
    justifyContent: 'start'
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
      <Stack className={classes.contentBox} direction='row'>
        <div className={classes.filterPanel}>
          <FilterPanel />
        </div>
        <ItineraryPanel itineraries={searchResult?.itineraries || null} isFetching={isFetching} showFullDates/>
        <div className={classes.priceMetricPanel}>
          <PriceMetricPanel searchResult={searchResult} />
        </div>
      </Stack>
    </Grid>
  );
}

export default Flycierge;
