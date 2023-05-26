package db

import "github.com/zerodoctor/zddashboard/internal/api/model"

func (db *DB) GetFoodPricesByCountryName(countryName string) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE country_name LIKE $1%
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, countryName); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesByCountryID(countryID string) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE country_id LIKE $1%
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, countryID); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesByCityName(cityName string) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE city_name LIKE $1%
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, cityName); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesByCityID(cityID string) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE city_id LIKE $1%
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, cityID); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesByFoodName(foodName string) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE food_name LIKE $1%
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, foodName); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesByFoodID(foodID string) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE food_id LIKE $1% 
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, foodID); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesLessThanYear(year int) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE year > $1 
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, year); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesGreaterThanYear(year int) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE year < $1 
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, year); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) GetFoodPricesByMetaID(metadata int) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE metadata_id = $1
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	if err := db.Select(&globalFoodPrices, query, metadata); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}

func (db *DB) SaveGlobalFoodPrices(globalFoodPrices []model.GlobalFoodPrice) error {
	insert := `INSERT INTO global_food_prices (
		country_id, country_name, region_id, region_name
		city_id, city_name, food_id, food_name,
		currency_id, currency_name, point_id, point_name,
		weight_id, weight_name, month, year,
		price, commodity_source, metadata_id
	) VALUES (
		:country_id, :country_name, :region_id, :region_name
		:city_id, :city_name, :food_id, :food_name,
		:currency_id, :currency_name, :point_id, :point_name,
		:weight_id, :weight_name, :month, :year,
		:price, :commodity_source, :metadata_id
	) ON CONFLICT (country_id, region_id, city_id, currency_id, month, year) DO UPDATE SET
		country_id       = excluded.country_id, 
		country_name     = excluded.country_name, 
		region_id        = excluded.region_id, 
		region_name      = excluded.region_name,
		city_id          = excluded.city_id, 
		city_name        = excluded.city_name, 
		food_id          = excluded.food_id, 
		food_name        = excluded.food_name,
		currency_id      = excluded.currency_id, 
		currency_name    = excluded.currency_name, 
		point_id         = excluded.point_id,
		point_name       = excluded.point_name,
		weight_id        = excluded.weight_id, 
		weight_name      = excluded.weight_name, 
		month            = excluded.month, 
		year             = excluded.year,
		price            = excluded.price, 
		commodity_source = excluded.commodity_source,
		metadata_id      = excluded.metadata_id
	;`

	_, err := db.NamedExec(insert, globalFoodPrices)
	return err
}

func (db *DB) GetScrapMetadataByName(name string) ([]model.ScrapMetadata, error) {
	metadata := []model.ScrapMetadata{}
	query := `SELECT * FROM scrap_metadata WHERE data_name = $1`

	if err := db.Select(&metadata, query, name); err != nil {
		return metadata, err
	}

	return metadata, nil
}

func (db *DB) SaveScrapMetadata(metadata model.ScrapMetadata) (int64, error) {
	insert := `INSERT INTO scrap_metadata (
		sm_url, data_name, last_updated
	) VALUES (
		:sm_url, :data_name, :last_updated
	) ON CONFLICT (scrap_url, data_name) DO UPDATE SET
		sm_url    = excluded.sm_url, 
		data_name    = excluded.data_name, 
		last_updated = excluded.last_updated
	RETURNING sm_id
	;`

	rows, err := db.NamedQuery(insert, metadata)
	if err != nil {
		return -1, err
	}

	defer rows.Close()

	var id int64
	for rows.Next() {
		if err := rows.Scan(&id); err != nil {
			return -1, err
		}
	}

	return id, nil
}
