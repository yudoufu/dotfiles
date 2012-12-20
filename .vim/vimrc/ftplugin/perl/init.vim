setlocal iskeyword+=:
noremap K :Perldoc<CR>

" .tファイルをPerlのテストスクリプトとして認識
augroup PerlFileTypeDetect
    autocmd! BufNewFile,BufRead *.t setf perl
    autocmd! BufNewFile,BufRead *.psgi setf perl
    autocmd! BufNewFile,BufRead *.tt setf tt2html
augroup END
