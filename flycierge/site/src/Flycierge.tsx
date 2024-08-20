import  { useCallback, useState, useMemo } from 'react';
import { tss } from 'tss-react';

import Grid from '@mui/material/Grid';
import Stack from '@mui/material/Stack';

import { SearchPanel, TopBar, ItineraryPanel, PriceMetricPanel, FilterPanel } from 'components';
import { SearchResult, Itinerary } from 'models';

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
  const [maxPrice, setMaxPrice] = useState<number>(Number.MAX_VALUE);
  const [maxFlightNumberString, setMaxFlightNumberString] = useState<string>('any');
  const [sorterChoice, setSorterChoice] = useState<string>('cheapest');

  const filterFunc = useCallback((itinerary: Itinerary) => {
    const maxFlightNumber = maxFlightNumberString === 'any' ?
        Number.MAX_VALUE : Number.parseInt(maxFlightNumberString);
    return itinerary.outboundFlights.length <= maxFlightNumber &&
        itinerary.returnFlights.length <= maxFlightNumber &&
        itinerary.price.value <= maxPrice;
  }, [maxFlightNumberString, maxPrice]);

  const priceSorter = useCallback((a: Itinerary, b: Itinerary) =>
    a.price.value - b.price.value,
[]);

const earliestDepartureTimeSorter = useCallback((a: Itinerary, b: Itinerary) =>
    a.outboundFlights[0].startDateTime.diff(b.outboundFlights[0].startDateTime),
[]);

const latestDepartureTimeSorter = useCallback((a: Itinerary, b: Itinerary) =>
    earliestDepartureTimeSorter(b, a), [earliestDepartureTimeSorter]);

const sorterFunc = useMemo(() => {
    switch (sorterChoice) {
        case 'earliest':
            return earliestDepartureTimeSorter;
        case 'latest':
            return latestDepartureTimeSorter;
        default:
            return priceSorter;
    }
}, [sorterChoice, earliestDepartureTimeSorter, latestDepartureTimeSorter, priceSorter]);

  const processedSearchResult = useMemo(() => {
    if (!filterFunc || !sorterFunc || !searchResult|| searchResult.itineraries.length === 0) {
      return searchResult;
    }

    const processedItineraries = searchResult.itineraries.filter(filterFunc).sort(sorterFunc);
    return { ...searchResult, itineraries: processedItineraries };
  }, [searchResult, sorterFunc, filterFunc]);

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
        {searchResult && searchResult.itineraries.length > 0 &&
          <FilterPanel
            maxPrice={maxPrice}
            setMaxPrice={setMaxPrice}
            maxFlightNumberString={maxFlightNumberString}
            setMaxFlightNumberString={setMaxFlightNumberString}
            sorterChoice={sorterChoice}
            setSorterChoice={setSorterChoice}
            />
        }
        </div>
        <ItineraryPanel itineraries={processedSearchResult?.itineraries || null} isFetching={isFetching} showFullDates/>
        <div className={classes.priceMetricPanel}>
          <PriceMetricPanel searchResult={searchResult} />
        </div>
      </Stack>
    </Grid>
  );
}

export default Flycierge;
