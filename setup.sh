#!/bin/sh

# setup dot files symbolic link
DIR=$(cd $(dirname $0);pwd)
for FILE in `ls -A --ignore='*' --ignore='.svn' --ignore='.git' --ignore='.gitignore' $DIR`
do
  ln -ivs $DIR/$FILE ~
done

# setup git submodule plugins
cd $DIR
git pull
git submodule init
git submodule update

# setup my vimrc files
cd .vim/bundle
ln -s ../vimrc

