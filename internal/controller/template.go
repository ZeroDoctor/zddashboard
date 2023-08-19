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

	root := "./ui/build/web/"
	fileSystem := os.DirFS(root)

	if err := fs.WalkDir(fileSystem, ".", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			log.Errorf("failed to walk [path=%s] [error=%s]", path, err.Error())
			return err
		}

		if IsAssetFile(path) {
			log.Debugf("adding static file [path=%s]", path)
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

		log.Debugf("adding index file [path=%s] [len(file)=%d]", path, len(file))
		t, err = t.New(path).Parse(string(file))
		return err
	}); err != nil {
		return t, err
	}

	return t, nil
}

func IsAssetFile(file string) bool {
	return strings.HasSuffix(file, ".css") ||
		strings.HasSuffix(file, ".js") ||
		strings.HasSuffix(file, ".otf") ||
		strings.HasSuffix(file, ".ttf") ||
		strings.HasSuffix(file, ".frag") ||
		strings.HasSuffix(file, ".json") ||
		strings.HasSuffix(file, ".bin") ||
		strings.HasSuffix(file, ".png")
}
