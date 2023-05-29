package controller

import (
	"context"
	"errors"
	"net/http"

	"github.com/ggicci/httpin"
	"github.com/gin-gonic/gin"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/logger"
	"github.com/zerodoctor/zddashboard/internal/service"
)

var log = logger.Logger()

type Controller struct {
	dbh *db.DB
	*gin.Engine
}

func NewController(dbh *db.DB) *Controller {
	api := NewHumanDataAPI(dbh)

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

	{
		apiRouter := router.Group("/api")
		apiRouter.GET("/globalfoodprices", BindInput(service.GlobalFoodPricesQuery{}), api.GetGlobalFoodPrices)
	}

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

// BindInput instances an httpin engine for an input struct as a gin middleware.
func BindInput(inputStruct interface{}) gin.HandlerFunc {
	engine, err := httpin.New(inputStruct)
	if err != nil {
		panic(err)
	}

	return func(c *gin.Context) {
		input, err := engine.Decode(c.Request)
		if err != nil {
			var invalidFieldError *httpin.InvalidFieldError
			if errors.As(err, &invalidFieldError) {
				c.AbortWithStatusJSON(http.StatusBadRequest, invalidFieldError)
				return
			}
			c.AbortWithStatus(http.StatusInternalServerError)
			return
		}

		ctx := context.WithValue(c.Request.Context(), httpin.Input, input)
		c.Request = c.Request.WithContext(ctx)
		c.Next()
	}
}
