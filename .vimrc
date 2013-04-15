"""""
" .vimrc
"
" Maintainer:   Daichi Kamemoto (a.k.a:yudoufu) <daikame@gmail.com>
" Last Change:  2012/12/12
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

let s:nosudo = $SUDO_USER == ''

" Load neobundle
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Load Self Plugin
NeoBundle 'vimrc', {'type': 'nosync'}

" Load Plugins on github
if s:nosudo
    NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimshell'
endif
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }
NeoBundle 'Shougo/neosnippet'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'kana/vim-vspec'
"NeoBundle 'kana/vim-smartinput'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'heavenshell/vim-quickrun-hook-unittest'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'StanAngeloff/php.vim'

"" color schema
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'jpo/vim-railscasts-theme'

" Load Plugins on vim.org
NeoBundle 'django.vim'
NeoBundle 'SQLUtilities'
if s:nosudo
    NeoBundle 'sudo.vim'
endif

" Load Plugins on other sites
NeoBundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

filetype plugin indent on

