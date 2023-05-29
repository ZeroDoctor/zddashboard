package service

import (
	"fmt"
	"os"
	"time"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/logger"
	"github.com/zerodoctor/zddashboard/internal/service/api"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

var log = logger.Logger()

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

type GlobalFoodPricesQuery struct {
	BeforeYear int `in:"query=before_year;default=-1"`
	AfterYear  int `in:"query=after_year;default=-1"`
}

func (hd *HumanDataService) GetGlobalFoodPrices(query *GlobalFoodPricesQuery) ([]model.GlobalFoodPrice, error) {
	var prices []model.GlobalFoodPrice

	meta, err := hd.dbh.GetScrapMetadataByName(string(model.FOOD_PRICES))
	if err != nil {
		return prices, err
	}

	lastUpdate := time.Unix(meta[0].LastUpdated, 0)
	if len(meta) <= 0 || time.Since(lastUpdate) < (time.Hour*8765) {
		log.Warnf("failed to find metadata for global food prices. grabbing latest data from source...")
		return hd.GetLatestGlobalFoodPricesData()
	}

	fmt.Println(query)
	if query == nil || (query.BeforeYear == -1 && query.AfterYear == -1) {
		return hd.dbh.GetFoodPricesByMetaID(meta[0].ID) // get all prices
	}

	var clauses []string
	var values []interface{}
	if query.BeforeYear != -1 {
		clauses = append(clauses, "year < ")
		values = append(values, query.BeforeYear)
	}

	if query.AfterYear != -1 {
		clauses = append(clauses, "year > ")
		values = append(values, query.AfterYear)
	}

	return hd.dbh.GetFoodPricesWhere(db.JoinClauses(clauses, false), values...)
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
