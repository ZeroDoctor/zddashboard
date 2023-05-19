package main

import (
	"github.com/zerodoctor/zddashboard/internal/controller"
	"github.com/zerodoctor/zddashboard/internal/logger"
)

var log = logger.Logger()

func main() {
	if err := controller.NewController().Run(":3000"); err != nil {
		log.Fatalf("failed to run gin controller [error=%s]", err.Error())
	}
}
