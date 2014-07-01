set shiftwidth=4
set tabstop=4
set noexpandtab

" :Fmt などで gofmt の代わりに goimports を使う
let g:gofmt_command = 'goimports'

" Go に付属の plugin と gocode を有効にする
set rtp+=$GOROOT/misc/vim
set rtp+=$GOPATH/src/github.com/nsf/gocode/vim

" 保存時に :Fmt する
"autocmd BufWritePre *.go Fmt
autocmd FileType go :compiler go

