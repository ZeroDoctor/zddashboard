package service

import (
	"os"
	"time"

	"github.com/zerodoctor/zddashboard/internal/api"
	"github.com/zerodoctor/zddashboard/internal/api/model"
	"github.com/zerodoctor/zddashboard/internal/db"
)

type HumanDataService struct {
	a   *api.API
	dbh *db.DB
}

func NewHumanDataService(a *api.API, dbh *db.DB) *HumanDataService {
	return &HumanDataService{
		a:   a,
		dbh: dbh,
	}
}

func (hd *HumanDataService) GetLatestGlobalFoodPricesData() ([]model.GlobalFoodPrice, error) {
	prices, err := api.GetGlobalFoodPricesCSV(hd.a)
	if err != nil {
		return nil, err
	}

	meta := model.ScrapMetadata{
		URL:         os.Getenv("GLOBAL_FOOD_PRICES_URL"),
		DataName:    string(model.FOOD_PRICES),
		LastUpdated: time.Now().Unix(),
	}

	metaID, err := hd.dbh.SaveScrapMetadata(meta)
	if err != nil {
		return prices, err
	}

	for i := range prices {
		prices[i].MetaDataID = metaID
	}

	if err := hd.dbh.SaveGlobalFoodPrices(prices); err != nil {
		return prices, err
	}

	return prices, nil
}
