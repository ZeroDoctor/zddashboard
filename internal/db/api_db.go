package db

import (
	"time"

	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

func (db *DB) GetAPIMetadataByName(name model.DATA_NAME) ([]model.APIMetadata, error) {
	metadata := []model.APIMetadata{}
	query := `SELECT * FROM api_metadata WHERE name = $1`

	if err := db.Select(&metadata, query, name); err != nil {
		return metadata, err
	}

	return metadata, nil
}

func (db *DB) SaveAPIMetadata(metadata model.APIMetadata) (int64, error) {
	insert := `INSERT INTO api_metadata (
		url, name, call_at
	) VALUES (
		:url, :name, :call_at
	) ON CONFLICT (name) DO UPDATE SET
		url     = excluded.url, 
		name    = excluded.name,
		call_at = excluded.call_at
	RETURNING id
	;`

	rows, err := db.NamedQuery(insert, metadata)
	if err != nil {
		return -1, err
	}

	defer rows.Close()

	var id int64
	for rows.Next() {
		if err := rows.Scan(&id); err != nil {
			return -1, err
		}
	}

	return id, nil
}

func (db *DB) GetAPICalls(name model.DATA_NAME) ([]model.APICallCount, error) {
	query := `SELECT * FROM api_call_count WHERE api_id = (
		SELECT id FROM api_metadata WHERE name = $1
	)
	ORDER BY call_at DESC
	;`

	call := []model.APICallCount{}
	err := db.Select(&call, query, name)

	return call, err
}

func (db *DB) RecordAPICall(apiID int64) error {
	insert := `INSERT INTO api_call_count (
		api_id, call_at 
	) VALUES (
		:api_id, :call_at 
	)`

	call := model.APICallCount{
		APIID:  apiID,
		CallAt: model.Time(time.Now()),
	}

	_, err := db.NamedExec(insert, call)
	return err
}
