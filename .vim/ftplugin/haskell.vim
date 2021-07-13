se expandtab
let mapleader="-"
let g:mapleader="-"
se tm=2000
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hh :GhcModTypeClear<CR>
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
let g:syntastic_mode_map={ 'mode': 'active', 'passive_filetypes': ['haskell'] }
let g:syntastic_always_populate_loc_list = 1
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>

" Auto-checking on writing
" autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync

" neocomplcache (advanced completion)
" autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
" function! SetToCabalBuild()
  " if glob("*.cabal") != ''
    " se makeprg=cabal\ build
  " endif
" endfunction
" autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

" neco-ghc
" let $PATH=$PATH.':'.expand("~/.cabal/bin")
