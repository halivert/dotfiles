set nocompatible

if exists('py2') && has('python')
elseif has('python3')
en

set showcmd
set relativenumber
set number
syntax enable

let mapleader="\<space>"
set splitbelow
set splitright

set path=**
set autoindent
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set scrolloff=3
set regexpengine=0

set ruler
set nowrap
set wildmenu
set hlsearch
set diffopt=vertical
set termguicolors
set timeoutlen=500

set shortmess+=c
set nobackup
set nowritebackup
set pyxversion=3
set hidden

nn Q <nop>
nn \\ :let @/ = ""<cr>
nm <leader>y "+y
nm <leader>p "+p
vn <leader>y "+y
vn <leader>p "+p

vn J :m '>+1<cr>gv=gv
vn K :m '<-2<cr>gv=gv

nn <leader># :so $MYVIMRC<cr>

set viewoptions=folds,cursor
augroup AutoSaveFolds
	autocmd!
	autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview
	autocmd BufWinEnter ?* silent! loadview
augroup end

ino `<< «
ino `>> »

set textwidth=80
if (exists('+colorcolumn'))
	set colorcolumn=81
	highlight ColorColumn guibg=#5f8700 ctermbg=8
en

set lazyredraw
set inccommand=split
set foldmethod=indent

set updatetime=200
nn <C-S> :up<cr>
nn <C-_> :Bclose<cr>
nn <leader>q :bd<cr>
nn <leader>e :Vex<cr>

nn <C-Tab> :bn<cr>
nn <C-S-Tab> :bp<cr>

set undofile

" Use with anne pro 2 dvorak layout (es layout)
" no ñ :

" Use with anne pro 2 dvorak layout (us layout)
no ; :
no : ;

nn <leader>s :%s/\s\+$//e<cr>

set undodir=$HOME/.vim/undodir
if exists("configPath")
	execute "nn <leader>ev :e " . configPath . "/.vimrc"
	execute "nn <leader>ep :e " . configPath . "/plugins.vim"
en

autocmd BufRead,BufNewFile *.blade.php set filetype=blade
autocmd BufRead,BufNewFile *.vifm set filetype=vim
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt
			\ silent %!pandoc "%" -tplain -o /dev/stdout

augroup LuaHighlight
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_winsize=25

fu! InitialBackground()
	let l:st = split("10:00", ":")
	let l:end = split("19:00", ":")
	let l:now = split(strftime("%H:%M"), ":")

	let l:stNow = ((l:now[0] * 60 + l:now[1]) - (l:st[0] * 60 + l:st[1]))
	let l:nowEnd = ((l:now[0] * 60 + l:now[1]) - (l:end[0] * 60 + l:end[1]))

	if (l:stNow > 0 && l:nowEnd < 0)
		set background=light
	el
		set background=dark
	en
endf

call InitialBackground()
