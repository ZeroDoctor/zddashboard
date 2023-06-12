package main

import (
	"os"

	"github.com/joho/godotenv"
	"github.com/zerodoctor/zddashboard/internal/logger"
)

var log = logger.Logger()

const SCHEMA_FILE string = "/sql/schema.lite.sql"
const DB_NAME string = "data.db"

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
	RunCmd()
}
