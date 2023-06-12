package api

import (
	"encoding/json"
	"io"
	"net/http"

	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

const OE_LATEST_PATH string = "/latest.json"

func GetLatestCurrencyExchangeRate(api *API) ([]model.ExchangeRatesBasedUSD, error) {
	rates := []model.ExchangeRatesBasedUSD{}

	queries := map[string]string{
		"base": "USD",
	}

	resp, err := api.Call(http.MethodGet, OE_LATEST_PATH, queries, nil)
	if err != nil {
		return rates, err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return rates, err
	}

	latest := model.LatestRates{}
	if err := json.Unmarshal(body, &latest); err != nil {
		return rates, err
	}

	for code, rate := range latest.Rates {
		rates = append(rates, model.ExchangeRatesBasedUSD{
			Code: code,
			Rate: rate,
		})
	}

	return rates, nil
}
