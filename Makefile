PWD=$(shell pwd)
DISTRO=$(shell uname)

.PHONY: all
all: zsh emacs

.PHONY: clean
clean:
	rm -vf $(HOME)/.zshrc
	rm -vf $(HOME)/.zshenv
	rm -vrf $(HOME)/.emacs.d

.PHONY: zsh
zsh:
	ln -vfs $(PWD)/.zshrc $(HOME)/.zshrc
	ln -vfs $(PWD)/.zshenv $(HOME)/.zshenv

.PHONY: emacs
emacs:
	git clone --depth 1 https://github.com/seagle0128/.emacs.d.git $(HOME)/.emacs.d
	cp -rp $(PWD)/custom.el $(HOME)/.emacs.d/custom.el
