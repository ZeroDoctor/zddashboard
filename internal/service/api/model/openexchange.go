package model

type LatestRates struct {
	Disclaimer string             `json:"disclaimer"`
	License    string             `json:"license"`
	Timestamp  int64              `json:"timestamp"`
	Base       string             `json:"base"`
	Rates      map[string]float32 `json:"rates"`
}

type ExchangeRatesBasedUSD struct {
	ID         int64   `db:"id" json:"id,omitempty"`
	Code       string  `db:"name" json:"name,omitempty"`
	Rate       float32 `db:"rate" json:"rate,omitempty"`
	MetaDataID int64   `db:"metadata_id" json:"metadata_id,omitempty"`
}
