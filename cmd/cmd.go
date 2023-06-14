package main

import (
	"context"
	"os"
	"sync"

	"github.com/urfave/cli/v2"
	"github.com/zerodoctor/zddashboard/internal/controller"
	"github.com/zerodoctor/zddashboard/internal/db"
	"github.com/zerodoctor/zddashboard/internal/job"
	"github.com/zerodoctor/zddashboard/internal/service"
	zdutil "github.com/zerodoctor/zdgo-util"
)

func ConnectDB() *db.DB {
	conn, err := db.NewSqliteDB(DB_NAME)
	if err != nil {
		log.Fatalf("failed to connect to sqlite db [error=%s]", err.Error())
	}

	if err := conn.ExecSchemaFile(SCHEMA_FILE); err != nil {
		log.Fatalf("failed to execute schema [file=%s] [error=%s]", SCHEMA_FILE, err.Error())
	}

	return conn
}

func WebCmd(wg *sync.WaitGroup) *cli.Command {
	return &cli.Command{
		Name:    "web",
		Aliases: []string{"w"},
		Usage:   "init db, start jobs, and runs web service",
		Action: func(ctx *cli.Context) error {
			conn := ConnectDB()

			services := service.NewServices(conn)

			job.StartJobs(ctx.Context, wg, conn, services)

			if err := controller.NewController(conn, services).Run(os.Getenv("WEB_PORT")); err != nil {
				log.Fatalf("failed to run gin controller [error=%s]", err.Error())
			}

			return nil
		},
	}
}

func JobCmd() *cli.Command {
	return &cli.Command{
		Name:    "job",
		Aliases: []string{"j"},
		Flags: []cli.Flag{
			&cli.BoolFlag{
				Name:    "latest_exchange",
				Aliases: []string{"oe"},
				Usage:   "run open exchange job to grab latest exchange rates",
			},
			&cli.BoolFlag{
				Name:    "latest_food_prices",
				Aliases: []string{"lfp"},
				Usage:   "grabs latest global food prices",
			},
		},

		Action: func(ctx *cli.Context) error {
			conn := ConnectDB()

			services := service.NewServices(conn)

			if ctx.Bool("latest_exchange") {
				job.RunLatestExchangeRates(conn, services.OEservice)
			}

			if ctx.Bool("latest_food_prices") {
				job.RunLatestFoodPrices(conn, services.HDservice)
			}

			return nil
		},
	}
}

func RunCmd() {
	var wg sync.WaitGroup

	app := cli.NewApp()
	app.Commands = []*cli.Command{
		WebCmd(&wg),
		JobCmd(),
	}

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	go func() {
		if err := app.RunContext(ctx, os.Args); err != nil {
			log.Fatalf("failed to run cli [error=%s]", err.Error())
		}
		cancel()
	}()

	zdutil.OnExitWithContext(ctx, func(s os.Signal, args ...interface{}) {
		log.Info("cleaning up...")
		cancel()
	})

	wg.Wait()
	log.Info("bye.")
}
