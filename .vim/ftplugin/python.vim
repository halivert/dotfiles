fu! s:activateEmoji(active)
	if (get(g:, 'coc_process_pid', 0))
		if (a:active)
			call CocAction('activeExtension', 'coc-emoji')
		el
			call CocAction('deactivateExtension', 'coc-emoji')
		en
	en
endfu

au User CocNvimInit call s:activateEmoji(0)
au BufEnter <buffer> call s:activateEmoji(0)
au BufHidden <buffer> call s:activateEmoji(1)
