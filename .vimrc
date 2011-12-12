"""""
" .vimrc
"
" Maintainer:   Daichi Kamemoto (a.k.a:yudoufu) <daikame@gmail.com>
" Last Change:  2011/02/21
" Version:      0.0.9
"
" customized vim settings
"""""
"""""
" Settings customize based pathogen.
"  this settings refer to http://d.hatena.ne.jp/vimtaku/20110219
"
" Basic Settings
" .vim/bundle/vimrc/plugin/base.vim
"
" Heighlight Settings
" .vim/bundle/vimrc/plugin/syntax.vim
"
" Key mappign Settings
" .vim/bundle/vimrc/plugin/mapping.vim
"
" Plugin Settings on vimrc file
" .vim/bundle/vimrc/plugin/plugins.vim
"
" vim-utility Functions and Settings
" .vim/bundle/vimrc/plugin/util.vim
"
" vim Filetype Settings Dir
" .vim/bundle/vimrc/ftplugin
"""""

" Load Vundle
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()

" Load Self Plugin
Bundle 'vimrc'

" Load Plugins on github
Bundle 'tpope/vim-surround'
Bundle 'thinca/vim-ref'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'thinca/vim-quickrun'
Bundle 'sjl/gundo.vim'
Bundle 'kchmck/vim-coffee-script'

" Load Plugins on vim.org
Bundle 'SQLUtilities'

filetype on

