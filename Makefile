#!make
SHELL := env PATH=$(shell npm bin):$(PATH) /bin/bash -O extglob

.SILENT:
.PHONY: dist assets dist/index.html dist/styles.css dist/main.js

node_modules:; npm set strict-ssl false; npm install
install:; npm set strict-ssl false; npm install
i: install

clean:; rm -rf dist
dist:; mkdir -p dist

assets:
	mkdir -p ./dist/assets
	cp -r ./assets/* ./dist/assets/

dist/index.html: dist
	node ./envsubst.js < ./src/index.html > ./dist/index.html

dist/styles.css: dist
	sass src/styles.sass | postcss > ./dist/styles.css \
		--indented

dist/main.js: dist
	esbuild src/main.js --outdir=dist \
		--bundle --minify \
		--target=chrome58,firefox57,safari11,edge16 \
		${BUNDLE_FLAGS}

build: node_modules clean dist
	$(MAKE) assets
	$(MAKE) dist/index.html
	$(MAKE) dist/styles.css
	$(MAKE) dist/main.js
	# mkdir -p dist/photoswipe
	# cp -R node_modules/photoswipe/dist/* dist/photoswipe
	echo "https://akashito.com" > dist/CNAME
	mkdir -p dist/phone
	echo '<html><head><meta http-equiv="refresh" content="0; URL='/'" /></head></html>' > dist/phone/index.html
	mkdir -p dist/tablet
	echo '<html><head><meta http-equiv="refresh" content="0; URL='/'" /></head></html>' > dist/tablet/index.html

up: export BUNDLE_FLAGS=--sourcemap
up: build

	fsdir -d src \
		--watch '{,**/}*.js' 'make dist/main.js' \
		--watch '{,**/}*.sass' 'make dist/styles.css' \
		--watch '{,**/}*.html' 'make dist/index.html' &
	
	servor dist --browse --reload

	wait < <(jobs -p)


pull.subtree:
	-git push origin `git subtree split --prefix dist master`:gh-pages --force

deploy: export BUNDLE=production
deploy: pull.subtree build
	git fetch origin
	git add -f dist
	git commit -m "build"
	-git subtree push --prefix=dist origin gh-pages
	git reset --soft HEAD~1
	git reset HEAD