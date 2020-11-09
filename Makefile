CWD=$(shell pwd)
DISTRO=$(shell uname)

install:
	make $(HOME)/.bashrc

uninstall:
	-test -L $(HOME)/.bashrc && rm -vf $(HOME)/.bashrc

test:
	mkdir test
	make install HOME=$(CWD)/test
	test -L $(CWD)/test/.bashrc

clean:
	make uninstall HOME=$(CWD)/test
	rm -r test

$(HOME)/.bashrc:
	ln -vs $(CWD)/bashrc $(HOME)/.bashrc
