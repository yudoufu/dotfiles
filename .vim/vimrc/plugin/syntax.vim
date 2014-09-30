"""""
" Highlight Settings
"""""
syntax on

" colorschemeの指定
"colorscheme desert
"colorscheme hybrid
colorscheme railscasts

" 行末の空白とtabをハイライト
"hi SpecialKey ctermfg=cyan ctermbg=DarkBlue
hi SpecialKey ctermfg=DarkBlue

"ctermfg=cyan 行末の空白をハイライト
augroup HilightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces ctermbg=DarkBlue
  autocmd VimEnter,WinEnter * call matchadd('TrailingSpaces','\s\+$')
augroup END

" 日本語の全角スペースをハイライト
scriptencoding utf-8
augroup highlightMultibyteSpace
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight MultibyteSpace term=underline ctermbg=LightGreen guibg=LightGreen
  autocmd VimEnter,WinEnter * call matchadd('MultibyteSpace', '　')
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

