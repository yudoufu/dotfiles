
"""""
" Highlight Settings
"""""
syntax on
"syntax match InvisibleJISX0208Space "　" display containedin=ALL
"hi InvisibleJISX0208Space term=underline ctermbg=LightCyan guibg=Blue
hi Comment ctermfg=Red
hi Function ctermfg=cyan
hi SpecialKey ctermfg=cyan ctermbg=DarkBlue
hi Directory ctermfg=yellow

" カーソル行のハイライト
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
hi CursorLine ctermbg=Black guibg=Black

" .tファイルをPerlのテストスクリプトとして認識
autocmd BufRead *.t set filetype=perl
