" Jeff's vim configuration

set nocompatible             " This must be first, because it changes other options as a side effect

" Specify a directory for plugins
" Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
Plug 'fholgado/minibufexpl.vim'
Plug 'jnurmine/Zenburn'
Plug 'maciakl/vim-neatstatus',
Plug 'tpope/vim-sensible'
 Plug 'tpope/vim-unimpaired'
 Plug 'tpope/vim-fugitive'
" Plug 'godlygeek/tabular'
" Plug 'Valloric/YouCompleteMe'
" Plug 'wincent/command-t'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'python/black'
Plug 'stephpy/vim-yaml'
Plug 'cespare/vim-toml'
Plug 'leafOfTree/vim-vue-plugin'

" Initialize plugin system
call plug#end()

syntax on                    " Turns on syntax highlighting

" Enable :Man command without having loaded a manpage into vim
"  see :help Man for details
runtime ftplugin/man.vim

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

" http://nvie.com/posts/how-i-boosted-my-vim/
" One particularly useful setting is hidden. Its name isn’t too descriptive,
" though. It hides buffers instead of closing them. This means that you can
" have unwritten changes to a file and open a new file using :e, without being
" forced to write or undo your changes first. Also, undo buffers and marks are
" preserved while the buffer is open.
set hidden

" Show (partial) command in status line
"    Example visual mode selection shows the size of the block
set showcmd

let mapleader=","            " Defines mapleader for use in <LEADER> binding, default if not defined is \

set hlsearch                 " Highlight search terms
nnoremap <silent> <LEADER>/ :nohlsearch<CR> " Clears search buffer when you press ,/
set incsearch                " Turns on search highlighting
"set ignorecase              " Searches ignore case by default
"set smartcase               " Searches smartly about case sensitivity, ex: all lowercase search->uses case insensitive search, any uppercase search->uses case sensitive search

" Change regex to perl compatable
nnoremap / /\v
vnoremap / /\v

set wildmenu                 " Show autocomplete menus
set wildignore+=.o,SCCS,.git " Determines which files should be excluded from listings
set showmatch                " Show matching brackets
"set mouse=a                  " Mouse enables and works with visual mode
colorscheme zenburn         " Set the colorscheme to zenburn
" Line endings should be Unix-style unless the file is from someone else.
set fileformat=unix
au BufNewFile * set fileformat=unix

set number                   " Show numbers on the left of each line
set autoindent               " Always set autoindenting on
set copyindent               " Copy previous indent on enter
set smartindent              "

" toggle paste mode (to paste properly indented text)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set ruler                    " Enables line, col and pct doc information
set history=1000             " remember more commands and search history
set title                    " change the terminal's title
set visualbell               " don't beep
set t_vb=                    " turn off screen flashing
set noerrorbells             " don't beep
set laststatus=2             " always show the status line
set backup                   " Turns backup on
set dir=$EDITOR_BACKUP       " Set dir for swap file storage
set backupdir=$EDITOR_BACKUP " Set dir for backup file storage

" Give backups a timestamp
fun! UpdateTimeStamp()
    let mytstamp=strftime("%y%m%d_%Hh%M")
    let mytstamp="set backupext=_" . mytstamp
    execute mytstamp
endfun
autocmd BufWritePre,FileWritePre,FileAppendPre * call UpdateTimeStamp()

" Removes trailing spaces
fun! TrimWhiteSpace()
    %s/\s*$//
endfun
map <F4> :call TrimWhiteSpace()<CR><C-o>  " binds call to F4 and returns to previous location after running

set nowrap                   " Disable line wrapping
set cursorline               " Highlight current line
"set cursorcolumn             " Highlights current column
set scrolloff=999            " Minimal number of screen lines to keep above and below the cursor, this keeps the cursor always in the vertical middle of the screen
set encoding=utf-8           " Use UTF-8
set autoread                 " Automatically read files which have been changed outside of Vim, if we haven't changed it already.

" To save, ctrl-s.
"nnoremap <c-s> :w<CR>
"inoremap <c-s> <Esc>:w<CR>a

" Disable spellcheck by default
set nospell
autocmd BufRead,BufNewFile * setlocal nospell
" To enable again, use:
" setlocal spell spelllang=en_us
" Allow backspace to go over indents, end of lines, and the start of the insert mode session
set backspace=indent,eol,start
" Save all on losing focus
" au FocusLost * :wa
" ctags
nnoremap <F12> :!ctags -R<CR>             " run ctags on directory
" ctrl + arrow key to navigate windows
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l

" mini buffer explorer plugin
" http://www.vim.org/scripts/script.php?script_id=159
" https://github.com/fholgado/minibufexpl.vim
" If you like <C-TAB> and <C-S-TAB> to switch buffers in the current window then perform the remapping
noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>
" or if you like <C-TAB> and <C-S-TAB> to switch windows then perform the remapping
" noremap <C-TAB>   <C-W>w
" noremap <C-S-TAB> <C-W>W

" command-T plugin settings
" let g:CommandTCancelMap=['<esc>', '<C-c>']  " esc can also cancel the listing, along with the default C-c
" let g:CommandTMaxCachedDirectories=0        " Will cache an unlimited number of directories, default value is 1 (0 is a performance for memory trade)

" NERD_commentor
let NERDSpaceDelims=1        " Add and remove spaces around delimiters when commenting and uncommenting
let NERDAlignCommentToggle=1 " Aligns comments for indented lines

" Generic folding options
"set foldmethod=syntax        " Enables syntax based code folding
"set foldlevelstart=99        " Open files with all folds open

" Incrementing selected numbers in a column
"   Usage: column select block of numbers to update, press leader-i
"   Comments: increments each number by its line offset from the
"             first line in the visual selection block
"   http://vim.wikia.com/wiki/Making_a_list_of_numbers
"     http://vim.wikia.com/wiki/Using_marks
"     http://vim.wikia.com/wiki/Increasing_or_decreasing_numbers
function! Incr()
	let a = line(".") - line("'<")
	let c = virtcol("'<")
	if a > 0
		execute 'normal! '.c.'|'.a."\<C-a>"
	endif
	normal `<
endfunction
vnoremap <LEADER>i :call Incr()<CR>

" Bind upper and lower case selection to ctrl-u and ctrl-l respectively
vnoremap <special> <LEADER>U gU
vnoremap <special> <LEADER>u gu

" Fast window resizing with +/- keys (horizontal); / and * keys (vertical)
" Must toggle off numlock for this
nnoremap <kPlus> <c-w>+
nnoremap <kMinus> <c-w>-
nnoremap <kDivide> <c-w><
nnoremap <kMultiply> <c-w>>

" Persistent undo
set undofile                    " Save undo's after file closes
set undodir=~/.vim/undo         " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo

" Highlight column 100 (soft right margin)
set colorcolumn=100
highlight ColorColumn ctermbg=238 guibg=#444444

" Tabularize csv
nnoremap <LEADER><c-t> :Tabularize/,<CR>

" Setup tabs for matlab
autocmd FileType matlab setlocal expandtab shiftwidth=4 softtabstop=4
" Setup tabs for python
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
" Setup tabs for vue
autocmd FileType vue setlocal expandtab

" Trim trailing whitespace on write
" autocmd BufWritePre python, perl :%s/\s\+$//e
" autocmd BufWritePre * :%s/\s\+$//e
