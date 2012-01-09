#!/bin/sh

# setup dot files symbolic link
DIR=$(cd $(dirname $0);pwd)
for FILE in `ls -A --ignore='*' --ignore='.svn' --ignore='.git' --ignore='.gitignore' $DIR`
do
  ln -ivs $DIR/$FILE ~
done

# setup git submodule plugins
echo "Update git Submodules."
cd $DIR
git pull
git submodule init
git submodule update

# setup my vimrc files
BUNDLE_DIR=$DIR/.vim/bundle
if [ ! -d "$BUNDLE_DIR" ]; then
    echo "Create .vim/bundle dir."
    mkdir -p $BUNDLE_DIR
fi
if [ ! -h "$BUNDLE_DIR/vimrc" ]; then
    echo "Symlink vimrc dir."
    cd $BUNDLE_DIR
    ln -s ../vimrc
fi
vim +NeoBundleInstall +q

# setup oh-my-zsh theme bugfix
cd $DIR/.oh-my-zsh/themes
if [ ! -f $DIR/.oh-my-zsh/themes/linuxonly.zsh-theme ]; then
    echo "Fix oh-my-zsh's linuxonly theme And Craete linuxonly.zsh-theme."
    sed -e "s/\(.*foopath.*\)/#\1/" linuxonly >linuxonly.zsh-theme
fi
