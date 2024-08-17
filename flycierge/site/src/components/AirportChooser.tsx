import React, { useContext, useCallback, useState, useMemo } from 'react';
import { tss } from 'tss-react';
import Autosuggest from 'react-autosuggest';

import TextField from '@mui/material/TextField';
import Paper from '@mui/material/Paper';
import MenuItem from '@mui/material/MenuItem';

import { AirportContext } from 'components';
import { Airport } from 'models';

const useStyles = tss.create({
    container: {
        position: 'relative',
        width: "100%"
    },
    suggestionsContainerOpen: {
        position: 'absolute',
        zIndex: 99,
        marginTop: 1,
        left: 0,
        right: 0,
        maxHeight: '290px',
        overflowY: 'auto',
    },
    suggestion: {
        display: 'block',
    },
    suggestionsList: {
        margin: 0,
        padding: 0,
        listStyleType: 'none',
    }
})

interface AirportChooserProps {
    label: string;
    value: string;
    onChange: (newValue: string) => void;
}

function PureAirportChooser({ label, value, onChange }: AirportChooserProps) {
    const { classes } = useStyles();

    const airports = Object.values(useContext(AirportContext));
    const [suggestions, setSuggestions] = useState<Airport[]>([]);

    const getSuggestions = useCallback((input: string) => {
        const sanitizedInput = input.trim().toLowerCase();
        const inputLength = sanitizedInput.length;

        const compare = (val: string) => val.toLowerCase().startsWith(sanitizedInput);

        // if input is too short don't return probably huge list triggering expensive render of suggestion list
        // it might freeze the component for a noticeable time
        return inputLength < 2 ? [] : airports.filter(airport =>
            compare(airport.country) || compare(airport.iataCode) ||
            compare(airport.name) || compare(airport.city))
            .sort((a, b) => b.searchCount - a.searchCount);
    }, [airports]);

    const getSuggestionValue = useCallback((airport: Airport) => airport.iataCode, []);

    const onSuggestionsFetchRequested = useCallback((request: Autosuggest.SuggestionsFetchRequestedParams) =>
        setSuggestions(getSuggestions(request.value)), [getSuggestions]);

    const onSuggestionClearRequested = useCallback(() => setSuggestions([]), []);

    const handleValueChange = useCallback((_event: any, { newValue }: { newValue: string }) => {
        onChange(newValue);
    }, [onChange]);

    const inputProps = useMemo(() => ({
        placeholder: label,
        value,
        onChange: handleValueChange
    }), [value, handleValueChange, label]);

    const renderSuggestion = useCallback((suggestion: Airport) => {
        return (
            <MenuItem component="div" sx={{ height: 20 }}>
                <span>{`${suggestion.name} (${suggestion.iataCode})`}</span>
            </MenuItem>
        );
    }, []);

    const renderInputComponent = useCallback((inputProps: any) => 
        <TextField
            fullWidth
            label={label}
            {...inputProps}
        />, [label]);

        const renderSuggestionsContainer = useCallback(
            (options: Autosuggest.RenderSuggestionsContainerParams) => (
                <Paper {...options.containerProps} square>
                    {options.children}
                </Paper>
        ), []);

    return <Autosuggest 
        suggestions={suggestions}
        inputProps={inputProps}
        renderInputComponent={renderInputComponent}
        onSuggestionsFetchRequested={onSuggestionsFetchRequested}
        onSuggestionsClearRequested={onSuggestionClearRequested}
        renderSuggestion={renderSuggestion}
        getSuggestionValue={getSuggestionValue}
        theme={{
            container: classes.container,
            suggestionsContainerOpen: classes.suggestionsContainerOpen,
            suggestionsList: classes.suggestionsList,
            suggestion: classes.suggestion,
        }}
        renderSuggestionsContainer={renderSuggestionsContainer}
    />;
}

export const AirportChooser = React.memo(PureAirportChooser);