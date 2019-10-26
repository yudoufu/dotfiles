" ==============================================================================
" init.vim / .vimrc
"
" Maintainer:   Daichi Kamemoto (a.k.a:yudoufu) <daikame@gmail.com>
"
" ==============================================================================

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environments





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialize

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if &compatible
  set nocompatible               " Be iMproved
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Settings

set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set fileformats=unix,dos,mac

set history=999
set nobackup

"set verbosefile=/tmp/vim.log
"set verbose=20

"""""
" Status line

set laststatus=2
set ruler
set title
set showcmd
set showmode
" コマンドの補完をシェルっぽく
set wildmode=list:longest

"""""
" Behavior Settings

set backspace=indent,eol,start
set autoindent
set incsearch
" 検索文字列が小文字のときはCaseを無視。大文字が混在している場合は区別する。
set ignorecase
set smartcase
set wrapscan
" バッファが編集中でもファイルを開けるようにする
set hidden
" 編集中のファイルが外部のエディタから変更された場合には、自動で読み直し
set autoread
" 編集中のファイルがあるディレクトリに移動
set autochdir
" 親ディレクトリをあさってtagsを探し出し、ctagsを有効にする
set tags+=tags;
"set tags+=./**/tags "サブディレクトリ以下のctagsも探す

"""""
" View window Settings

set list
"set listchars=tab:>\ ,trail:\ ,extends:>
set listchars=tab:\ \ ,trail:\ ,extends:>
set number
set showmatch
set hlsearch
set wrap
set novisualbell

"""""
"Tabs  Settings

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0


"""""
" Edit

" yank と clipboardを連携
"set clipboard+=unnamedplus

" Open時、前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" vimgrep時に標準でQuickfixを使う
augroup VimgrepResult
    autocmd!
    autocmd QuickfixCmdPost vimgrep cwin
augroup END

" ESC2回で検索ハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


"""""
" filetype Settings

"augroup FileTypeSettings
"    autocmd BufRead,BufNewFile Berksfile setfiletype ruby
"    autocmd BufRead,BufNewFile Vagrantfile setfiletype ruby
"    autocmd BufRead,BufNewFile *.md,*.markdown setlocal filetype=ghmarkdown
"    autocmd BufRead,BufNewFile *.twig setfiletype htmldjango
"    autocmd BufRead,BufNewFile *.twig if &filetype == 'twig' | set filetype=htmldjango | endif
"    autocmd BufRead,BufNewFile *.less setfiletype less
"    autocmd BufRead,BufNewFile *.go setfiletype go
"    autocmd BufRead,BufNewFile *.nas setfiletype nasm
"augroup END

" skeletonファイルを読み込む
augroup SkeletonLoad
    autocmd!
    autocmd BufNewFile *.html 0r ~/.config/nvim/skeleton/skeleton.html
    autocmd BufNewFile *.php  0r ~/.config/nvim/skeleton/skeleton.php
    autocmd BufNewFile *.pl   0r ~/.config/nvim/skeleton/skeleton.pl
    autocmd BufNewFile *.t    0r ~/.config/nvim/skeleton/skeleton.pl.t
    autocmd BufNewFile *.py   0r ~/.config/nvim/skeleton/skeleton.py
    autocmd BufNewFile *.js   0r ~/.config/nvim/skeleton/skeleton.js
    autocmd BufNewFile *.sh   0r ~/.config/nvim/skeleton/skeleton.sh
augroup END

" directory auto create.
augroup AutoMakeDir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key And Mouse Settings

"if has('mouse')
"  set mouse=a
"endif
if has('ttymouse')
  set ttymouse=xterm2
endif

" Ctrl-pで連続ペースト
nnoremap <silent> <C-p> "0p<CR>
vnoremap <silent> <C-p> "0p<CR>

"""""
" 英字キーボードでも楽なように、map

noremap ; :
noremap : ;


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein


" Environments
let s:xdg_cache = exists($XDG_CACHE_HOME) ? $XDG_CACHE_HOME : '~/.cache'
let s:dein_dir = s:xdg_cache . '/dein'
let s:dein_path = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_path

" Plugins
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Dein & vimproc
  call dein#add(s:dein_path)
  call dein#add('Shougo/vimproc.vim', { 'build' : 'make' })

  " Deoplate
  " Requirement: nvim, python3, neovim-python >= 0.1.8
  call dein#add('Shougo/deoplete.nvim')

  " Denite
  " Requirement: nvim, python3
  call dein#add('Shougo/denite.nvim')

  " neosnippet
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " neoterm
  call dein#add('kassio/neoterm')

  " Color scheme
  "call dein#add('vim-airline/vim-airline')
  "call dein#add('vim-airline/vim-airline-themes')
  "call dein#add('cocopon/iceberg.vim')
  "call dein#add('joshdick/onedark.vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('KeitaNakamura/neodark.vim')

  " LSP plugins
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/asyncomplete-lsp.vim')

  " Language plugins
  call dein#add('sophacles/vim-processing')
  call dein#add('fatih/vim-go')
  call dein#add('posva/vim-vue')
  call dein#add('ryanolsonx/vim-lsp-typescript')
  call dein#add('vim-scripts/Align')
  call dein#add('vim-scripts/SQLUtilities')
  call dein#add('ekalinin/Dockerfile.vim')

  "environment
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('shumphrey/fugitive-gitlab.vim')
  call dein#add('tommcdo/vim-fubitive')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
"if has('vim_starting') && dein#check_install()
if dein#check_install()
  call dein#install()
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Highlight Settings

filetype plugin indent on
syntax on
colorscheme neodark

"" lightline
let g:lightline = {
    \ 'colorscheme': 'neodark' ,
    \}

"" neodark
let g:neodark#terminal_transparent = 1
let g:neodark#use_custom_terminal_theme = 1
let g:neodark#solid_vertsplit = 1

" My custome color highlight settings

" 行末の空白とtabをハイライト
"hi SpecialKey ctermfg=cyan ctermbg=DarkBlue
hi SpecialKey ctermfg=DarkBlue

" 行末の空白をハイライト
augroup HilightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces ctermbg=DarkBlue
  autocmd VimEnter,WinEnter * call matchadd('TrailingSpaces','\s\+$')
augroup END

" 日本語の全角スペースをハイライト
scriptencoding utf-8
augroup highlightMultibyteSpace
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight MultibyteSpace term=underline ctermbg=LightGreen guibg=LightGreen
  autocmd VimEnter,WinEnter * call matchadd('MultibyteSpace', '　')
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal (neovim only)

if has('nvim')

  tnoremap <silent> <ESC> <C-\><C-n>

  " neoterm

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Server
let g:lsp_diagnostics_enabled = 1

" debug
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" Ruby
" Requirement: sudo gem install solargraph
if executable('solargraph')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

" key bind for lsp
nnoremap <silent> <Leader>d :LspDefinition<CR>
nnoremap <silent> <Leader>p :LspHover<CR>
nnoremap <silent> <Leader>r :LspReferences<CR>
nnoremap <silent> <Leader>i :LspImplementation<CR>
nnoremap <silent> <Leader>s :split \| :LspDefinition <CR>
nnoremap <silent> <Leader>v :vsplit \| :LspDefinition <CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utility funcitons

"""""
" GetB
" カーソル上の文字のバイナリコードを表示
"""""
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

" /GetB
"""""
