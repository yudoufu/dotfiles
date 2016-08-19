PREFIX?=$(HOME)
PLATFORM=$(shell uname)

LOCAL_PROFILE=$(PREFIX)/.zsh_local

LANGENV=pyenv rbenv plenv nvm
NVM_PATH=$(PREFIX)/.nvm
PYENV_PATH=$(PREFIX)/.pyenv
PYENV_VENV_PATH=$(PYENV_PATH)/plugins/python-virtualenv
RBENV_PATH=$(PREFIX)/.rbenv
RBENV_BUILD_PATH=$(RBENV_PATH)/plugins/ruby-build
PLENV_PATH=$(PREFIX)/.plenv
PLENV_BUILD_PATH=$(PLENV_PATH)/plugins/perl-build
PHPENV_PATH=$(PREFIX)/.phpenv
PHPENV_BUILD_PATH=$(PREFIX)/.phpenv/plugins/php-build

PROCESSERS=ruby python perl node
NODE_VERSION=0.10.33
PYTHON_VERSION=3.4.2
RUBY_VERSION=2.1.4
PERL_VERSION=5.21.5

all: self-update symlink git-update vim-plugin

world: all setup

self-update:
	git pull

NOLINK=. .. .svn .git .gitignore
symlink: $(foreach target, $(filter-out $(NOLINK), $(wildcard .*)), set-symlink-$(target))

set-symlink-%: %
	@echo "create symlink $(CURDIR)/$< to $(PREFIX)/$<"
	@ln -fvs $(CURDIR)/$< $(PREFIX)/

git-update:
	git pull
	git submodule update --init
	git submodule foreach 'git checkout master; git pull'

.PHONY: vim-neobundle-update vim-plugin
BUNDLE_DIR=$(CURDIR)/.vim/bundle
NEOBUNDLE_DIR=$(BUNDLE_DIR)/neobundle.vim

$(BUNDLE_DIR):
	mkdir -p $(BUNDLE_DIR)

$(NEOBUNDLE_DIR):
	git clone https://github.com/Shougo/neobundle.vim $(NEOBUNDLE_DIR)

vim-neobundle-update: $(NEOBUNDLE_DIR)
	cd $(BUNDLE_DIR)/neobundle.vim; git pull

vim-plugin: $(BUNDLE_DIR) $(NEOBUNDLE_DIR) vim-neobundle-update
	ln -fvs ../vimrc $(BUNDLE_DIR)/
ifeq ($(PLATFORM), Darwin)
	vim -Nes -u $(CURDIR)/.vimrc -i NONE -V1 -c NeoBundleInstall! -c qall! ; /usr/bin/true
else
	vim -Nes -u $(CURDIR)/.vimrc -i NONE -V1 -c NeoBundleInstall! -c qall! ; /bin/true
endif

update: $(foreach target, $(LANGENV), $(target)-update)

setup: otherenv git-highlight-install langenv lang

langenv: $(foreach target, $(LANGENV), $(target)-install)

lang: $(PROCESSERS)

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
	cd $(PREFIX); pyenv local $(PYTHON_VERSION)
	pyenv rehash

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
	cd $(PREFIX); rbenv local $(RUBY_VERSION)
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
	plenv install $(PERL_VERSION)
	cd $(PREFIX); plenv local $(PERL_VERSION)
	plenv install-cpanm
	plenv rehash

plenv-update:
	cd $(PLENV_PATH);\
		git pull

plenv-install:
	git clone git://github.com/tokuhirom/plenv.git $(PLENV_PATH)
	git clone git://github.com/tokuhirom/Perl-Build.git $(PLENV_BUILD_PATH)
	echo 'export PATH="$(PLENV_PATH)/bin:$$PATH"' >> $(LOCAL_PROFILE)
	echo 'eval "$$(plenv init -)"' >> $(LOCAL_PROFILE)

phpenv-install:
	curl https://raw.github.com/CHH/phpenv/master/bin/phpenv-install.sh | bash
	git clone git://github.com/CHH/php-build.git $(PHPENV_BUILD_PATH)
	echo 'export PATH="$(PHPENV_PATH)/bin:$$PATH"' >> $(LOCAL_PROFILE)
	echo 'eval "$$(phpenv init -)"' >> $(LOCAL_PROFILE)

otherenv:
	mkdir -p $(HOME)/bin
	echo 'export PATH="$$HOME/bin:$$PATH"' >> $(LOCAL_PROFILE)
	echo 'export MAKEOPTS="-j $(shell expr `cat /proc/cpuinfo |grep processor |wc -l` + 2)"' >> $(LOCAL_PROFILE)

git-highlight-install:
	cd $(HOME)/bin;\
		curl -O https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight &&\
		chmod +x diff-highlight

.DEFAULT_GOAL := all
