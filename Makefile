.PHONY: install brew link mise

install: brew link mise

brew:
	brew bundle --file=Brewfile --no-upgrade

link:
	scripts/link.sh

mise:
	mise install
