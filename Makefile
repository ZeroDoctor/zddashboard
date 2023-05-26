
.PHONY: init 
init:
	cd ui && make init 

.PHONY: ui
ui:
	cd ui && make build || true

.PHONY: serve
serve: ui 
	go run ./cmd

.PHONY: build 
build: ui 
	go build -o zddashboard ./cmd/main.go
