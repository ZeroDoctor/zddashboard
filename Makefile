
.PHONY: serve
serve:
	cd ui && make build || true
	go run ./cmd