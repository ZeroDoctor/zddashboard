package controller

import (
	"context"
	"errors"
	"net/http"

	"github.com/ggicci/httpin"
	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	_ "github.com/zerodoctor/zddashboard/docs"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/logger"
	"github.com/zerodoctor/zddashboard/internal/service"
)

// gin-swagger middleware
// swagger embed files

var log = logger.Logger()

type Controller struct {
	dbh *db.DB
	*gin.Engine
}

//	@title		Dashboard API
//	@version	0.1

//	@host		localhost:3000
//	@BasePath	/api

//	@securityDefinitions.basic	BasicAuth

//	@externalDocs.description	OpenAPI
//	@externalDocs.url			https://swagger.io/resources/open-api/
func NewController(dbh *db.DB) *Controller {
	api := NewHumanDataController(dbh)

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
		apiRouter.GET("/globalfoodprices", BindQueryInput(service.GlobalFoodPricesQuery{}), api.GetGlobalFoodPrices)
	}

	{
		// documentation for golang swagger-ui: https://github.com/swaggo/swag
		router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
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

// BindQueryInput instances an httpin engine for an input struct as a gin middleware.
func BindQueryInput(inputStruct interface{}) gin.HandlerFunc {
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

func HandleError(ctx *gin.Context, code int, err error) {
	ctx.JSON(code, gin.H{
		"success": false,
		"error":   err.Error(),
	})
}
