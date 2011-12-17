 setlocal iskeyword+=:
 noremap K :Perldoc<CR>

" .tファイルをPerlのテストスクリプトとして認識
autocmd BufRead *.t set filetype=perl
