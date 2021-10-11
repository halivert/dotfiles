augroup vimrc_auto_mkdir
	autocmd!
	autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
	function! s:auto_mkdir(dir, force)
		if !isdirectory(a:dir)
					\   && (a:force
					\       || input("'" . a:dir . "' does not exist. Create? [y/N] ")
					\   =~? '^y\%[es]$')
			call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
		endif
	endfunction
augroup END

augroup vimrc_initial_background
	function! InitialBackground(initial, final)
		let l:st = split(a:initial, ":")
		let l:end = split(a:final, ":")
		let l:now = split(strftime("%H:%M"), ":")

		let l:stNow = ((l:now[0] * 60 + l:now[1]) - (l:st[0] * 60 + l:st[1]))
		let l:nowEnd = ((l:now[0] * 60 + l:now[1]) - (l:end[0] * 60 + l:end[1]))

		if (l:stNow > 0 && l:nowEnd < 0)
			set background=light
		else
			set background=dark
		end
	endfunction
augroup END
