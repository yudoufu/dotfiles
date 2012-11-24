PREFIX=$(HOME)
PLATFORM=$(shell uname)

LOCAL_PROFILE=$(PREFIX)/.zsh_local
NVM_PATH=$(PREFIX)/.nvm
PYENV_PATH=$(PREFIX)/.pyenv
PYENV_VENV_PATH=$(PYENV_PATH)/plugins/python-virtualenv


all: symlink git-update vim-plugin

NOLINK=. .. .svn .git .gitignore
symlink: $(foreach target, $(filter-out $(NOLINK), $(wildcard .*)), set-symlink-$(target))

set-symlink-%: %
	@echo "create symlink $(CURDIR)/$< to $(PREFIX)/$<"
	@ln -fvs $(CURDIR)/$< $(PREFIX)/

git-update:
	git pull
	git submodule update --init
	git submodule foreach 'git checkout master; git pull'

BUNDLE_DIR=$(CURDIR)/.vim/bundle
vim-plugin:
	mkdir -p $(BUNDLE_DIR)
	ln -fvs ../vimrc $(BUNDLE_DIR)/
ifeq ($(PLATFORM), Darwin)
	vim -Nes -u $(CURDIR)/.vimrc -i NONE -V1 -c NeoBundleInstall! -c qall! ; /usr/bin/true
else
	vim -Nes -u $(CURDIR)/.vimrc -i NONE -V1 -c NeoBundleInstall! -c qall! ; /bin/true
endif

UPDATES=nvm pyenv perlbrew
update: $(foreach target, $(UPDATES), $(target)-update)

nvm-update:
	cd $(NVM_PATH);\
		git pull

nvm-install:
	git clone git://github.com/creationix/nvm.git $(NVM_PATH)
	echo 'source $(NVM_PATH)/nvm.sh' >> $(LOCAL_PROFILE)

pyenv-update:
	cd $(PYENV_PATH);\
		git pull
	cd $(PYENV_VENV_PATH);\
		git pull

pyenv-install:
	git clone git://github.com/yyuu/pyenv.git $(PYENV_PATH)
	git clone git://github.com/yyuu/python-virtualenv.git $(PYENV_VENV_PATH)
	echo 'export PATH="$(PYENV_PATH)/bin:$$PATH"' >> $(LOCAL_PROFILE)
	echo 'eval "$$(pyenv init -)"' >> $(LOCAL_PROFILE)

perlbrew-update:
	perlbrew self-upgrade

perlbrew-install:
	curl -kL http://install.perlbrew.pl | bash
	echo 'source ~/perl5/perlbrew/etc/bashrc' >> $(LOCAL_PROFILE)

