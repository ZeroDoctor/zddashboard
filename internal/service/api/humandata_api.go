package api

import (
	"net/http"

	"github.com/gocarina/gocsv"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

const FOOD_PRICES_PATH string = "/4fdcd4dc-5c2f-43af-a1e4-93c9b6539a27/resource/12d7c8e3-eff9-4db0-93b7-726825c4fe9a/download/wfpvam_foodprices.csv"

func GetGlobalFoodPricesCSV(api *API) ([]model.CountryFoodPrice, error) {
	globalFoodPrices := []model.CountryFoodPrice{}

	resp, err := api.Call(http.MethodGet, FOOD_PRICES_PATH, nil, nil)
	if err != nil {
		return globalFoodPrices, err
	}
	defer resp.Body.Close()

	if err := gocsv.Unmarshal(resp.Body, &globalFoodPrices); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}
