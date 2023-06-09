package service

import (
	"os"
	"strconv"
	"time"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/logger"
	"github.com/zerodoctor/zddashboard/internal/service/api"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

var log = logger.Logger()

type HumanDataService struct {
	a         *api.API
	dbh       *db.DB
	oeservice *OpenExchangeService
}

func NewHumanDataService(a *api.API, dbh *db.DB, oe *OpenExchangeService) *HumanDataService {
	return &HumanDataService{
		a:         a,
		dbh:       dbh,
		oeservice: oe,
	}
}

type GlobalFoodPricesQuery struct {
	BeforeYear      string `in:"query=before_year"`
	AfterYear       string `in:"query=after_year"`
	ConvertCurrency string `in:"query=convert"`
}

func (hd *HumanDataService) GetGlobalFoodPrices(query *GlobalFoodPricesQuery) ([]model.CountryFoodPrice, error) {
	var prices []model.CountryFoodPrice

	meta, err := hd.dbh.GetAPIMetadataByName(model.FOOD_PRICES)
	if err != nil {
		return prices, err
	}

	if len(meta) <= 0 || time.Since(time.Time(meta[0].CallAt)) > model.YEAR_DUR {
		log.Warnf("failed to find metadata for %s. grabbing latest data from source...", model.FOOD_PRICES)
		return hd.GetLatestGlobalFoodPricesData()
	}

	if query == nil || (query.BeforeYear == "" && query.AfterYear == "") {
		prices, err = hd.dbh.GetFoodPricesByMetaID(meta[0].ID) // get all prices
		if err != nil {
			return prices, err
		}

		if query.ConvertCurrency != "" {
			prices = hd.ConvertPricesToCurrency(prices)
		}

		return prices, nil
	}

	var clauses []string
	var values []interface{}
	if query.BeforeYear != "" {
		clauses = append(clauses, "year < ")
		_, err := strconv.Atoi(query.BeforeYear)
		if err != nil {
			return nil, err
		}
		values = append(values, query.BeforeYear)
	}

	if query.AfterYear != "" {
		clauses = append(clauses, "year > ")
		_, err := strconv.Atoi(query.AfterYear)
		if err != nil {
			return nil, err
		}
		values = append(values, query.AfterYear)
	}

	prices, err = hd.dbh.GetFoodPricesWhere(db.JoinClauses(clauses, false), values...)
	if err != nil {
		return prices, err
	}

	if query.ConvertCurrency != "" {
		prices = hd.ConvertPricesToCurrency(prices)
	}

	return prices, nil
}

func (hd *HumanDataService) GetLatestGlobalFoodPricesData() ([]model.CountryFoodPrice, error) {
	prices, err := api.GetGlobalFoodPricesCSV(hd.a)
	if err != nil {
		return nil, err
	}

	meta := model.APIMetadata{
		URL:    os.Getenv("HUMAN_DATA_URL") + api.FOOD_PRICES_PATH,
		Name:   model.FOOD_PRICES,
		CallAt: model.Time(time.Now()),
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

func (hd *HumanDataService) ConvertPricesToCurrency(prices []model.CountryFoodPrice) []model.CountryFoodPrice {
	for i := range prices {
		prices[i].Price = hd.oeservice.ConvertWithRate(ExchangeRateCode(prices[i].CurrencyName), prices[i].Price)
	}

	return prices
}
