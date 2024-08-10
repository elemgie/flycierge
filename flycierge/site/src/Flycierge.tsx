import  { useCallback, useState, useEffect } from 'react';
import { tss } from 'tss-react';
import Grid from '@mui/material/Grid';

import { SearchPanel, TopBar, ItineraryPanel } from "components";
import { SearchParams, Itinerary } from 'models';
import { Client } from 'client';
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
    margin: '16px'
  },
  itineraryPanel: {
  }
});

function Flycierge() {
  const { classes } = useStyles();

  const client = new Client(process.env.REACT_APP_SERVER_URL as string);
  moment.locale('en-gb');

  const [searchResults, setSearchResults] = useState<Itinerary[] | null>(null);

  const handleSearch = useCallback(async (params: SearchParams) => {
    const response = await client.fetchData<any[]>('/search', 'POST', params);
    response.forEach(it => it.outboundFlights.forEach((fl: any) => {
      fl.startDateTime = moment(fl.startDateTime, 'YYYY-MM-DDTHH:mm:ss');
      fl.landingDateTime = moment(fl.landingDateTime, 'YYYY-MM-DDTHH:mm:ss');
    }));
    response.forEach(it => {
      if (it.returnFlights) { 
        it.returnFlights.forEach((fl: any) => {
          fl.startDateTime = moment(fl.startDateTime, 'YYYY-MM-DDTHH:mm:ss');
          fl.landingDateTime = moment(fl.landingDateTime, 'YYYY-MM-DDTHH:mm:ss');
        });
      }
    });
    setSearchResults(response);
  }, [client]);


  return (
    <Grid className={classes.mainContainer}>
      <div className={classes.topBar}>
        <TopBar />
      </div>
      <div className={classes.searchPanel}>
        <SearchPanel onSearch={handleSearch}/>
      </div>
      <div className={classes.itineraryPanel}>
        <ItineraryPanel itineraries={searchResults}/>
      </div>
    </Grid>
  );
}

export default Flycierge;
