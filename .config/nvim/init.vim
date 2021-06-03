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

Plug 'itchyny/lightline.vim'                                  " status line
Plug 'mengelbrecht/lightline-bufferline'                      " lightlinr tabs
Plug 'tpope/vim-surround'                                     " adds surround operator to vim
Plug 'tpope/vim-commentary'                                   " comment toggle
Plug 'rakr/vim-one'                                           " ONE theme
Plug 'junegunn/goyo.vim'                                      " zen mode
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }           " fuzzy finder
Plug 'junegunn/fzf.vim'                                       " fuzzy finder
Plug 'mattn/emmet-vim'                                        " html snippets
Plug 'airblade/vim-gitgutter'                                 " git change indicators in sidebar
Plug 'scrooloose/nerdtree'                                    " file tree
Plug 'scrooloose/syntastic'                                   " syntax checker
Plug 'alvan/vim-closetag'                                     " auto close tags
Plug 'godlygeek/tabular'                                      " markdown tables
Plug 'plasticboy/vim-markdown'                                " markdown support

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " code completion
Plug 'wokalski/autocomplete-flow'                             " javscript for deoplete
Plug 'Shougo/neosnippet'                                      " snippet support
Plug 'Shougo/neosnippet-snippets'                             " default snippets for neosnippet
let g:deoplete#enable_at_startup = 1

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               LIGHTLINE                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

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
set showtabline=2                       " always show tabline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           NERDTree                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" close NERDTree when a file is opened
let NERDTreeQuitOnOpen = 1

nnoremap <silent> <c-b> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Markdown                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://secluded.site/vim-as-a-markdown-editor/

" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Hide and format markdown elements like **bold**
" autocmd FileType markdown set conceallevel=2

" Set spell check to British English
autocmd FileType markdown setlocal spell spelllang=en_gb

" Configuration for vim-markdown
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_follow_anchor = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Javascript                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use prettier
autocmd FileType javascript set formatprg=prettier\ --stdin

" Format on save
autocmd BufWritePre *.js :normal gggqG

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
nmap <leader>/ gcc      " single line
xmap <leader>/ gc       " visual block

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
