"██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"██║   ██║██║██╔████╔██║██████╔╝██║
"╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
" ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝


" Automatically source init.vim when saved.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $NVIMRC"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            PLUGINS (VIM-PLUG)                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'                                       " code completion engine
Plug 'nvim-lua/popup.nvim'                                      " required by telescope
Plug 'nvim-lua/plenary.nvim'                                    " required by telescope
Plug 'nvim-telescope/telescope.nvim'                            " telescope - FZF
Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }            " glaxyline statusbar
Plug 'kyazdani42/nvim-web-devicons'                             " needed for galaxyline icons
Plug 'kyazdani42/nvim-tree.lua'                                 " Explorer
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'kosayoda/nvim-lightbulb'

Plug 'tpope/vim-surround'                                       " adds surround operator to vim
Plug 'tpope/vim-commentary'                                     " comment toggle
Plug 'rakr/vim-one'                                             " ONE theme
Plug 'junegunn/goyo.vim'                                        " zen mode
Plug 'airblade/vim-rooter'                                      " find project root for fzf
Plug 'airblade/vim-gitgutter'                                   " git change indicators in sidebar
Plug 'voldikss/vim-floaterm'                                    " Floating terminal
Plug 'mattn/emmet-vim'                                          " html snippets
Plug 'alvan/vim-closetag'                                       " auto close tags
Plug 'godlygeek/tabular'                                        " markdown tables
Plug 'plasticboy/vim-markdown'                                  " markdown support
Plug 'norcalli/nvim-colorizer.lua'                              " view hex code colors inline

call plug#end()

" NOTE: Ensure you use underscores when naming to avoid loops!
lua << EOF
require('lsp')
require('treesitter')
require('completion')
require('_colors')
require('_galaxyline')
require('_todo-comments')
require('_trouble')
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             GENERAL SETTINGS                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number relativenumber               " line numbers relative to current line
set cursorline                          " highlight current line
set backspace=indent,eol,start          " allow backspacing over everything in insert mode
set history=50                          " keep 50 lines of command line history
set ruler                               " show the cursor position all the time
set showcmd                             " display incomplete commands
set incsearch                           " do incremental searching
set showmatch                           " highlight search results
set wildmode=longest,list,full          " autocomplete in command line
set splitbelow splitright               " split and vsplit open in sane locations
set clipboard=unnamed                   " Use the system clipboard
set expandtab shiftwidth=2              " Press <tab>, get two spaces
set list listchars=tab:▸▸,trail:·       " Show `▸▸` for tabs: 	, `·` for tailing whitespace:
set mouse=a                             " Enable mouse mode
set showtabline=2                       " always show tabline
set noshowmode                          " do not show mode if galaxyline/airline/lightline enabled
set completeopt=menuone,noselect

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             LSP KEY BINDINGS                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >> Lsp key bindings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>Lspsaga hover_doc<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>Lspsaga code_action<CR>
xnoremap <silent> ga    <cmd>Lspsaga range_code_action<CR>
nnoremap <silent> gs    <cmd>Lspsaga signature_help<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             TELESCOPE                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Nvim Tree                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:nvim_tree_side = 'right' "left by default
let g:nvim_tree_width = 40 "30 by default
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
" let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
" let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
" let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
" let g:nvim_tree_disable_netrw = 0 "1 by default, disables netrw
" let g:nvim_tree_hijack_netrw = 0 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
" let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
" let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
" let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
" let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_hijack_cursor = 0 "1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
" let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_update_cwd = 0 "1 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ] " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <C-b> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

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
"                             Mappings                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" leader key
let mapleader=" "

" Open vimrc in split from anywhere
map <leader>vm :vsp $MYVIMRC<CR>

" Use <tab> to switch between buffers
" nnoremap <tab> :b#<CR>
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" iTerm 2 key mapping in operation: preferences->keys->key bindings:
" Send: "++" when ⌘ / pressed
" also <leader> / to comment/uncomment
nmap ++ gcc
xmap ++ gc
nmap <leader>/ gcc
xmap <leader>/ gc

" Distraction free mode
map <leader>g :Goyo<CR>

" Move selected lines up and down with JK in visual line mode
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Indent controls
" Reselect text ater indent/unindent.
vnoremap < <gv
vnoremap > >gv
" Tab to indent in visual mode.
vnoremap <Tab> >v
" Shift+Tab to unindent in visual mode.
vnoremap <S-Tab> <gv

" Create splits
" Horizontal split then move to bottom window.
nnoremap <Leader>- <C-w>s
" Vertical split then move to right window.
nnoremap <Leader>\ <C-w>v<C-w>l

" Move between splits with ctrl-hjkl
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" TODO: Well this doesn't work properly...
" nnoremap <leader>| <c-w><bar>
nnoremap <leader>= <c-w>=
" Make adjusing split sizes a bit more friendly
" https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/nvim/init.vim
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" quick save and exit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :wq<CR>
nnoremap <leader>d :bd<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Terminal                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <leader>t :call TermToggle(12)<CR>
inoremap <c-t> <Esc>:call TermToggle(12)<CR>
tnoremap <c-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Auto Close Tags                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified
" files.

let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.

let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified
" files.

let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>`
" will be closed while `<link>` won't.)

let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a 'valid' region (based on filetype)

let g:closetag_regions = {
   \ 'typescript.tsx': 'jsxRegion,tsxRegion',
   \ 'javascript.jsx': 'jsxRegion',
   \ 'typescriptreact': 'jsxRegion,tsxRegion',
   \ 'javascriptreact': 'jsxRegion',
   \ }

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current
" tag, default is ''

let g:closetag_close_shortcut = '<leader>>'

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
" Automatically open Goyo
autocmd FileType markdown Goyo

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
"                           COC                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
  set signcolumn=yes
" endif

