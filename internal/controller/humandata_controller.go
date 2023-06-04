package controller

import (
	"errors"
	"net/http"
	"os"

	"github.com/ggicci/httpin"
	"github.com/gin-gonic/gin"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service"
	"github.com/zerodoctor/zddashboard/internal/service/api"
)

type HumanDataController struct {
	dbh       *db.DB
	hdservice *service.HumanDataService
	*api.API
}

func NewHumanDataController(dbh *db.DB) *HumanDataController {
	a := api.NewAPI(os.Getenv("HUMAN_DATA_URL"), nil)

	return &HumanDataController{
		dbh:       dbh,
		hdservice: service.NewHumanDataService(a, dbh),
		API:       a,
	}
}

func (hda *HumanDataController) GetGlobalFoodPrices(ctx *gin.Context) {
	input, ok := ctx.Request.Context().Value(httpin.Input).(*service.GlobalFoodPricesQuery)
	if !ok {
		err := errors.New("failed to parses query")
		HandleError(ctx, http.StatusBadRequest, err)
		return
	}

	prices, err := hda.hdservice.GetGlobalFoodPrices(input)
	if err != nil {
		HandleError(ctx, http.StatusInternalServerError, err)
		return
	}

	ctx.Header("Access-Control-Allow-Origin", "*")
	ctx.Header("Access-Control-Allow-Headers", "Content-Type")
	ctx.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	ctx.Header("Access-Control-Expose-Headers", "Authorization")
	ctx.JSON(http.StatusOK, gin.H{
		"success": true,
		"data":    prices,
	})
}
