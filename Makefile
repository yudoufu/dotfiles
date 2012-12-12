PREFIX?=$(HOME)
PLATFORM=$(shell uname)

LOCAL_PROFILE=$(PREFIX)/.zsh_local

LANGENV=nvm pyenv perlbrew
NVM_PATH=$(PREFIX)/.nvm
PYENV_PATH=$(PREFIX)/.pyenv
PYENV_VENV_PATH=$(PYENV_PATH)/plugins/python-virtualenv
PERLBREW_PATH=$(PREFIX)/perl5/perlbrew

PROCESSERS=node perl python
NODE_VERSION=0.8.14
PYTHON_VERSION=2.7.3
PERL_VERSION=5.16.2

all: symlink git-update vim-plugin

world: all setup

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

update: $(foreach target, $(LANGENV), $(target)-update)

setup: $(foreach target, $(LANGENV), $(target)-install) $(PROCESSERS)

node:
	nvm install v$(NODE_VERSION)
	nvm use v$(NODE_VERSION)
	nvm alias default v$(NODE_VERSION)

nvm-update:
	cd $(NVM_PATH);\
		git pull

nvm-install:
	git clone git://github.com/creationix/nvm.git $(NVM_PATH)
	echo 'source $(NVM_PATH)/nvm.sh' >> $(LOCAL_PROFILE)

python:
	pyenv install $(PYTHON_VERSION)

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

perl:
	perlbrew install perl-$(PERL_VERSION)

perlbrew-update:
	perlbrew self-upgrade

perlbrew-install:
	curl -kL http://install.perlbrew.pl | PERLBREW_ROOT=$(PERLBREW_PATH) bash
	echo 'source $(PERLBREW_PATH)/etc/bashrc' >> $(LOCAL_PROFILE)

