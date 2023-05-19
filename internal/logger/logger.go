package logger

import (
	"fmt"
	"os"
	"runtime"

	"github.com/sirupsen/logrus"
)

var logger *Log

func init() {
	log := logrus.New()

	log.SetFormatter(&logrus.TextFormatter{
		ForceColors:            true,
		DisableTimestamp:       false,
		DisableLevelTruncation: false,
		FullTimestamp:          true,
		CallerPrettyfier: func(f *runtime.Frame) (function string, file string) {
			_, line := f.Func.FileLine(f.PC)
			fn := fmt.Sprintf("(%s|%d)", f.Func.Name(), line)

			return fn + " >>>", ""
		},
	})
	log.SetLevel(logrus.InfoLevel)
	if os.Getenv("ENV") != "prod" {
		log.SetLevel(logrus.DebugLevel)
	}

	logger = &Log{Logger: log}
}

type Log struct {
	*logrus.Logger
}

func Logger() *Log {
	return logger
}
