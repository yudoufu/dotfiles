
" yankringの割り当て変更
if has("viminfo")
	" yankrignによるviminfoの編集の問題らしい。こうしておかないと、yankringにおこられる。
	set vi^=!
endif
nmap ,y :YRShow<CR>


