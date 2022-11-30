SOURCEFILES=_site/
DEPLOY_DEST=generati@amirdekel.com:public_html/

# Make a fresh site build (only content) and deploy
deploy:
	make cv
	make rebuild
	rsync -av --delete -e "ssh" $(SOURCEFILES) $(DEPLOY_DEST)

# Make a fresh site build and develop on localhost:8000
dev:
	make rebuild
	stack exec site watch

# Make a fresh site build
rebuild:
	stack exec site rebuild

# Use Pandoc directly to create CV pdf
cv:
	cd cv; pandoc --read=org --write=latex --output=cv.pdf --pdf-engine=xelatex --standalone --include-in-header=setup.sty --metadata-file=meta.yaml english.org
	mv -f cv/cv.pdf pages

.PHONY: deploy dev rebuild cv
