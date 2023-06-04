package model

// from: https://data.humdata.org/

type CountryFoodPrice struct {
	ID              int     `db:"id" json:"id,omitempty"`
	CountryID       float32 `csv:"adm0_id" db:"country_id" json:"country_id,omitempty"`
	CountryName     string  `csv:"adm0_name" db:"country_name" json:"country_name,omitempty"`
	RegionID        int     `csv:"adm1_id" db:"region_id" json:"region_id,omitempty"`
	RegionName      string  `csv:"adm1_name" db:"region_name" json:"region_name,omitempty"`
	CityID          int     `csv:"mkt_id" db:"city_id" json:"city_id,omitempty"`
	CityName        string  `csv:"mkt_name" db:"city_name" json:"city_name,omitempty"`
	FoodID          int     `csv:"cm_id" db:"food_id" json:"food_id,omitempty"`
	FoodName        string  `csv:"cm_name" db:"food_name" json:"food_name,omitempty"`
	CurrencyID      int     `csv:"cur_id" db:"currency_id" json:"currency_id,omitempty"`
	CurrencyName    string  `csv:"cur_name" db:"currency_name" json:"currency_name,omitempty"`
	PointID         int     `csv:"pt_id" db:"point_id" json:"point_id,omitempty"`
	PointName       string  `csv:"pt_name" db:"point_name" json:"point_name,omitempty"`
	WeightID        int     `csv:"um_id" db:"weight_id" json:"weight_id,omitempty"`
	WeightName      string  `csv:"um_name" db:"weight_name" json:"weight_Name,omitempty"`
	Month           int     `csv:"mp_month" db:"month" json:"month,omitempty"`
	Year            int     `csv:"mp_year" db:"year" json:"year,omitempty"`
	Price           float32 `csv:"mp_price" db:"price" json:"price,omitempty"`
	CommoditySource float32 `csv:"mp_commoditysource" db:"commodity_source" json:"commodity_source,omitempty"`
	MetaDataID      int64   `db:"metadata_id" json:"metadata_id,omitempty"`
}
