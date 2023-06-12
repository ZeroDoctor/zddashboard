package job

import (
	"context"
	"time"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

const LFP_PERIOD time.Duration = YEAR

func GoLatestFoodPrices(ctx context.Context, dbh *db.DB, hds *service.HumanDataService) {
	log.Info("running latest food prices ticker...")

	tick := time.NewTicker(LFP_PERIOD)
	defer tick.Stop()

	go func() {
		for {
			select {
			case <-ctx.Done():
				return
			case t := <-tick.C:
				log.Infof("running latest food prices job [tick=%s]...", t.UTC().Format(time.RFC3339))
				RunLatestFoodPrices(dbh, hds)
				log.Infof("ended latest food prices job [tick=%s]...", time.Now().UTC().Format(time.RFC3339))
			}
		}
	}()

	log.Info("stop latest food prices ticker...")
}

func RunLatestFoodPrices(dbh *db.DB, hds *service.HumanDataService) {
	calls, err := dbh.GetAPICalls(model.FOOD_PRICES)
	if err != nil {
		log.Errorf("failed to get api calls for [data=%s] [error=%s]", model.FOOD_PRICES, err.Error())
		return
	}

	if len(calls) > 0 && time.Since(time.Time(calls[0].CallAt)) < LFP_PERIOD {
		log.Infof("job not schdule to run [now=%s]", time.Now().Format(time.RFC3339))
		return
	}

	if _, err := hds.GetLatestGlobalFoodPricesData(); err != nil {
		log.Errorf("failed to get latest food prices [error=%s]", err.Error())
	}
}
