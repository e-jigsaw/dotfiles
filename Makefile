DOTFILES := $(shell pwd)

.PHONY: install stow vscode

install: stow vscode

stow:
	stow -v -t ~ darwin
	stow -v --dotfiles -t ~ common

vscode:
ifeq ($(shell uname),Darwin)
	@mkdir -p ~/Library/Application\ Support/Code/User
	@ln -sf $(DOTFILES)/files/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
	@echo "VSCode settings linked"
endif
