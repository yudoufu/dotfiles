"""""
" Highlight Settings
"""""
syntax on

" colorschemeの指定
"colorscheme desert
"colorscheme hybrid
colorscheme railscasts

" 行末の空白とtabをハイライト
hi SpecialKey ctermfg=cyan ctermbg=DarkBlue

" 日本語の全角スペースをハイライト
scriptencoding utf-8
augroup highlightMultibyteSpace
    autocmd!
    autocmd BufEnter * highlight MultibyteSpace term=underline ctermbg=LightGreen guibg=LingtGreen
    autocmd VimEnter,WinEnter * match MultibyteSpace /　/
augroup END

" カーソル行のハイライト
"set cursorline
"augroup cch
"  autocmd!
"  autocmd WinLeave * set nocursorline
"  autocmd WinEnter,BufRead * set cursorline
"augroup END
"
"hi clear CursorLine
"hi CursorLine gui=underline
"hi CursorLine ctermbg=Black guibg=Black

