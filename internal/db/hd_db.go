package db

import (
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

func (db *DB) GetFoodPricesWhere(clause string, values ...interface{}) ([]model.CountryFoodPrice, error) {
	prices := []model.CountryFoodPrice{}

	query := `SELECT * FROM global_food_prices WHERE ` + clause + `
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	log.Debugf("GetFoodPricesWhere [query=%s]", query)
	err := db.Select(&prices, query, values...)
	return prices, err
}

func (db *DB) GetFoodPricesByMetaID(metadata int) ([]model.CountryFoodPrice, error) {
	prices := []model.CountryFoodPrice{}
	query := `SELECT * FROM global_food_prices WHERE metadata_id = $1
		ORDER BY COALESCE(country_name, region_name, city_name, food_name, month, year)`

	log.Debugf("GetFoodPricesByMetaID [query=%s]", query)
	err := db.Select(&prices, query, metadata)
	return prices, err
}

func (db *DB) SaveGlobalFoodPrices(globalFoodPrices []model.CountryFoodPrice) error {
	insert := `INSERT INTO global_food_prices (
		country_id, country_name, region_id, region_name,
		city_id, city_name, food_id, food_name,
		currency_id, currency_name, point_id, point_name,
		weight_id, weight_name, month, year,
		price, commodity_source, metadata_id
	) VALUES (
		:country_id, :country_name, :region_id, :region_name,
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

	return BatchNamedExec(db, insert, globalFoodPrices)
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
	) ON CONFLICT (sm_url, data_name) DO UPDATE SET
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

func BatchNamedExec[T any](db *DB, insert string, batch []T) error {
	size := 999
	if len(batch) < size {
		size = len(batch)
	}

	for current := 0; current < len(batch); current += size {
		if current+size > len(batch) {
			size -= ((current + size) - len(batch))
		}

		if _, err := db.NamedExec(insert, batch[current:current+size]); err != nil {
			return err
		}
	}

	return nil
}
