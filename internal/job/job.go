package job

import (
	"context"
	"sync"
	"time"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/logger"
	"github.com/zerodoctor/zddashboard/internal/service"
)

var log = logger.Logger()

const (
	DAY   time.Duration = 24 * time.Hour
	WEEK  time.Duration = 7 * DAY
	MONTH time.Duration = 4 * WEEK
	YEAR  time.Duration = 52 * WEEK
)

func StartJobs(ctx context.Context, wg *sync.WaitGroup, dbh *db.DB, services *service.Services) {
	GoLatestFoodPrices(ctx, wg, dbh, services.HDservice)
	GoExchangeRates(ctx, wg, dbh, services.OEservice)
}
