set shiftwidth=4
set tabstop=4
set noexpandtab

"" vim-go settings
let g:go_play_open_browser = 0
let g:go_fmt_command = "gofmt"
let g:go_fmt_fail_silently = 1
let g:go_snippet_engine = "neosnippet"

"" vim-go keymap
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)

autocmd FileType go nmap <Leader>r <Plug>(go-run)
autocmd FileType go nmap <Leader>b <Plug>(go-build)
autocmd FileType go nmap <Leader>t <Plug>(go-test)

autocmd FileType go nmap <Leader>gd <Plug>(go-def)

autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)

