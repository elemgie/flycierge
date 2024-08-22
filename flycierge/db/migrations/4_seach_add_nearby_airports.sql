ALTER TABLE search ADD COLUMN find_nearest_to_origin BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE search ADD COLUMN find_nearest_to_destination BOOLEAN NOT NULL DEFAULT false;