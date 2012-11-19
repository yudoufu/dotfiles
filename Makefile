
all: symlink git-update vim-plugin

NOLINK=. .. .svn .git .gitignore
symlink: $(foreach target, $(filter-out $(NOLINK), $(wildcard .*)), set-symlink-$(target))

set-symlink-%: %
	@echo "create symlink $(CURDIR)/$< to $(HOME)/$<"
	@ln -fvs $(CURDIR)/$< $(HOME)/

git-update:
	git pull
	git submodule update --init
	git submodule foreach 'git checkout master; git pull'

BUNDLE_DIR=$(CURDIR)/.vim/bundle
vim-plugin:
	mkdir -p $(BUNDLE_DIR)
	ln -fvs -t $(BUNDLE_DIR)/ ../vimrc
	vim -Nes -u $(CURDIR)/.vimrc -i NONE -V1 -c NeoBundleInstall! -c qall! ; /bin/true

