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
	webdev build

.PHONY: webdev-install
webdev-install:
	dart pub add build_runner build_web_compilers --dev
	dart pub global activate webdev
	echo 'export PATH=$$PATH:$$HOME/.pub-cache/bin' >> ~/.bashrc
	source ~/.bashrc

.PHONY: dev build-tailwindcss
build-tailwindcss:
	npx tailwindcss -i ./build/styles.css -o ./build/dist/output.css
	
.PHONY: init
init:
	npm i
	mkdir ./build/dist/js || true
	mkdir ./web/dist/js || true
	cp ./node_modules/litegraph.js/css/litegraph.css ./build/dist/litegraph.css
	cp ./node_modules/litegraph.js/css/litegraph.css ./web/dist/litegraph.css
	cp ./node_modules/litegraph.js/build/litegraph.js ./build/dist/js/litegraph.js
	cp ./node_modules/litegraph.js/build/litegraph.js ./web/dist/js/litegraph.js
	dart pub get
	
