package service

import (
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
	BeforeYear string `in:"query=before_year"`
	AfterYear  string `in:"query=after_year"`
}

func (hd *HumanDataService) GetGlobalFoodPrices(query *GlobalFoodPricesQuery) ([]model.CountryFoodPrice, error) {
	var prices []model.CountryFoodPrice

	meta, err := hd.dbh.GetAPIMetadataByName(string(model.FOOD_PRICES))
	if err != nil {
		return prices, err
	}

	if len(meta) <= 0 || time.Since(meta[0].CallAt) > (time.Hour*8765) {
		log.Warnf("failed to find metadata for global food prices. grabbing latest data from source...")
		return hd.GetLatestGlobalFoodPricesData()
	}

	if query == nil || (query.BeforeYear == "" && query.AfterYear == "") {
		return hd.dbh.GetFoodPricesByMetaID(meta[0].ID) // get all prices
	}

	var clauses []string
	var values []interface{}
	if query.BeforeYear != "" {
		clauses = append(clauses, "year < ")
		value, err := time.Parse(time.RFC3339, query.BeforeYear)
		if err != nil {
			return nil, err
		}
		values = append(values, value)
	}

	if query.AfterYear != "" {
		clauses = append(clauses, "year > ")
		value, err := time.Parse(time.RFC3339, query.AfterYear)
		if err != nil {
			return nil, err
		}
		values = append(values, value)
	}

	return hd.dbh.GetFoodPricesWhere(db.JoinClauses(clauses, false), values...)
}

func (hd *HumanDataService) GetLatestGlobalFoodPricesData() ([]model.CountryFoodPrice, error) {
	prices, err := api.GetGlobalFoodPricesCSV(hd.a)
	if err != nil {
		return nil, err
	}

	meta := model.APIMetadata{
		URL:    os.Getenv("GLOBAL_FOOD_PRICES_URL"),
		Name:   model.FOOD_PRICES,
		CallAt: time.Now(),
	}

	meta.ID, err = hd.dbh.SaveAPIMetadata(meta)
	if err != nil {
		return prices, err
	}

	for i := range prices {
		prices[i].MetaDataID = meta.ID
	}

	if err := hd.dbh.RecordAPICall(meta.ID); err != nil {
		log.Errorf("failed to record api call [api=%+v] [error=%s]", meta, err.Error())
	}

	if err := hd.dbh.SaveGlobalFoodPrices(prices); err != nil {
		return prices, err
	}

	return prices, nil
}
