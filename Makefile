
dev:
	$(shell npm bin)/parcel src/index.html

build:
	rm -rf dist
	$(shell npm bin)/parcel build src/index.html
	echo "akashito.com" > dist/CNAME
	mkdir -p dist/phone
	echo '<html><head><meta http-equiv="refresh" content="0; URL='/'" /></head></html>' > dist/phone/index.html
	mkdir -p dist/tablet
	echo '<html><head><meta http-equiv="refresh" content="0; URL='/'" /></head></html>' > dist/tablet/index.html

pull.subtree:
	-git push origin `git subtree split --prefix dist gh-pages`:gh-pages --force

deploy: pull.subtree build
	git fetch origin
	git add -f dist
	git commit -m "build"
	-git subtree push --prefix=dist origin gh-pages
	git reset --soft HEAD~1
	git reset HEAD