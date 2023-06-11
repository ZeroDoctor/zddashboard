package db

import "github.com/zerodoctor/zddashboard/internal/service/api/model"

func (db *DB) GetExchangeRate(code string) (float32, error) {
	rates := []model.ExchangeRatesBasedUSD{}

	query := "SELECT * FROM exchange_rates_based_usd WHERE code = $1"
	if err := db.Select(&rates, query, code); err != nil {
		return 0, err
	}

	rate := float32(0)
	if len(rates) > 0 {
		rate = rates[0].Rate
	}

	return rate, nil
}

func (db *DB) GetAllExchangeRate() ([]model.ExchangeRatesBasedUSD, error) {
	rates := []model.ExchangeRatesBasedUSD{}

	query := "SELECT * FROM exchange_rates_based_usd"
	err := db.Select(&rates, query)
	return rates, err
}

func (db *DB) SaveExchangeRates(rates []model.ExchangeRatesBasedUSD) error {
	insert := `INSERT INTO exchange_rates_based_usd (
		code, rate
	) VALUES (
		:code, :rate
	) ON CONFLICT (code) DO UPDATE SET
		code = excluded.code,
		rate = excluded.rate
	;`

	return BatchNamedExec(db, insert, rates)
}
