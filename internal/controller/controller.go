package controller

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/zerodoctor/zddashboard/internal/logger"
)

var log = logger.Logger()

type Controller struct {
	*gin.Engine
}

func NewController() *Controller {
	router := gin.Default()

	t, err := loadTemplate(router)
	if err != nil {
		log.Fatalf("failed to load template [error=%s]", err.Error())
	}
	router.SetHTMLTemplate(t)

	router.GET("/healthcheck", HealthCheck)
	router.GET("/", IndexPage)
	router.GET("/pages", PagePage)

	return &Controller{
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
