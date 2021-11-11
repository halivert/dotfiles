syntax enable

se nocompatible
se path+=**
se wildmenu
se showcmd
se relativenumber
se number
let mapleader="\<space>"
se splitbelow
se splitright
se autoindent
se noexpandtab
se tabstop=2
se shiftwidth=2
se softtabstop=2
se scrolloff=3
se regexpengine=0
se ruler
se nowrap
se hlsearch
se diffopt=vertical,algorithm:minimal
se termguicolors
se timeoutlen=500
se title
se shortmess+=c
se nowritebackup
se pyxversion=3
se hidden
se undofile
se inccommand=split
se undodir=$HOME/.vim/undodir
se spl=es_mx

" Save position and folds on exit, and load them on enter
se viewoptions=folds,cursor
aug AutoSaveFolds
	au!
	au BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview
	au BufWinEnter ?* silent! loadview
aug end

" Draw line on 81 column, for readability
se textwidth=80
if (exists('+colorcolumn'))
	se colorcolumn=+1,+3
end

nn Q <nop>
" Remove last search - clear highlight
nn \\ :let @/ = ""<cr>
nn <leader># :so $MYVIMRC<cr>
nn <C-S> :up<cr>
nn <C-_> :Bclose<cr>
nn <leader>q :bd<cr>
nn <leader>e :Vex<cr>
nn <C-Tab> :bn<cr>
nn <C-S-Tab> :bp<cr>
" Remove blank spaces at end of lines
nn <leader>s :%s/\s\+$//e<cr>
nn <leader>ev :e $HOME/.vimrc<cr>
nn <leader>ep :e $HOME/.vim/plugins.vim<cr>

nm <leader>y "+y
nm <leader>p "+p

vn <leader>y "+y
vn <leader>p "+p
vn J :m '>+1<cr>gv=gv
vn K :m '<-2<cr>gv=gv

ino `<< «
ino `>> »
ino <C-c> <esc>

au BufRead,BufNewFile *.blade.php se filetype=blade
au BufRead,BufNewFile *.vifm se filetype=vim

" Highlight yanked area
aug LuaHighlight
	au!
	au TextYankPost * silent! lua require'vim.highlight'.on_yank()
aug END

" Use with anne pro 2 dvorak layout (es layout)
" no ñ :

" Use with anne pro 2 dvorak layout (us layout)
no ; :
no : ;

so $HOME/.vim/plugins.vim
so $HOME/.vim/functions.vim " Has initial background function

nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
tnoremap <Esc> <C-\><C-n>

cal InitialBackground("10:00", "19:00")
