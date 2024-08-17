CREATE SEQUENCE the_sequence AS BIGINT;

CREATE TABLE airport (
    airport_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    name VARCHAR(256) NOT NULL,
    city VARCHAR(128) NOT NULL,
    country VARCHAR(128) NOT NULL,
    country_code VARCHAR(8) NOT NULL,
    iata_code CHAR(3) UNIQUE NOT NULL,
    icao_code CHAR(4) UNIQUE NOT NULL,
    longitude DOUBLE PRECISION,
    latitude DOUBLE PRECISION,
    time_zone_region_name VARCHAR(64),
    UNIQUE(longitude, latitude)
);

CREATE TABLE airline (
    airline_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    name VARCHAR(1024) NOT NULL,
    iata_code CHAR(2) UNIQUE NOT NULL,
    icao_code CHAR(3) UNIQUE NOT NULL,
    logo_url VARCHAR(2048)
);

CREATE TABLE search (
    search_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    origin CHAR(3) NOT NULL REFERENCES airport(iata_code),
    destination CHAR(3) NOT NULL REFERENCES airport(iata_code),
    departure_date TIMESTAMP NOT NULL,
    return_date TIMESTAMP,
    adult_number INT NOT NULL,
    create_ts BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW())
);

CREATE TABLE flight (
    flight_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    origin CHAR(3) NOT NULL REFERENCES airport(iata_code),
    destination CHAR(3) NOT NULL REFERENCES airport(iata_code),
    number VARCHAR(16) NOT NULL,
    airline VARCHAR(128) NOT NULL REFERENCES airline(iata_code),
    start_date_time TIMESTAMP NOT NULL,
    landing_date_time TIMESTAMP NOT NULL,
    create_ts BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW()),
    UNIQUE (origin, destination, airline, number, start_date_time)
);

CREATE TABLE itinerary (
    itinerary_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    create_ts BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW()),
    flights_hash VARCHAR(400) UNIQUE NOT NULL
);

CREATE TABLE itinerary_flight (
    itinerary_flight_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    itinerary_id BIGINT NOT NULL REFERENCES itinerary(itinerary_id),
    flight_id BIGINT NOT NULL REFERENCES flight(flight_id),
    is_return_flight BOOLEAN NOT NULL,
    UNIQUE(itinerary_id, flight_id)
);

CREATE TABLE price (
    price_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    itinerary_id BIGINT NOT NULL REFERENCES itinerary(itinerary_id),
    value REAL NOT NULL,
    currency VARCHAR(8) NOT NULL,
    create_ts BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW())
);
