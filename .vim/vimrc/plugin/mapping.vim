
"""""
" Key And Mouse Settings
"""""
"if has('mouse')
"  set mouse=a
"endif
set ttymouse=xterm2

" ,e で編集中のファイルタイプを判別して自動的にCLIの実行をしてくれる。
nnoremap ,e :execute '!' &ft ' %'<CR>

" Ctrl-pで連続ペースト
nnoremap <silent> <C-p> "0p<CR>
vnoremap <silent> <C-p> "0p<CR>


"""""
" 英字キーボードでも楽なように、map
"""""
noremap ; :
noremap : ;


