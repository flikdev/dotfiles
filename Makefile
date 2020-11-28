CWD=$(shell pwd)
DISTRO=$(shell uname)

install:
	make $(HOME)/.bashrc
	make $(HOME)/.emacs.d

uninstall:
	test -L $(HOME)/.bashrc && rm -vf $(HOME)/.bashrc
	test -L $(HOME)/.emacs.d && rm -vrf $(HOME)/.emacs.d

test:
	mkdir test
	make install HOME=$(CWD)/test
	test -L $(CWD)/test/.bashrc
	test -L $(CWD)/test/.emacs.d

clean:
	make uninstall HOME=$(CWD)/test
	rm -r test

$(HOME)/.bashrc:
	ln -vs $(CWD)/bashrc $(HOME)/.bashrc

$(HOME)/.emacs.d:
	git clone --depth 1 https://github.com/seagle0128/.emacs.d.git $(CWD)/emacs.d
	ln -vs $(CWD)/emacs.d $(HOME)/.emacs.d
