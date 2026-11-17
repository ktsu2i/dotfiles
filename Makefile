.PHONY: install brew link mise

BIN := /opt/homebrew/bin

install: brew link mise

brew:
	$(BIN)/brew bundle --file=Brewfile --no-upgrade

link:
	scripts/link.sh

mise:
	$(BIN)/mise install
