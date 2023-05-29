package db

import (
	"errors"
	"fmt"
	"os"
	"reflect"
	"strings"

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

func JoinClauses(clauses []string, exclusive bool) string {
	for i := range clauses {
		clauses[i] = fmt.Sprintf("%s $%d", clauses[i], i+1)
	}

	if exclusive {
		return strings.Join(clauses, " AND ")
	}

	return strings.Join(clauses, " OR ")
}

// TODO: think of a way to auto build queries
func BuildClause(query any) (string, error) {
	clause := ""

	t := reflect.TypeOf(query)
	if t.Kind() != reflect.Pointer && t.Elem().Kind() != reflect.Struct {
		return clause, fmt.Errorf("expected pointer sturct not [type=%T]", query)
	}

	for i := 0; i < t.NumField(); i++ {

	}

	return clause, nil
}
