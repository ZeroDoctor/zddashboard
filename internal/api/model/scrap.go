package model

type ScrapMetadata struct {
	ID          int    `db:"sm_id" json:"sm_id,omitempty"`
	URL         string `db:"sm_url" json:"url,omitempty"`
	DataName    string `db:"data_name" json:"data_name,omitempty"`
	LastUpdated int64  `db:"last_updated" json:"last_updated,omitempty"`
}
