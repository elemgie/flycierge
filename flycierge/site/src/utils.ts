export const timeElapsedString = (secondsElapsed: number) => {
    const seconds = secondsElapsed % 60;
    const minutes = ((secondsElapsed - seconds) / 60) % 60;
    const hours = ((secondsElapsed - 60 * minutes - seconds)/ 3600);

    return (((hours > 0) ? `${hours}h` : '') + ((minutes > 0) ? ` ${minutes}m` : '')).trim();
}