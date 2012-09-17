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

" Load neobundle
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Load Self Plugin
NeoBundle 'vimrc'

" Load Plugins on github
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'kana/vim-vspec'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'tpope/vim-surround'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'heavenshell/vim-quickrun-hook-unittest'

" Load Plugins on vim.org
NeoBundle 'SQLUtilities'
NeoBundle 'sudo.vim'

" Load Plugins on other sites
NeoBundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

filetype plugin indent on

