" 対応するカッコ内の式をvimshellに送る
nnoremap <buffer> ,z "zya(:exe<space>"VimShellSendString ".getreg("z")<CR>
