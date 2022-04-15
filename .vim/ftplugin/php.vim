setl expandtab
setl shiftwidth=4
setl tabstop=4
setl softtabstop=4
setl commentstring=//\ %s

nn <buffer> <A-F> :cal CocActionAsync('format')<cr>

" let @x="\n\n	/* |----------------| */\n	/* | Business logic | */\n	/* |----------------| */"
