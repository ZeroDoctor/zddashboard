
.PHONY: init 
init: 
	cd ui && make init
	go install github.com/swaggo/swag/cmd/swag@latest

.PHONY: build-swagger
build-swagger:
	swag fmt
	swag init -g ./internal/controller/*.go

.PHONY: format
format:
	swag fmt

.PHONY: ui
ui:
	cd ui && make build || true

.PHONY: serve
serve: ui 
	go run ./cmd

.PHONY: build 
build: ui build-swagger
	go build -o zddashboard ./cmd/*.go
	
.PHONY: br 
br: build
	./zddashboard w