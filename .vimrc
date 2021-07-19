se nocompatible

if exists('py2') && has('python')
elsei has('python3')
en

se showcmd
se relativenumber
se number
syntax enable

let mapleader="\<space>"
se splitbelow
se splitright

se path=**
se autoindent
se noexpandtab
se tabstop=2
se shiftwidth=2
se softtabstop=2
se scrolloff=3
se regexpengine=0

se ruler
se nowrap
se wildmenu
se hlsearch
se diffopt=vertical
se termguicolors
se timeoutlen=500

se shortmess+=c
se nobackup
se nowritebackup
se pyxversion=3
se hidden

nn Q <nop>
nn \\ :let @/ = ""<cr>
nm <leader>y "+y
nm <leader>p "+p
vn <leader>y "+y
vn <leader>p "+p

vn J :m '>+1<cr>gv=gv
vn K :m '<-2<cr>gv=gv

nn <leader># :so $MYVIMRC<cr>

se viewoptions=folds,cursor
augroup AutoSaveFolds
	autocmd!
	autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview
	autocmd BufWinEnter ?* silent! loadview
augroup end

ino `<< «
ino `>> »

se textwidth=80
if (exists('+colorcolumn'))
	se colorcolumn=81
	highlight ColorColumn guibg=#5f8700 ctermbg=8
en

se lazyredraw
se inccommand=split
se foldmethod=indent

se updatetime=200
nn <C-S> :up<cr>
nn <C-_> :Bclose<cr>
nn <leader>q :bd<cr>
nn <leader>e :Vex<cr>

nn <C-Tab> :bn<cr>
nn <C-S-Tab> :bp<cr>

se undofile

" Use with anne pro 2 dvorak layout (es layout)
" no ñ :

" Use with anne pro 2 dvorak layout (us layout)
no ; :
no : ;

nn <leader>s :%s/\s\+$//e<cr>

se undodir=$HOME/.vim/undodir
nn <leader>ev :e $HOME/.vimrc<cr>
nn <leader>ep :e $HOME/.vim/plugins.vim<cr>

autocmd BufRead,BufNewFile *.blade.php se filetype=blade
autocmd BufRead,BufNewFile *.vifm se filetype=vim
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
		se background=light
	el
		se background=dark
	en
endf

call InitialBackground()

so $HOME/.vim/plugins.vim
so $HOME/.vim/functions.vim
