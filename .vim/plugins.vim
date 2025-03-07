filet plugin indent on

cal plug#begin('$HOME/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'editorconfig/editorconfig-vim'
Plug 'alvan/vim-closetag'
Plug 'tomtom/tcomment_vim'
Plug 'vim-test/vim-test'
Plug 'dhruvasagar/vim-table-mode'
Plug 'bronson/vim-visual-star-search'
Plug 'sheerun/vim-polyglot'
Plug 'mboughaba/i3config.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'wuelnerdotexe/vim-astro'
Plug 'martineausimon/nvim-lilypond-suite'
" Plug 'rajasegar/vim-astro'

if has('nvim')
	Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/mason.nvim'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'jose-elias-alvarez/null-ls.nvim'
	Plug 'mfussenegger/nvim-jdtls'
	Plug 'MunifTanjim/prettier.nvim'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'rafamadriz/friendly-snippets'
else
	Plug 'Shougo/denite.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Airline
Plug 'vim-airline/vim-airline'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'

" Snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" Frontend
Plug 'mattn/emmet-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" Jekyll
Plug 'parkr/vim-jekyll'
Plug 'tpope/vim-liquid'

" Latex
Plug 'lervag/vimtex'

" Themes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'artanikin/vim-synthwave84'

Plug 'brenoprata10/nvim-highlight-colors'

" PHP
" Plug 'phpactor/phpactor', { 'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o' }
cal plug#end()


" |----------|
" | Closetag |
" |----------|
let g:closetag_filenames = '*.html,*.php,*.jsx'
let g:closetag_filetypes = 'html,blade,vue,markdown,liquid,astro'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'


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
" | Airline |
" |---------|
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#tab_nr_type=1 " tab number
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#whitespace#mixed_indent_algo=2


" |---------|
" | Signify |
" |---------|
se signcolumn=yes


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


" |-----|
" | C++ |
" |-----|
let g:clang_format#style_options={
			\		'AllowShortIfStatementsOnASingleLine' : 'true',
			\ 	'Standard' : 'C++11'
			\ }


" |-------|
" | Theme |
" |-------|
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'


" |-------|
" | Tests |
" |-------|
nn <silent> t<c-n> :TestNearest<cr>
nn <silent> t<c-f> :TestFile<cr>
nn <silent> t<c-s> :TestSuite<cr>
nn <silent> t<c-t> :TestLast<cr>
nn <silent> t<c-g> :TestVisit<cr>


" |------|
" | Test |
" |------|
if !exists('g:dispatch_compilers')
	let g:dispatch_compilers = {}
endif

let test#php#options = '--without-tty'
let g:test#preserve_screen = 1


" |--------------|
" | editorconfig |
" |--------------|
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" |-------|
" | Latex |
" |-------|
let g:vimtex_view_method = 'zathura'


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

	cal denite#custom#var('grep', 'com', ['rg'])
	cal denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
	cal denite#custom#var('grep', 'recursive_opts', [])
	cal denite#custom#var('grep', 'pattern_opt', [])
	cal denite#custom#var('grep', 'separator', ['--'])
	cal denite#custom#var('grep', 'final_opts', [])

	autocmd FileType denite-filter cal s:denite_filter_my_settings()
	fu! s:denite_filter_my_settings() abort
		lua require('cmp').setup.buffer { enabled = false }
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

let g:astro_typescript = 'enable'

colo gruvbox
