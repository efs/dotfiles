" ===============================================
"
" .vimrc
"
"
" ================================================

filetype on
filetype plugin on
filetype indent on
syntax on
set background=dark
colorscheme solarized

" Automatically update files when externally modified
set autoread

" Automatically break lines after 72 characters when writing
au BufRead /tmp/mutt-* set tw=72
" Otherwise break 78 characters
set tw=78
"set colorcolumn=+1
"hi ColorColumn ctermbg=darkgray

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc

" Writing to a file as su.
cmap w!! %!sudo tee > /dev/null %

set nocompatible
set number
set showcmd
set incsearch
set wildignore=*.o,*.obj,*.bak,*.exe

set wildmode=longest,list

" Disable the arrow keys:
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

" Disable backup et. al.
set nobackup
set nowb
set noswapfile

"Persistent undo
set undofile

set spell

"Pathogen
call pathogen#infect()
call pathogen#helptags()

"========================================
" Appereance
"========================================

set enc=utf-8
set fillchars=vert:\ 

" Highlight trailing whitespace
hi ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/

"========================================
" Keybindings
"========================================


" Remove trailing whitespace
map <Leader>w :%s/\s\+$<CR>

map <F2> :NERDTreeToggle<CR>
map <F3> :TlistToggle<CR>

" Save and make
map <F7> :w<CR>:make <CR>

map <F9> :cprev<CR>
map <F10> :cnext<CR>
map <F11> :clist<CR>

"========================================
" Tabs and indention
"========================================

set tabstop=4
set shiftwidth=4
set expandtab

set autoindent
set smartindent
