package model

import (
	"database/sql/driver"
	"fmt"
	"time"
)

type Time time.Time

func (t *Time) Scan(src interface{}) error {
	if unix, ok := src.(int64); ok {
		*t = Time(time.Unix(unix, 0))
	}

	return fmt.Errorf("unexcepted format [src=%T] wanted type int64", src)
}

func (t Time) Value() (driver.Value, error) {
	ti := time.Time(t)
	return ti.Unix(), nil
}

type DATA_NAME string

const (
	FOOD_PRICES   DATA_NAME = "GLOBAL FOOD PRICES"
	EXCHANGE_RATE DATA_NAME = "CURRENY EXCHANGE RATE"
)

const (
	YEAR_IN_HOURS int = 8765
)

type APIMetadata struct {
	ID     int64     `db:"id" json:"id,omitempty"`
	URL    string    `db:"url" json:"url,omitempty"`
	Name   DATA_NAME `db:"name" json:"name,omitempty"`
	CallAt Time      `db:"call_at" json:"call_at,omitempty"`
}

type APICallCount struct {
	ID     int64 `db:"id" json:"id,omitempty"`
	APIID  int64 `db:"api_id" json:"api_id,omitempty"`
	CallAt Time  `db:"call_at" json:"call_at,omitempty"`
}
