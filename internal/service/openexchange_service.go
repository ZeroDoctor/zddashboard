package service

import (
	"os"
	"time"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service/api"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

type ExchangeRateCode string

type OpenExchangeService struct {
	a   *api.API
	dbh *db.DB

	usdRatesMap map[ExchangeRateCode]float32
}

func NewOpenExchangeService(a *api.API, dbh *db.DB) *OpenExchangeService {
	oes := &OpenExchangeService{
		a: api.NewAPI(os.Getenv("OPEN_EXCHANGE_URL"), map[string]string{
			"app_id": os.Getenv("OPEN_EXCHANGE_API_KEY"),
		}),
		dbh:         dbh,
		usdRatesMap: make(map[ExchangeRateCode]float32),
	}

	if _, err := oes.GetExchangeRates(); err != nil {
		log.Errorf("failed to populate exchange rates [error=%s]", err.Error())
	}

	return oes
}

func (oe *OpenExchangeService) GetExchangeRates() ([]model.ExchangeRatesBasedUSD, error) {
	var err error
	var rates []model.ExchangeRatesBasedUSD

	meta, err := oe.dbh.GetAPIMetadataByName(model.EXCHANGE_RATE)
	if err != nil {
		return rates, err
	}

	if len(meta) <= 0 || time.Since(time.Time(meta[0].CallAt)) > model.YEAR_DUR {
		log.Warnf("failed to find metadata for %s. grabbing latest data from source...", model.EXCHANGE_RATE)
		return oe.GetLatestExchangeRates()
	}

	rates, err = oe.dbh.GetAllExchangeRate()
	if err != nil {
		return rates, err
	}

	if len(rates) <= 0 {
		return oe.GetLatestExchangeRates()
	}

	oe.PopulateRateMap(meta[0].ID, rates)

	return rates, err
}

func (oe *OpenExchangeService) GetLatestExchangeRates() ([]model.ExchangeRatesBasedUSD, error) {
	var err error
	var rates []model.ExchangeRatesBasedUSD

	rates, err = api.GetLatestCurrencyExchangeRate(oe.a)
	if err != nil {
		return nil, err
	}

	meta := model.APIMetadata{
		URL:    os.Getenv("OPEN_EXCHANGE_URL") + api.OE_LATEST_PATH,
		Name:   model.EXCHANGE_RATE,
		CallAt: model.Time(time.Now()),
	}

	meta.ID, err = oe.dbh.SaveAPIMetadata(meta)
	if err != nil {
		return rates, err
	}

	oe.PopulateRateMap(meta.ID, rates)

	if err := oe.dbh.RecordAPICall(meta.ID); err != nil {
		log.Errorf("failed to record api call [api=%+v] [error=%s]", meta, err.Error())
	}

	if err := oe.dbh.SaveExchangeRates(meta.ID, rates); err != nil {
		return rates, err
	}

	return rates, nil
}

func (oe *OpenExchangeService) ConvertWithRate(code ExchangeRateCode, price float32) float32 {
	if _, ok := oe.usdRatesMap[code]; !ok {
		log.Warnf("failed to find exchange rate for [code=%s]", code)
	}

	return price / oe.usdRatesMap[code]
}

func (oe *OpenExchangeService) PopulateRateMap(metaID int64, rates []model.ExchangeRatesBasedUSD) {
	for i := range rates {
		rates[i].MetaDataID = metaID
		oe.usdRatesMap[ExchangeRateCode(rates[i].Code)] = rates[i].Rate
	}
}
