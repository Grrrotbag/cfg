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

Plug 'vim-airline/vim-airline'                                " Airline
Plug 'vim-airline/vim-airline-themes'                         " Airline themes
Plug 'neoclide/coc.nvim', {'branch': 'release'}               " intellisense
Plug 'tpope/vim-surround'                                     " adds surround operator to vim
Plug 'tpope/vim-commentary'                                   " comment toggle
Plug 'rakr/vim-one'                                           " ONE theme
Plug 'junegunn/goyo.vim'                                      " zen mode
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }           " fuzzy finder
Plug 'junegunn/fzf.vim'                                       " fuzzy finder
Plug 'airblade/vim-rooter'                                    " find project root for fzf
Plug 'airblade/vim-gitgutter'                                 " git change indicators in sidebar
Plug 'voldikss/vim-floaterm'                                  " Floating terminal
Plug 'mattn/emmet-vim'                                        " html snippets
Plug 'alvan/vim-closetag'                                     " auto close tags
Plug 'godlygeek/tabular'                                      " markdown tables
Plug 'plasticboy/vim-markdown'                                " markdown support
Plug 'norcalli/nvim-colorizer.lua'                            " view hex code colors inline
Plug 'sheerun/vim-polyglot'                                   " highlighting
Plug 'ryanoasis/vim-devicons'                                 " nerd tree icons ALWAYS LOAD LAST

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Airline                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Switch to your current theme
let g:airline_theme = 'onedark'

" Always show tabs
set showtabline=2

" We don't need to see things like -- INSERT -- anymore
set noshowmode

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
set history=50		                      " keep 50 lines of command line history
set ruler		                            " show the cursor position all the time
set showcmd		                          " display incomplete commands
set incsearch		                        " do incremental searching
set showmatch                           " highlight search results
set wildmode=longest,list,full          " autocomplete in command line
set splitbelow splitright               " split and vsplit open in sane locations
set clipboard=unnamed                   " Use the system clipboard
set expandtab shiftwidth=2              " Press <tab>, get two spaces
set list listchars=tab:▸▸,trail:·       " Show `▸▸` for tabs: 	, `·` for tailing whitespace:
set mouse=a                             " Enable mouse mode
set showtabline=2                       " always show tabline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Mappings                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" leader key
let mapleader=" "

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

" quick save and exit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :wq<CR>
nnoremap <leader>d :bd<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Explorer                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <space>e :CocCommand explorer<CR>

" quit if explorer is the only window open
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               FZF                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" iTerm 2 key mapping in operation: preferences->keys->key bindings:
" Send: ":Files\n" when ⌘ p pressed

map <c-p> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>f :Rg<CR>
" nnoremap <leader>t :Tags<CR>
" nnoremap <leader>m :Marks<CR>

" Put fzf window at bottom of screen
" let g:fzf_layout = { 'down': '~20%' }

" let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Conditional'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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
nnoremap <c-t> :call TermToggle(12)<CR>
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
" autocmd FileType javascript set formatprg=prettier\ --stdin

" Format on save
" autocmd BufWritePre *.js :normal gggqG

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
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

