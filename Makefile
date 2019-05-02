
dev:
	$(shell npm bin)/parcel src/index.html

build:
	$(shell npm bin)/parcel build src/index.html
	echo "akashito.com" dist/CNAME

deploy: build
	git fetch origin
	git add -f dist
	git commit -m "build"
	-git subtree push --prefix=dist origin gh-pages
	git reset --soft HEAD~1
	git reset HEAD