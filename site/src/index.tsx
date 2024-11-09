import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import Flycierge from './Flycierge';
import { DataFetcher } from 'components'

import { ThemeProvider, createTheme } from '@mui/material/styles';
import { LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterMoment } from '@mui/x-date-pickers/AdapterMoment';

const baseTheme = createTheme({});

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <React.StrictMode>
    <DataFetcher>
      <LocalizationProvider dateAdapter={AdapterMoment}>
        <ThemeProvider theme={baseTheme}>
          <Flycierge />
        </ThemeProvider>
      </LocalizationProvider>
    </DataFetcher>
  </React.StrictMode>
);
