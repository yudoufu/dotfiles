PREFIX?=$(HOME)
PLATFORM=$(shell uname)

LOCAL_PROFILE=$(PREFIX)/.zsh_local

LANGENV=nvm pyenv rbenv plenv
NVM_PATH=$(PREFIX)/.nvm
PYENV_PATH=$(PREFIX)/.pyenv
PYENV_VENV_PATH=$(PYENV_PATH)/plugins/python-virtualenv
RBENV_PATH=$(PREFIX)/.rbenv
RBENV_BUILD_PATH=$(RBENV_PATH)/plugins/ruby-build
PERLBREW_PATH=$(PREFIX)/perl5/perlbrew
PLENV_PATH=$(PREFIX)/.plenv

PROCESSERS=node ruby python perl
NODE_VERSION=0.8.14
PYTHON_VERSION=2.7.3
RUBY_VERSION=1.9.3-p362
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

setup: otherenv $(foreach target, $(LANGENV), $(target)-install) $(PROCESSERS)

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

ruby:
	rbenv install $(RUBY_VERSION)
	rbenv exec gem install bundler --no-ri --no-rdoc
	rbenv rehash

rbenv-update:
	cd $(RBENV_PATH);\
		git pull
	cd $(RBENV_BUILD_PATH);\
		git pull

rbenv-install:
	git clone git://github.com/sstephenson/rbenv.git $(RBENV_PATH)
	git clone git://github.com/sstephenson/ruby-build.git $(RBENV_BUILD_PATH)
	echo 'export PATH="$(RBENV_PATH)/bin:$$PATH"' >> $(LOCAL_PROFILE)
	echo 'eval "$$(rbenv init -)"' >> $(LOCAL_PROFILE)

perl:
	perlbrew install perl-$(PERL_VERSION)

perlbrew-update:
	perlbrew self-upgrade

perlbrew-install:
	curl -kL http://install.perlbrew.pl | PERLBREW_ROOT=$(PERLBREW_PATH) bash
	echo 'source $(PERLBREW_PATH)/etc/bashrc' >> $(LOCAL_PROFILE)

plenv-update:
	cd $(PLENV_PATH);\
		git pull

plenv-install:
	git clone git://github.com/tokuhirom/plenv.git $(PLENV_PATH)
	echo 'export PATH="$(PLENV_PATH)/bin:$$PATH"' >> $(LOCAL_PROFILE)
	echo 'eval "$$(plenv init -)"' >> $(LOCAL_PROFILE)



otherenv:
	echo 'export MAKEOPTS="-j $(shell expr `cat /proc/cpuinfo |grep processor |wc -l` + 2)"' >> $(LOCAL_PROFILE)
