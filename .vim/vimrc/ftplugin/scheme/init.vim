" 対応するカッコ内の式をvimshellに送る
nnoremap <buffer> <Space>z "zya(:exe<space>"VimShellSendString ".getreg("z")<CR>
