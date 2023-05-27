package db

import (
	"errors"
	"os"

	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	_ "github.com/mattn/go-sqlite3"
	"github.com/zerodoctor/zddashboard/internal/logger"
	zdutil "github.com/zerodoctor/zdgo-util"
)

var ROOT_DIR string
var log = logger.Logger()

var ErrFileNotFound error = errors.New("file not found")

func init() {
	var err error
	ROOT_DIR, err = zdutil.GetExecPath()
	if err != nil {
		log.Fatalf("failed to get root executed path [error=%s]", err.Error())
	}
}

type DB struct {
	*sqlx.DB
}

func NewSqliteDB(dbName string) (*DB, error) {
	conn, err := sqlx.Connect("sqlite3", dbName)
	if err != nil {
		return nil, err
	}

	return &DB{
		DB: conn,
	}, nil
}

func (db *DB) ExecSchemaFile(fileName string) error {
	schema := ROOT_DIR + fileName

	log.Infof("executing schema [file=%s]", schema)
	if zdutil.FileExists(schema) {
		data, err := os.ReadFile(schema)
		if err != nil {
			return err
		}

		_, err = db.Exec(string(data))
		return err
	}

	return ErrFileNotFound
}
