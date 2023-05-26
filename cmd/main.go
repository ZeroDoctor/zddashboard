package main

import (
	"os"

	"github.com/joho/godotenv"
	"github.com/zerodoctor/zddashboard/internal/controller"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/logger"
)

var log = logger.Logger()

const SCHEMA_FILE string = "/sql/schema.lite.sql"

func LoadEnv() {
	env := os.Getenv("ENV")
	if env != "prod" {
		env = "dev"
	}

	if err := godotenv.Load("." + env + ".env"); err != nil {
		log.Fatalf("failed to load env file [error=%s]", err.Error())
	}
}

func main() {
	LoadEnv()

	conn, err := db.NewSqliteDB()
	if err != nil {
		log.Fatalf("failed to connect to sqlite db [error=%s]", err.Error())
	}

	if err := conn.ExecSchemaFile(SCHEMA_FILE); err != nil {
		log.Fatalf("failed to execute schema [file=%s] [error=%s]", SCHEMA_FILE, err.Error())
	}

	if err := controller.NewController(conn).Run(":3000"); err != nil {
		log.Fatalf("failed to run gin controller [error=%s]", err.Error())
	}
}
