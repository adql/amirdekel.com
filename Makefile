SOURCEFILES=_site/
DEPLOY_DEST=generati@amirdekel.com:public_html/

# Make a fresh site build (only content) and deploy
deploy:
	make rebuild
	rsync -av --delete -e "ssh" $(SOURCEFILES) $(DEPLOY_DEST)

# Make a fresh site build and develop on localhost:8000
dev:
	make rebuild
	stack exec site watch

# Make a fresh site build
rebuild:
	stack exec site rebuild
