package job

import (
	"context"
	"sync"
	"time"

	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/service"
	"github.com/zerodoctor/zddashboard/internal/service/api/model"
)

const ER_PERIOD time.Duration = 12 * time.Hour

func GoExchangeRates(ctx context.Context, wg *sync.WaitGroup, dbh *db.DB, oes *service.OpenExchangeService) {
	log.Info("running latest exchange rates ticker...")
	wg.Add(1)

	tick := time.NewTicker(ER_PERIOD)
	defer tick.Stop()

	go func() {
		for {
			select {
			case <-ctx.Done():
				log.Info("stop latest exchange rates ticker...")
				wg.Done()
				return
			case t := <-tick.C:
				log.Infof("running latest exchange rates job [tick=%s]...", t.UTC().Format(time.RFC3339))
				RunLatestExchangeRates(dbh, oes)
				log.Infof("ended latest exchange rates job [tick=%s]...", time.Now().UTC().Format(time.RFC3339))
			}
		}
	}()
}

func RunLatestExchangeRates(dbh *db.DB, oes *service.OpenExchangeService) {
	calls, err := dbh.GetAPICalls(model.EXCHANGE_RATE)
	if err != nil {
		log.Errorf("failed to get api calls for [data=%s] [error=%s]", model.EXCHANGE_RATE, err.Error())
		return
	}

	if len(calls) > 0 && time.Since(time.Time(calls[0].CallAt)) < ER_PERIOD {
		log.Infof("job not schdule to run [now=%s]", time.Now().Format(time.RFC3339))
		return
	}

	if _, err := oes.GetLatestExchangeRates(); err != nil {
		log.Errorf("failed to get latest exchange rates [error=%s]", err.Error())
	}
}
