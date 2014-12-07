set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

augroup ghcmodcheck
    autocmd! BufWritePost <buffer> GhcModCheckAsync
augroup END

