package service

import (
	"os"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service/api"
)

type Services struct {
	HDservice *HumanDataService
	OEservice *OpenExchangeService
}

func NewServices(dbh *db.DB) *Services {
	a := api.NewAPI(os.Getenv("HUMAN_DATA_URL"), nil)
	oeservice := NewOpenExchangeService(a, dbh)
	return &Services{
		OEservice: oeservice,
		HDservice: NewHumanDataService(a, dbh, oeservice),
	}
}
