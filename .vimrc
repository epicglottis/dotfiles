" epicglottis' vimrc file

set nocompatible               " be iMproved, required
filetype off                   " required
syntax on

" >>> VUNDLE START >>>
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required:
Plugin 'gmarik/Vundle.vim'

" My bundles here:
" DEPENDENCY: sudo apt-get install exuberant-ctags
Plugin 'majutsushi/tagbar'
" Ctrl-P
Plugin 'kien/ctrlp.vim'
" NERDTree
Plugin 'scrooloose/nerdtree'
" Syntax checking
" Plugin 'scrooloose/syntastic'
" Airline
Plugin 'bling/vim-airline'
" Show hex colors in editor :)
Plugin 'ap/vim-css-color'

" All of your Plugins must be added before the following line
call vundle#end()              " required
filetype plugin indent on      " required

" NERDTree config
nmap <F1> :NERDTreeToggle<CR>

" Ctrl-P config
nmap <F2> :CtrlPBuffer<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" AirLine config
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
" <<< VUNDLE END <<<

" Color Syntax Highlighting
set t_Co=256
colorscheme epic

if has('gui_running')
  set guifont=Source Code Pro\ 14
endif

 " Python!
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab

" Rolodex mode!!
set noequalalways
set winminheight=0
set winheight=9999
set helpheight=9999

" Indentation
set autoindent
" copy previous indentation:
set copyindent                 
set nocindent
set nosmartindent

" General
" Hide non-printable chars:
set nolist
" Show cursor position information at the bottom:
set ruler
set number                     " show line numbers

set modelines=0
set autoread
set encoding=utf-8
set scrolloff=5
set showcmd
set wildmenu
set wildmode=longest,list,full " Wildcard expansion completion modes
set visualbell                 " don't beep
set noerrorbells               " don't beep
set ttyfast
set backspace=indent,eol,start " allow backspace over everything
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                      " change the terminal title
set autochdir                  " Auto lcd to whatever file is open

 " Automatically change the working directory to the current one
au BufEnter * silent! lcd %:p:h

" For split screen users: higlight the status line of the active window
set laststatus=2               " Always display the last status

" code folding
set foldmethod=syntax
set foldlevelstart=20          " Unfold on load.

" tmux fixes
" Handle tmux $TERM quirks in vim
map <Esc>[B <Down>
if $TERM =~ '^screen-256color'
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>
endif

" Tab Settings
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=80
set shiftround                           " use shiftwidth when indenting '<'
set smarttab                             " use shiftwidth not tabstop
if has('autocmd')                        " work in old vim versions too
  filetype plugin indent on              " enable indenting intelligence
  autocmd filetype python set expandtab  " file type specific settings
endif

" Searching/Moving
set ignorecase                 " only ignores case if search is all lowercase
set smartcase
set nogdefault                 " I habitually type s///g vs s///
set incsearch                  " show results as you type
set showmatch                  " show matching braces
set hlsearch
nnoremap <tab> %
vnoremap <tab> %


" Undo
set history=10000              " remember more commands and search history
set undolevels=10000           " use many muchos levels of undo
set nobackup                   " be a man
au FocusLost * :wa             " but save on losing focus
set noswapfile                 " bad idea if you load large files

" Long lines
set nowrap
set formatoptions=qrn1
if version >= 703
  set colorcolumn=80
else
  " color chars in line >80 in red
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

" Highlight trailing whitespace:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Delete trailing whitespace on save:
autocmd BufWritePre *.py :%s/\s\+$//e

" Status Line
"set statusline=%<(%f)\ %h%m%r%=%-14.(%l/%L%)\ %P

" Rebinds
" Highly recommended you rebind CapsLock as Ctrl!
" ; behaves the same as : (because typos)
nnoremap ; :

" jj is also esc and ctrl-c
inoremap jj <ESC>
nmap j gj
nmap k gk

" F5 toggles paste mode
noremap <F5> :set invpaste paste?<CR>
set pastetoggle=<F5>
set showmode

" F8 toggles tagbar & resizes windows equally
" DEPENDENCY: http://www.vim.org/scripts/script.php?script_id=3465
nmap <F8> :TagbarToggle<CR><C-w>=
nmap <leader>8 :TagbarToggle<CR>

" Get rid of that annoying F1 help message
"noremap <F1> <ESC>

" Turn off arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Make split windows easier
" CTRL + DIRECTION
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-left> <C-w>h
noremap <C-down> <C-w>j
noremap <C-up> <C-w>k
noremap <C-right> <C-w>l

" Forgot to sudo a file? use w!!
cmap w!! w !sudo tee % >/dev/null

" Normal Mode Leaders
let mapleader = ","
let g:mapleader = ","
" ,<space> Clear search
map <leader><space> :noh<cr>

" ,1   Add === of equal length to line below cursor
nnoremap <leader>1 yypVr=

" ,a   Ack
nnoremap <leader>a :Ack

" ,ev  Open vimrc file
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" ,ft  Fold tag
nnoremap <leader>ft Vatzf

" ,q   Re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" ,r    Reload ~/.vimrc
nnoremap <leader>r :so ~/.vimrc<cr>:echo "reloaded!"<cr>

" ,S   Sort CSS Properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" ,ss  Toggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" ,v  Open vimrc file:
nnoremap <leader>v <C-w><C-v><C-l>:e $MYVIMRC<cr>

" ,w   Open split window and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" ,W   Strip trailing whitespace in file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
