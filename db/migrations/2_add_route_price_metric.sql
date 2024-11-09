CREATE TABLE route_price_metric (
    route_price_metric_id BIGINT PRIMARY KEY DEFAULT nextval('the_sequence'),
    origin CHAR(3) NOT NULL,
    destination CHAR(3) NOT NULL,
    departure_date DATE NOT NULL,
    currency VARCHAR(8) NOT NULL,
    one_way BOOLEAN NOT NULL,
    minimal_value REAL NOT NULL,
    first_quartile REAL NOT NULL,
    second_quartile REAL NOT NULL,
    third_quartile REAL NOT NULL,
    maximal_value REAL NOT NULL,
    create_ts BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW()),
    UNIQUE(origin, destination, departure_date, one_way)
);