
node_modules:; npm install
install:; npm install
i: install

dev: node_modules
	$(shell npm bin)/parcel src/index.html

build: node_modules
	rm -rf dist
	# mkdir -p dist/photoswipe
	# cp -R node_modules/photoswipe/dist/* dist/photoswipe
	$(shell npm bin)/parcel build src/index.html
	echo "https://akashito.com" > dist/CNAME
	mkdir -p dist/phone
	echo '<html><head><meta http-equiv="refresh" content="0; URL='/'" /></head></html>' > dist/phone/index.html
	mkdir -p dist/tablet
	echo '<html><head><meta http-equiv="refresh" content="0; URL='/'" /></head></html>' > dist/tablet/index.html

pull.subtree:
	-git push origin `git subtree split --prefix dist master`:gh-pages --force

deploy: pull.subtree build
	git fetch origin
	git add -f dist
	git commit -m "build"
	-git subtree push --prefix=dist origin gh-pages
	git reset --soft HEAD~1
	git reset HEAD