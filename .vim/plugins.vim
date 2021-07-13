" |----------|
" | Polyglot |
" |----------|
let g:polyglot_disabled = ['autoindent']

" |---------|
" | Vimwiki |
" |---------|
so $HOME/.vim/wiki_list.vim
let g:vimwiki_table_mappings=0
let g:vimwiki_hl_headers=1
let g:vimwiki_table_auto_fmt=0
let g:vimwiki_global_ext=0
let g:vimwiki_auto_header=1
nn <leader>vhtml :VimwikiAll2HTML!<cr>

filet plugin indent on

cal plug#begin('$HOME/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'editorconfig/editorconfig-vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-commentary'
Plug 'vim-test/vim-test'
Plug 'dhruvasagar/vim-table-mode'
Plug 'nelstrom/vim-visual-star-search'
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'
Plug 'neovim/nvim-lsp'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'

Plug 'mboughaba/i3config.vim'

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Denite
if has('nvim')
	Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
en

" Airline
Plug 'vim-airline/vim-airline'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Snippets
Plug 'honza/vim-snippets'

" Laravel
Plug 'noahfrederick/vim-laravel'

" PHP
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'stephpy/vim-php-cs-fixer'

" Frontend
Plug 'mattn/emmet-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" Jekyll
Plug 'parkr/vim-jekyll'
Plug 'tpope/vim-liquid'

" Themes
Plug 'rafi/awesome-vim-colorschemes'
cal plug#end()

" |----------|
" | Closetag |
" |----------|
let g:closetag_filenames='*.html,*.xhtml,*.phtml,*.php'
let g:closetag_filetypes='html,xhtml,phtml,blade,vue,markdown,liquid'

" |----------|
" | Markdown |
" |----------|
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

" |------------|
" | Table mode |
" |------------|
let g:table_mode_tableize_map='<leader>tz'

" |---------|
" | Laravel |
" |---------|
let g:blade_custom_directives=['tovue', 'default']
let g:blade_custom_directives_pairs={
			\		'cache': 'endcache',
			\		'canany': 'endcanany',
			\		'switch': 'endswitch',
			\		'error': 'enderror',
			\		'empty': 'endempty',
			\		'canif': 'endcanif',
			\ }

" |-------|
" | Latex |
" |-------|
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
se conceallevel=1
let g:tex_conceal='abdmg'

" |---------|
" | Airline |
" |---------|
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#tab_nr_type=1 " tab number
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#whitespace#mixed_indent_algo=2

" |-----------|
" | Signify |
" |-----------|
se signcolumn=yes

" |--------|
" | Denite |
" |--------|
if has('nvim')
	cal denite#custom#var('file/rec', 'command', [
				\		'rg', '--files', '--hidden'
				\ ])

	autocmd FileType denite cal s:denite_my_settings()
	fu! s:denite_my_settings() abort
		nn <silent><buffer><expr> <cr> denite#do_map('do_action')
		nn <silent><buffer><expr> d denite#do_map('do_action', 'delete')
		nn <silent><buffer><expr> p denite#do_map('do_action', 'preview')
		nn <silent><buffer><expr> q denite#do_map('quit')
		nn <silent><buffer><expr> <esc> denite#do_map('quit')
		nn <silent><buffer><expr> i denite#do_map('open_filter_buffer')
		nn <silent><buffer><expr> t denite#do_map('do_action', 'tabopen')
		nn <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
		nn <silent><buffer><expr> <space> denite#do_map('toggle_select')
	endf

	cal denite#custom#var('grep', 'com', ['ag'])
	cal denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
	cal denite#custom#var('grep', 'recursive_opts', [])
	cal denite#custom#var('grep', 'pattern_opt', [])
	cal denite#custom#var('grep', 'separator', ['--'])
	cal denite#custom#var('grep', 'final_opts', [])

	autocmd FileType denite-filter cal s:denite_filter_my_settings()
	fu! s:denite_filter_my_settings() abort
		im <silent><buffer> <tab> <plug>(denite_filter_update)
		ino <silent><buffer><expr> <cr> denite#do_map('do_action')
		ino <silent><buffer><expr> <c-t> denite#do_map('do_action', 'tabopen')
		ino <silent><buffer><expr> <c-v> denite#do_map('do_action', 'vsplit')
		ino <silent><buffer><expr> <c-x> denite#do_map('do_action', 'split')
		ino <silent><buffer><expr> <esc> denite#do_map('quit')
		ino <silent><buffer> <c-j> <esc><c-w>p:cal cursor(line('.')+1,0)<cr><c-w>pA
		ino <silent><buffer> <c-k> <esc><c-w>p:cal cursor(line('.')-1,0)<cr><c-w>pA
	endf

	let s:denite_options={
				\		'auto_resize': 1,
				\ 	'prompt': 'λ ',
				\ 	'start_filter': 1,
				\ 	'source_names': 'short',
				\ 	'winheight': 10,
				\ 	'winwidth': 69,
				\ 	'split': 'floating',
				\ 	'wincol': 7,
				\ 	'winrow': 3,
				\ 	'direction': 'topleft',
				\ 	'highlight_filter_background': 'CursorLine',
				\ 	'highlight_window_background': 'Type',
				\ }

	cal denite#custom#option('default', s:denite_options)

	nn <silent> <space><space> :Denite buffer file/rec<cr>
