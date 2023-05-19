package controller

import (
	"html/template"
	"io/fs"
	"os"
	"strings"

	"github.com/gin-gonic/gin"
)

func loadTemplate(router *gin.Engine) (*template.Template, error) {
	t := template.New("")

	root := "./ui/build/"
	fileSystem := os.DirFS(root)

	if err := fs.WalkDir(fileSystem, ".", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			log.Errorf("failed to walk [path=%s] [error=%s]", path, err.Error())
			return err
		}

		if strings.HasSuffix(path, ".css") || strings.HasSuffix(path, ".js") {
			router.StaticFile("/"+path, root+path)
			return nil
		}

		if d.IsDir() || !strings.HasSuffix(path, ".html") {
			return nil
		}

		file, err := os.ReadFile(root + path)
		if err != nil {
			return err
		}

		t, err = t.New(path).Parse(string(file))
		return err
	}); err != nil {
		return t, err
	}

	return t, nil
}
