" source ~/.vim/ftplugin/php/php-doc.vim

" comment settings
let g:pdv_cfg_Author = "Daichi Kamemoto(a.k.a: yudoufu) <daikame@gmail.com>"
let g:pdv_cfg_Copyright = "2010 yudoufu"
let g:pdv_cfg_License = "MIT License"
let g:pdv_cfg_php4always = 0
let g:pdv_cfg_php4guess = 0

" key settings
"inoremap <C-I> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-I> :call PhpDocSingle()<CR>
vnoremap <C-I> :call PhpDocRange()<CR> 
