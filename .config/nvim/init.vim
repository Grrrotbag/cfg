"██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"██║   ██║██║██╔████╔██║██████╔╝██║     
"╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
" ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            PLUGINS (VIM-PLUG)                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-vinegar'
Plug 'rakr/vim-one'
Plug 'junegunn/goyo.vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               COLOR SCHEME                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme one
set background=dark " for the dark version
" set background=light " for the light version

" fix background colours in iTerm2
highlight Normal ctermbg=NONE 
highlight nonText ctermbg=NONE 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               AIRLINE                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_theme='one'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_left_sep=''
let g:airline_right_sep=''
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             GENERAL SETTINGS                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number relativenumber               " line numbers relative to current line
set cursorline                          " highlight current line
set backspace=indent,eol,start          " allow backspacing over everything in insert mode
set history=50		                " keep 50 lines of command line history
set ruler		                " show the cursor position all the time
set showcmd		                " display incomplete commands
set incsearch		                " do incremental searching
set showmatch                           " highlight search results
set wildmode=longest,list,full          " autocomplete in command line
set splitbelow splitright               " split and vsplit open in sane locations
set clipboard=unnamed                   " Use the system clipboard
set expandtab shiftwidth=2              " Press <tab>, get two spaces
set list listchars=tab:▸▸,trail:·       " Show `▸▸` for tabs: 	, `·` for tailing whitespace: 
set mouse=a                             " Enable mouse mode


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Explorer                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" nnoremap <leader>b :Vex<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" close NERDTree when a file is opened
let NERDTreeQuitOnOpen = 1

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Mappings                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" leader key
let mapleader=" "

" Source $MYVIMRC
nnoremap <leader>` :source $MYVIMRC<CR>

" Use <tab> to switch between buffers
nnoremap <tab> :b#<CR>

" <leader> / to comment/uncomment
nmap <leader>/ gcc

" Distraction free mode
map <leader>g :Goyo<CR>

" Move selected lines up and down with JK in visual line mode
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Create splits
nnoremap <leader>\ :Vsplit<CR>
nnoremap <leader>- :Hsplit<CR>

" Move between splits with ctrl-hjkl
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" quick save and exit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :wq<CR>
