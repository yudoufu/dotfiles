
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
set listchars=tab:\ \ ,trail:\ ,extends:>
set number
set showmatch
set hlsearch
set wrap
set novisualbell

"""""
"Tabs  Settings
"""""
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0

"""""
" 編集時用設定
"""""
set helpfile=$VIMRUNTIME/doc/help.txt
"set complete=+k 不正な文字といわれるのでコメントアウト。
if has("autocmd")

  " バッファの。。。なんかよくわからんけど追加。あとで。
  autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
endif

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
    autocmd BufNewFile *.py   0r ~/.vim/vimrc/skeleton/skeleton.py
augroup END


"""""
" Japanese Settins by ずんWiki
"
" 文字コードの自動認識
"""""
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
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




