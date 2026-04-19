DOTFILES := $(shell pwd)
CLAUDE_SKILLS_SRC := $(DOTFILES)/darwin/.claude/skills
CLAUDE_SKILLS_DST := $(HOME)/.claude/skills

.PHONY: install stow vscode claude-skills

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
