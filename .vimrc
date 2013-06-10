
call pathogen#infect()

syntax on
filetype plugin indent on
set autoindent
set cindent

"not compatible with vi
set nocompatible

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set incsearch

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"set background=dark
"colorscheme solarized
colorscheme molokai

"set nowrap
set scrolloff=2

"makes backspace work as expected for tabs and such
set backspace=start,indent,eol

set showmatch
set showmode
set showcmd
set ruler
set title

" highlight current line
set cursorline
set cmdheight=2
set switchbuf=useopen
set showtabline=2
set winwidth=79

"turns on auto completion in command mode
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

"turn on nice line breaking
set lbr
"use ellipsis to indicate a line break
set showbreak=…

set laststatus=2
set matchtime=2
set matchpairs+=<:>

set esckeys
set ignorecase
set smartcase
set smartindent
set smarttab
set magic

let mapleader=","

" automatically change dir to the dir that the currently working file is.
if exists("+autochdir")
set autochdir
else
autocmd BufEnter * lcd %:p:h
endif



set fileformat=unix

set lazyredraw
set confirm

"set backup code
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

"don't save swap file
set noswapfile

"undo stuff
"location of undo files
if exists("+undodir")
set undodir=~/.vimundo
"save an undo file - persistent undo
set undofile
"max number of changes that can be undone
set undolevels=1000
"undo on reload
set undoreload=10000
endif

"fix search - normal regex can be used in searching
nnoremap / /\v
vnoremap / /\v

set viminfo='20,\"500
set hidden
set history=1000
set mouse=a

"map  <C-Right> :tabn<CR>
"map  <C-Left> :tabp<CR>
map  <C-n> :tabnew<CR>

" Python mode indentation
let g:pymode_options_indent = 0
let g:pymode_options_other = 0
let g:pymode_folding = 0

set winminheight=0      " Allow windows to get fully squashed

"
" Switch between windows, maximizing the current window
"
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_

set hlsearch
set incsearch

set mousemodel=extend


set clipboard=unnamedplus

"noremap <silent> <C-S>          :update<CR>
"vnoremap <silent> <C-S>         <C-C>:update<CR>
"inoremap <silent> <C-S>         <esc>:update<CR>a


map <F9> :w<CR>:!xclip -o > in <CR> :!g++ % -g && (ulimit -c unlimited; ./a.out < in) <CR>
"map <F7> :w<CR>:!g++ % -g && (ulimit -c unlimited; ./a.out) <CR>
map<F4> :!python % <CR>

map <Leader>ht :set filetype=html<CR>

set guitablabel=\[%N\]\ %t


"{{{Auto Commands


" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader><leader> <c-^>
" Move around splits with <c-hjkl>
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-h> <c-w>h
"nnoremap <c-l> <c-w>l
imap jj <esc>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40


"explorer mappings
nnoremap <f1> :BuffergatorToggle<cr>
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :TlistToggle<cr>


let g:Powerline_symbols = 'fancy'
set guioptions-=T
let g:buffergator_autoexpand_on_split = 0
set guifont=Ubuntu\ Mono\ for\ VimPowerline\ 12
