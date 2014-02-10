" epicglottis' vimrc file

set nocompatible               " nocompat must be first

" Indentation
set autoindent                 " always on
set copyindent                 " copy previous indentation
set nocindent
set nosmartindent

" General
set list
filetype on
set ruler
set hidden                     " For BufExplorer
set number                     " show line numbers
if version >= 703
  set clipboard=unnamedplus    " Yank to X window clipboard (vim 7.3.74+)
endif
set modelines=0
set autoread
set encoding=utf-8
set scrolloff=3
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
syntax on

 " Automatically change the working directory to the current one
au BufEnter * silent! lcd %:p:h

" For split screen users: higlight the status line of the active window
set laststatus=2               " Always display the last status
hi StatusLine ctermfg=Cyan

" pathogen/vundle
" TODO

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

" Syntax Highlighting
set t_Co=256
if &t_Co >= 256 || has("gui_running")
   colorscheme tmac_modified
endif

if has('gui_running')
  set guifont=Monospace\ 13
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
nnoremap / /\v                 " enable "very magic"
vnoremap / /\v                 " enable "very magic"
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
  set colorcolumn=80           " Requires VIM 7.3
else
  " color chars in line >80 in red
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

" Display vertical cursor:
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Highlight trailing whitespace:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Status Line
set statusline=%<(%f)\ %h%m%r%=%-14.(line %l/%L%)\ %P

" Rebinds
" Highly recommended you rebind CapsLock as Ctrl!
nnoremap ; :                  " ; behaves the same as :
inoremap jj <ESC>             " jj is also esc
nnoremap j gj
nnoremap k gk

" F5 toggles paste mode
noremap <F5> :set invpaste paste?<CR>
set pastetoggle=<F5>
set showmode

" F8 toggles tagbar
" DEPENDENCY: http://www.vim.org/scripts/script.php?script_id=3465
nmap <F8> :TagbarToggle<CR>
nmap <leader>8 :TagbarToggle<CR>

" Get rid of that annoying F1 help message
noremap <F1> <ESC>

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
map <leader><space> :noh<cr>                               " ,<space> Clear search
nnoremap <leader>1 yypVr=                                  " ,1   Add === of equal length to line below cursor
nnoremap <leader>a :Ack                                    " ,a   Ack
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>         " ,ev  Open vimrc file
nnoremap <leader>ft Vatzf                                  " ,ft  Fold tag
nnoremap <leader>q gqip                                    " ,q   Re-hardwrap paragraphs of text
nnoremap <leader>r :so ~/.vimrc<cr>:echo "reloaded!"<cr>   " ,    Reload ~/.vimrc
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR> " ,S   Sort CSS Properties
nnoremap <leader>ss :setlocal spell!<cr>                   " ,ss  Toggle spell checking
nnoremap <leader>v V`]                                     " ,v   Reselect text that was just pasted
nnoremap <leader>w <C-w>v<C-w>l                            " ,w   Open split window and switch to it
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>           " ,W   Strip trailing whitespace in file
