setl cfu=emoji#complete
setl et
setl wrap
setl tw=80

nn <buffer> <silent><leader>f :Prettier<cr>
nn <buffer> <leader>c :!pandoc --wrap=preserve -s -o %:r.pdf %<cr>
