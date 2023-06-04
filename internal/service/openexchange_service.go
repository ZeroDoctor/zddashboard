package service

import (
	"os"
	"time"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service/api"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

type OpenExchangeService struct {
	a   *api.API
	dbh *db.DB

	usdRatesMap map[string]float32
}

func NewOpenExchangeService(a *api.API, dbh *db.DB) *OpenExchangeService {
	return &OpenExchangeService{
		a: api.NewAPI(os.Getenv("OPEN_EXCHANGE_URL"), map[string]string{
			"app_id": os.Getenv("OPEN_EXCHANGE_API_KEY"),
		}),
		dbh: dbh,
	}
}

func (oe *OpenExchangeService) GetLatestExchangeRates() ([]model.ExchangeRatesBasedUSD, error) {
	var err error
	var rates []model.ExchangeRatesBasedUSD

	rates, err = api.GetLatestCurrencyExchangeRate(oe.a)
	if err != nil {
		return nil, err
	}

	meta := model.APIMetadata{
		URL:    os.Getenv("OPEN_EXCHANGE_URL"),
		Name:   model.EXCHANGE_RATE,
		CallAt: time.Now(),
	}

	meta.ID, err = oe.dbh.SaveAPIMetadata(meta)
	if err != nil {
		return rates, err
	}

	for i := range rates {
		rates[i].MetaDataID = meta.ID
		oe.usdRatesMap[rates[i].Code] = rates[i].Rate
	}

	if err := oe.dbh.RecordAPICall(meta.ID); err != nil {
		log.Errorf("failed to record api call [api=%+v] [error=%s]", meta, err.Error())
	}

	if err := oe.dbh.SaveExchangeRates(rates); err != nil {
		return rates, err
	}

	return rates, nil
}

func (oe *OpenExchangeService) ConvertToRate(code string, price float32) float32 {
	return oe.usdRatesMap[code] * price
}
