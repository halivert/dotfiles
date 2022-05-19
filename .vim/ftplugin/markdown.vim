se cfu=emoji#complete
se et

nn <buffer> <silent><leader>f :CocCommand prettier.formatFile<cr>
nn <buffer> <leader>c :!pandoc --wrap=preserve -s -o %:r.pdf %<cr>
