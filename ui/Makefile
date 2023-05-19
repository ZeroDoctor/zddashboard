.PHONY: serve
serve:
	webdev serve

.PHONY: dev
dev:
	npx tailwindcss -i ./web/styles.css -o ./web/dist/output.css

.PHONY: build
build: webdev-build build-tailwindcss

.PHONY: webdev-build
webdev-build: 
	mkdir build || true
	webdev build

.PHONY: webdev-install
webdev-install:
	dart pub add build_runner build_web_compilers --dev
	dart pub global activate webdev
	echo 'export PATH=$$PATH:$$HOME/.pub-cache/bin' >> ~/.bashrc
	source ~/.bashrc

.PHONY: build-tailwindcss
build-tailwindcss:
	npx tailwindcss -i ./build/styles.css -o ./build/dist/output.css
	
.PHONY: init
init:
	mkdir build || true
	npm i
	dart pub get
	
