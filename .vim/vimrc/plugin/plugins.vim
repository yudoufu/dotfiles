" neocomplcache
let g:neocomplcache_enable_at_startup = 1


""""""""""
"" unite.vim
""""""""""
" 入力モードで開始
let g:unite_enable_start_insert = 1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" 横に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" 縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキー２回で終了
au FileType unite nnoremap <silent> <buffer> <Esc><Esc> q
au FileType unite inoremap <silent> <buffer> <Esc><Esc> <Esc>q


"""""""
"" vimshell
"""""""
" ,is: シェルを起動
nnoremap <silent> ,is :VimShell<CR>
" ,ig: goshを非同期で起動
nnoremap <silent> ,ig :VimShellInteractive gosh<CR>
" ,ss: 非同期で開いたインタプリタに現在の行を評価させる
vnoremap <silent> ,ss :VimShellSendString<CR>
" 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>

