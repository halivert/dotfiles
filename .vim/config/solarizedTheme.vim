set notgc
set t_Co=256

let g:solarized_termcolors=256
let g:solarized_termtrans=1

nnoremap <silent><leader>tcs :call ToggleBackgroundTransparencySolarized()<cr>

function! ToggleBackgroundTransparencySolarized()
	if background == dark
		set background=light
	else
		set background=dark
	endif
endfunction