endif

" |-----|
" | Vue |
" |-----|
let g:vue_disable_pre_processors=1

" |--------|
" | Jekyll |
" |--------|
let g:jekyll_post_extension='.md'
let g:jekyll_post_filetype='markdown'
let g:jekyll_post_template=[
			\		'---',
			\ 	'author: halivert',
			\ 	'title: "JEKYLL_TITLE"',
			\ 	'date: "JEKYLL_DATE"',
			\ 	'category: ""',
			\ 	'tags: []',
			\ 	'---',
			\ 	''
			\ ]

" |-------|
" | Emoji |
" |-------|
se completefunc=emoji#complete
" nn <leader>emo :%s/:\(\w\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
" 			\ let @/=""<cr>

" |-----|
" | Php |
" |-----|
no <leader>u :PhpactorImportClass<cr>
no <leader>mm :PhpactorContextMenu<cr>
no <leader>nn :PhpactorNavigate<cr>
no <leader>o :PhpactorGotoDefinition<cr>
no <leader>K :PhpactorHover<cr>
no <leader>tt :PhpactorTransform<cr>
no <leader>cc :PhpactorClassNew<cr>
no <silent><leader>ee :PhpactorExtractExpression(v:false)<cr>
vn <silent><leader>ee :PhpactorExtractExpression(v:true)<cr>
vn <silent><leader>em :PhpactorExtractMethod<cr>

" |-----|
" | C++ |
" |-----|
" let g:clang_format#style_options={
" 			\		'AllowShortIfStatementsOnASingleLine' : 'true',
" 			\ 	'Standard' : 'C++11'
" 			\ }

" |-------|
" | Theme |
" |-------|
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'

" |-------|
" | 2html |
" |-------|
let g:html_font=['Iosevka', 'IBM Plex Mono']
let g:html_use_css=1
let g:html_prevent_copy='n'

" |-------|
" | Tests |
" |-------|
nn <silent> t<c-n> :TestNearest<cr>
nn <silent> t<c-f> :TestFile<cr>
nn <silent> t<c-s> :TestSuite<cr>
nn <silent> t<c-t> :TestLast<cr>
nn <silent> t<c-g> :TestVisit<cr>

" |-----------|
" | Ultisnips |
" |-----------|
let g:UltiSnipsSnippetDirectories=[
			\		'$HOME/.vim/snippets-used'
			\	]

" |-----|
" | Coc |
" |-----|
ino <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
ino <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

ino <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<cr>"
ino <silent><expr> <C-j> pumvisible() ? coc#_select_confirm() : "\<cr>"

let g:coc_snippet_next='<tab>'
let g:coc_snippet_prev='<s-tab>'

nm <silent> gd <plug>(coc-definition)
nm <silent> gy <plug>(coc-type-definition)
nm <silent> gi <plug>(coc-implementation)
nm <silent> gr <plug>(coc-references)
nm <silent> <leader>gf <plug>(coc-fix-current)
com! -nargs=0 Format :cal CocAction('format')
nn <leader>es :CocCommand snippets.editSnippets<cr>
nn <leader>f :cal CocAction('format')<cr>
ino <silent><expr> <c-space> coc#refresh()

let g:coc_sources_disable_map = {
			\		'python': ['tag']
			\ }

" |------|
" | Test |
" |------|
" let test#strategy = 'dispatch'
if !exists('g:dispatch_compilers')
	let g:dispatch_compilers = {}
endif

" let g:dispatch_compilers['phpunit'] = 'sail test'
let test#php#options = '--without-tty'
let g:test#preserve_screen = 1

" |--------------|
" | editorconfig |
" |--------------|
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

colo gruvbox

" |----------|
" | Prettier |
" |----------|
nn <silent> <leader><c-f> :Prettier<cr>

" |------|
" | Goyo |
" |------|
fu! s:goyo_enter()
	se so=999
	se nosmd
endf

fu! s:goyo_leave()
	se so=3
	se smd
endf

let g:goyo_width=84
nn <silent> <leader>go :Goyo<cr>
au! User GoyoEnter nested cal <SID>goyo_enter()
au! User GoyoLeave nested cal <SID>goyo_leave()
