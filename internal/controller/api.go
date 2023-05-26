package controller

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service"
	"github.com/zerodoctor/zddashboard/internal/service/api"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

type API struct {
	dbh       *db.DB
	hdservice *service.HumanDataService
	*api.API
}

func NewAPI(dbh *db.DB) *API {
	a := &api.API{}

	return &API{
		dbh:       dbh,
		hdservice: service.NewHumanDataService(a, dbh),
		API:       a,
	}
}

func (a *API) GetGlobalFoodPrices(ctx *gin.Context) {
	meta, err := a.dbh.GetScrapMetadataByName(string(model.FOOD_PRICES))
	if err != nil {
		HandleError(ctx, http.StatusInternalServerError, err)
		return
	}

	if len(meta) <= 0 {
		prices, err := a.hdservice.GetLatestGlobalFoodPricesData()
		if err != nil {
			HandleError(ctx, http.StatusInternalServerError, err)
			return
		}

		ctx.JSON(http.StatusOK, gin.H{
			"success": true,
			"data":    prices,
		})
		return
	}

	prices, err := a.dbh.GetFoodPricesByMetaID(meta[0].ID)
	if err != nil {
		HandleError(ctx, http.StatusInternalServerError, err)
		return
	}

	ctx.JSON(http.StatusOK, gin.H{
		"success": true,
		"data":    prices,
	})
}

func HandleError(ctx *gin.Context, code int, err error) {
	ctx.JSON(code, gin.H{
		"success": false,
		"error":   err.Error(),
	})
}
