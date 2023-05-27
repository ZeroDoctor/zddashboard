
CREATE TABLE IF NOT EXISTS scrap_metadata (
    sm_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    sm_url       TEXT,
	data_name    TEXT NOT NULL,
    last_updated INTEGER NOT NULL,
	
	UNIQUE(sm_url, data_name)
);

CREATE TABLE IF NOT EXISTS global_food_prices (
    gfp_id           INTEGER PRIMARY KEY AUTOINCREMENT,
    country_id       NUMERIC(10, 2),
    country_name     TEXT,
    region_id        INTEGER,
	region_name      TEXT,
	city_id          INTEGER,
	city_name        TEXT,
	food_id          INTEGER,
	food_name        TEXT,
	currency_id      INTEGER,
	currency_name    TEXT,
	point_id         INTEGER,
	point_name       TEXT,
	weight_id        INTEGER,
	weight_name      TEXT,
	month            INTEGER,
	year             INTEGER,
	price            NUMERIC(10, 2),
	commodity_source NUMERIC(10, 2),
	metadata_id      INTEGER,

	FOREIGN KEY(metadata_id) REFERENCES scrap_metadata(sm_id),
	UNIQUE(country_id, region_id, city_id, currency_id, month, year)
);