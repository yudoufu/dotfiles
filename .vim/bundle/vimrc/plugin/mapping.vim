
"""""
" Key And Mouse Settings
"""""
"if has('mouse')
"  set mouse=a
"endif
set ttymouse=xterm2

" yanktmp.vim setting
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>


" ,e で編集中のファイルタイプを判別して自動的にCLIの実行をしてくれる。
nnoremap ,e :execute '!' &ft ' %'<CR>

"""""
" 英字キーボードでも楽なように、map
"""""
noremap ; :
noremap : ;


