"""""
" Highlight Settings
"""""
syntax on

" 日本語の全角スペースをハイライトする(colorschemeの前に設定)
scriptencoding utf-8
augroup highlightMultibyteSpace
    autocmd!
    autocmd ColorScheme * highlight MultibyteSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match MultibyteSpace /　/
augroup END

" colorschemeの指定
colorscheme desert

" 行末の空白とtabをハイライト
hi SpecialKey ctermfg=cyan ctermbg=DarkBlue


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

