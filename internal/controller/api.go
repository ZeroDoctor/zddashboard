package controller

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service"
	"github.com/zerodoctor/zddashboard/internal/service/api"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

type HumanDataAPI struct {
	dbh       *db.DB
	hdservice *service.HumanDataService
	*api.API
}

func NewHumanDataAPI(dbh *db.DB) *HumanDataAPI {
	a := api.NewAPI("", nil)

	return &HumanDataAPI{
		dbh:       dbh,
		hdservice: service.NewHumanDataService(a, dbh),
		API:       a,
	}
}

func (hda *HumanDataAPI) GetGlobalFoodPrices(ctx *gin.Context) {
	meta, err := hda.dbh.GetScrapMetadataByName(string(model.FOOD_PRICES))
	if err != nil {
		HandleError(ctx, http.StatusInternalServerError, err)
		return
	}

	if len(meta) <= 0 {
		log.Warnf("failed to find metadata for global food prices. grabbing latest data from source...")
		prices, err := hda.hdservice.GetLatestGlobalFoodPricesData()
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

	prices, err := hda.dbh.GetFoodPricesByMetaID(meta[0].ID)
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
