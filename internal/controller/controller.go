package controller

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/logger"
)

var log = logger.Logger()

type Controller struct {
	dbh *db.DB
	*gin.Engine
}

func NewController(dbh *db.DB) *Controller {
	api := NewAPI(dbh)

	router := gin.Default()

	t, err := loadTemplate(router)
	if err != nil {
		log.Fatalf("failed to load template [error=%s]", err.Error())
	}
	router.SetHTMLTemplate(t)

	router.StaticFile("/favicon.ico", "./ui/build/favicon.ico")

	router.GET("/healthcheck", HealthCheck)
	router.GET("/", IndexPage)
	router.GET("/pages", PagePage)

	router.GET("/api/getglobalfoodprices", api.GetGlobalFoodPrices)

	return &Controller{
		dbh:    dbh,
		Engine: router,
	}
}

func HealthCheck(ctx *gin.Context) {
	ctx.Status(http.StatusOK)
}

func IndexPage(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "index.html", nil)
}

func PagePage(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "pages/index.html", nil)
}
