package controller

import (
	"errors"
	"net/http"

	"github.com/ggicci/httpin"
	"github.com/gin-gonic/gin"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service"
)

type HumanDataController struct {
	dbh       *db.DB
	hdservice *service.HumanDataService
	oeservice *service.OpenExchangeService
}

func NewHumanDataController(dbh *db.DB, hdservice *service.HumanDataService, oeservice *service.OpenExchangeService) *HumanDataController {
	return &HumanDataController{
		dbh:       dbh,
		oeservice: oeservice,
		hdservice: hdservice,
	}
}

// GetGlobalFoodPrices godoc
//
//	@Summary	fetches food prices from random countries
//	@Param		before_year	query	string	false	"get all prices before year i.e. 1999"
//	@Param		after_year	query	string	false	"get all prices after year i.e. 1999"
//	@Param		convert		query	string	false	"get all prices in specified currency i.e. USD"
//	@Produce	json
//	@Router		/globalfoodprices [get]
//	@Success	200	{array}	model.CountryFoodPrice
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
