
.PHONY: init 
init:
	cd ui && make init 

.PHONY: serve
serve:
	cd ui && make build || true
	go run ./cmd