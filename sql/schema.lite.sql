
CREATE TABLE IF NOT EXISTS api_metadata (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    url     TEXT,
	name    TEXT NOT NULL,
	call_at INTEGER NOT NULL,
	
	UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS api_call_count (
	id      INTEGER PRIMARY KEY AUTOINCREMENT,
	api_id  INTEGER,
	call_at INTEGER NOT NULL,
	
	FOREIGN KEY api_id REFERENCES api_metadata(id)
);

CREATE TABLE IF NOT EXISTS global_food_prices (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
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

	FOREIGN KEY(metadata_id) REFERENCES api_metadata(id),
	UNIQUE(country_id, region_id, city_id, currency_id, month, year)
);

CREATE TABLE IF NOT EXISTS exchange_rates_based_usd (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
	code        TEXT NOT NULL,
	rate        REAL NOT NULL,
	metadata_id INTEGER,
	
	FOREIGN KEY(metadata_id) REFERENCES api_metadata(id),
	UNIQUE(code)
);