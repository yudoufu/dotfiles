
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"""""
" Initialize Settings
"""""
set nocompatible
set history=999
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set nobackup

"""""
" Status line Settings
"""""
set laststatus=2
set ruler
set title
set showcmd
set showmode
" statuslineの表示設定。GetB()呼び出しも実行
set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ [%{GetB()}]%=%l,%c%V%8P
" コマンドの補完をシェルっぽく
set wildmode=list:longest

"""""
" Behavior Settings
"""""
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
" 親ディレクトリをあさってtagsを探し出し、ctagsを有効にする
if has('autochdir')
  set autochdir
endif
set tags+=tags;
"set tags+=./**/tags "サブディレクトリ以下のctagsも探す

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"""""
" View window Settings
"""""
set list
set listchars=tab:>\ ,trail:\ ,extends:>
"set listchars=tab:\ \ ,trail:\ ,extends:>
set number
set showmatch
set hlsearch
set wrap
set novisualbell

"""""
"Tabs  Settings
"""""
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0

"""""
" filetype Settings
"""""
augroup FileTypeSettings
    autocmd BufRead,BufNewFile Berksfile setfiletype ruby
    autocmd BufRead,BufNewFile Vagrantfile setfiletype ruby
    autocmd BufRead,BufNewFile *.md setfiletype markdown
    autocmd BufRead,BufNewFile *.twig setfiletype htmldjango
    autocmd BufRead,BufNewFile *.twig if &filetype == 'twig' | set filetype=htmldjango | endif
    autocmd BufRead,BufNewFile *.less setfiletype less
    autocmd BufRead,BufNewFile *.go setfiletype go
augroup END

"""""
" 編集時用設定
"""""

" vimgrep時に標準でQuickfixを使う
augroup VimgrepResult
    autocmd!
    autocmd QuickfixCmdPost vimgrep cwin
augroup END

" 検索ハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>

" skeletonファイルを読み込む
augroup SkeletonLoad
    autocmd!
    autocmd BufNewFile *.html 0r ~/.vim/vimrc/skeleton/skeleton.html
    autocmd BufNewFile *.php  0r ~/.vim/vimrc/skeleton/skeleton.php
    autocmd BufNewFile *.pl   0r ~/.vim/vimrc/skeleton/skeleton.pl
    autocmd BufNewFile *.t    0r ~/.vim/vimrc/skeleton/skeleton.pl.t
    autocmd BufNewFile *.py   0r ~/.vim/vimrc/skeleton/skeleton.py
    autocmd BufNewFile *.js   0r ~/.vim/vimrc/skeleton/skeleton.js
    autocmd BufNewFile *.sh   0r ~/.vim/vimrc/skeleton/skeleton.sh
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

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

