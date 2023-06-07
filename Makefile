
.PHONY: init 
init: 
	cd ui && make init
	go install github.com/swaggo/swag/cmd/swag@latest

.PHONY: build-swagger
build-swagger:
	swag fmt
	swag init -g ./internal/controller/*.go

.PHONY: ui
ui:
	cd ui && make build || true

.PHONY: serve
serve: ui 
	go run ./cmd

.PHONY: build 
build: ui build-swagger
	go build -o zddashboard ./cmd/main.go
	
.PHONY: br 
br: build
	./zddashboard