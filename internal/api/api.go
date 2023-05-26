package api

import (
	"io"
	"net/http"
	"net/url"
	"time"

	"github.com/zerodoctor/zddashboard/internal/logger"
)

var log = logger.Logger()

type APILimiter struct {
	Start time.Time
	Count int
}

type API struct {
	host        string
	client      *http.Client
	baseQueries map[string]string
}

func (a *API) Call(method, path string, queries map[string]string, body io.Reader) (*http.Response, error) {
	baseURL := a.host + path
	values := url.Values{}
	for k, v := range queries {
		values.Set(k, v)
	}
	for k, v := range a.baseQueries {
		values.Set(k, v)
	}
	perform := baseURL + "?" + values.Encode()

	log.Debugf("api call [method=%s] [path=%s] [has_body=]",
		method, perform, body == nil,
	)

	req, err := http.NewRequest(method, perform, body)
	if err != nil {
		return nil, err
	}

	resp, err := a.client.Do(req)
	if err != nil {
		return nil, err
	}

	return resp, nil
}
