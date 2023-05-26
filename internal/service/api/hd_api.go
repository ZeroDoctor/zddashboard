package api

import (
	"net/http"
	"os"

	"github.com/gocarina/gocsv"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

func GetGlobalFoodPricesCSV(api *API) ([]model.GlobalFoodPrice, error) {
	globalFoodPrices := []model.GlobalFoodPrice{}

	resp, err := api.Call(http.MethodGet, os.Getenv("GLOBAL_FOOD_PRICES_URL"), nil, nil)
	if err != nil {
		return globalFoodPrices, err
	}
	defer resp.Body.Close()

	if err := gocsv.Unmarshal(resp.Body, &globalFoodPrices); err != nil {
		return globalFoodPrices, err
	}

	return globalFoodPrices, nil
}
