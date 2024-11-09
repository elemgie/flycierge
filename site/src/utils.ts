import moment from 'moment-timezone';

export const timeElapsedString = (secondsElapsed: number) => {
    const seconds = secondsElapsed % 60;
    const minutes = ((secondsElapsed - seconds) / 60) % 60;
    const hours = ((secondsElapsed - 60 * minutes - seconds)/ 3600);

    return (((hours > 0) ? `${hours}h` : '') + ((minutes > 0) ? ` ${minutes}m` : '')).trim();
}

export const getTimeZoneAdjustedTimeDiff = (firstDate: moment.Moment, firstTimeZoneName: string,
    secondDate: moment.Moment, secondTimeZoneName: string) => {
    const firstDateTz = moment.tz(firstDate.format("YYYY-MM-DD HH:mm"),
        "YYYY-MM-DD HH:mm", firstTimeZoneName);
    const secondDateTz = moment.tz(secondDate.format("YYYY-MM-DD HH:mm"),
        "YYYY-MM-DD HH:mm", secondTimeZoneName);
    return secondDateTz.diff(firstDateTz, 's');
    };