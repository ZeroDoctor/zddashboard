package model

import "time"

type DATA_NAME string

const (
	FOOD_PRICES   DATA_NAME = "GLOBAL FOOD PRICES"
	EXCHANGE_RATE DATA_NAME = "CURRENY EXCHANGE RATE"
)

type APIMetadata struct {
	ID     int64     `db:"id" json:"id,omitempty"`
	URL    string    `db:"url" json:"url,omitempty"`
	Name   DATA_NAME `db:"name" json:"name,omitempty"`
	CallAt time.Time `db:"call_at" json:"call_at,omitempty"`
}

type APICallCount struct {
	ID     int64     `db:"id" json:"id,omitempty"`
	APIID  int64     `db:"api_id" json:"api_id,omitempty"`
	CallAt time.Time `db:"call_at" json:"call_at,omitempty"`
}
