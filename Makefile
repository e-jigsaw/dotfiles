SHELL := /bin/bash
DOTFILES := $(shell pwd)
CLAUDE_SKILLS_SRC := $(DOTFILES)/darwin/.claude/skills
CLAUDE_SKILLS_DST := $(HOME)/.claude/skills
NIX_DARWIN := $(HOME)/.config/nix-darwin

.PHONY: install stow vscode claude-skills update switch

install: stow vscode claude-skills

stow:
	stow -v -t ~ darwin
	stow -v --dotfiles -t ~ common

vscode:
ifeq ($(shell uname),Darwin)
	@mkdir -p ~/Library/Application\ Support/Code/User
	@ln -sf $(DOTFILES)/files/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
	@echo "VSCode settings linked"
endif

claude-skills:
	@mkdir -p $(CLAUDE_SKILLS_DST)
	@for dir in $(CLAUDE_SKILLS_SRC)/*/; do \
		name=$$(basename $$dir); \
		ln -sfn $$dir $(CLAUDE_SKILLS_DST)/$$name; \
		echo "Linked claude skill: $$name"; \
	done

# nix flake inputs を更新 (flake.lock 書き換え)
update:
	nix flake update --flake $(NIX_DARWIN)

# nix-darwin 設定を適用。LocalHostName が flake の構成名と一致すればそれを
# 自動適用し、一致しなければ select メニューで選ぶ (HOST=<name> で明示も可)。
switch:
	@host="$(HOST)"; \
	if [ -z "$$host" ]; then \
		hosts="$$(nix eval --raw $(NIX_DARWIN)#darwinConfigurations --apply 'c: toString (builtins.attrNames c)')"; \
		lh="$$(/usr/sbin/scutil --get LocalHostName 2>/dev/null)"; \
		if [ -n "$$lh" ] && [[ " $$hosts " == *" $$lh "* ]]; then \
			host="$$lh"; \
			echo "LocalHostName matched: $$host"; \
		else \
			PS3="apply which config? "; \
			select h in $$hosts; do [ -n "$$h" ] && host="$$h" && break; done; \
		fi; \
	fi; \
	echo "switching to $$host..."; \
	sudo darwin-rebuild switch --flake "$(NIX_DARWIN)#$$host"
