" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion  =  1

" 改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

" tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

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

"""""""
"" quickrun
"""""""

let g:quickrun_config = {}
let g:quickrun_config['php.unit']    = {'command': 'testrunner', 'cmdopt': 'phpunit'}
let g:quickrun_config['python.unit'] = {'command': 'nosetests', 'cmdopt': '-v -s'}
" let g:quickrun_config['python.pytest'] = {'command': 'py.test', 'cmdopt': '-v'}
let g:quickrun_config['ruby.rspec']  = {'command': 'rspec', 'cmdopt': '-f d'}

nnoremap <silent> <SPACE>r :QuickRun -mode n -runner vimproc:updatetime=5<CR>
vnoremap <silent> <SPACE>r :QuickRun -mode v -runner vimproc:updatetime=5<CR>
nnoremap <silent> ,r :QuickRun -mode n -runner vimproc:updatetime=5 -hook/unittest/enable 1<CR>

augroup QuickRunUnitTest
  autocmd!
  autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
  " Choose UnitTest or py.test.
  "autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
  "autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
  autocmd BufWinEnter,BufNewFile *.py setlocal filetype=python.unit
  autocmd BufWinEnter,BufNewFile *.t setlocal filetype=perl.unit
  autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
augroup END


"""""""
"" vim-latex
"""""""

"augroup VimLatex
"autocmd!
"autocmd BufWinEnter,BufNewFile *.tex,*.latex,*.sty,*.dtx,*.ltx,*.bbl setlocal filetype=tex
"augroup END

let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'open -a Preview.app'
"let g:Tex_CompileRule_pdf = 'pdflatex $*.tex'
let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'

