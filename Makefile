config: git zsh emacs i3 bin tmux dunst
.PHONY: git zsh emacs i3 bin tmux dunst

LN = ln -f -s -v

git:
	$(LN) $(CURDIR)/git/gitignore $(HOME)/.gitignore
	$(LN) $(CURDIR)/git/gitconfig $(HOME)/.gitconfig

zsh:
	$(LN) $(CURDIR)/zsh/zshenv $(HOME)/.zshenv
	$(LN) $(CURDIR)/zsh/zshrc $(HOME)/.zshrc

emacs:
	$(LN) $(CURDIR)/emacs/emacs $(HOME)/.emacs.d
	mkdir -p $(HOME)/.emacs.d
	$(LN) $(CURDIR)/emacs/melpa $(CURDIR)/emacs/helm $(CURDIR)/emacs/config* $(HOME)/.emacs.d/

i3:
	mkdir -p $(HOME)/.i3
	$(LN) $(CURDIR)/i3/* $(HOME)/.i3/

bin:
	mkdir -p $(HOME)/bin
	$(LN) $(CURDIR)/bin/* $(HOME)/bin/

tmux:
	$(LN) $(CURDIR)/tmux.conf $(HOME)/.tmux.conf

dunst:
	mkdir -p $(HOME)/.config/dunst
	$(LN) $(CURDIR)/dunstrc $(HOME)/.config/dunst/dunstrc
