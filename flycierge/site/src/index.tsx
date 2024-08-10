import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import Flycierge from './Flycierge';
import { DataFetcher } from 'components'

import { ThemeProvider, createTheme } from '@mui/material/styles';

const baseTheme = createTheme({});

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <React.StrictMode>
    <DataFetcher>
      <ThemeProvider theme={baseTheme}>
        <Flycierge />
      </ThemeProvider>
    </DataFetcher>
  </React.StrictMode>
);
