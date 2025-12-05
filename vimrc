" =============================================================================
"   1. GENERAL SETTINGS
" =============================================================================
set nocompatible
set encoding=utf-8
set mouse=a                     " Enable mouse usage (all modes)

" --- Visuals ---
set termguicolors               " True color support
set number relativenumber       " Hybrid line numbers
set cursorline                  " Highlight current line
set title                       " Update terminal title
set visualbell                  " No beeping
set nowrap                      " Do not wrap long lines
set scrolloff=10                " Keep cursor away from top/bottom edges
set signcolumn=yes              " Always show sign column (prevents text shift)
set synmaxcol=800               " Don't highlight very long lines (perf)
set showmode                    " Show current mode at bottom
set showcmd                     " Show partial commands
set laststatus=2                " Always show statusline
set list                        " Show invisible characters
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮
set showbreak=↪
set fillchars=diff:⣿,vert:│

" --- Indentation & Tabs ---
set autoindent
set expandtab                   " Use spaces instead of tabs
set smarttab
set shiftwidth=4                " 1 tab = 4 spaces
set softtabstop=4
set tabstop=4
set shiftround                  " Round indent to multiple of 4

" --- System & Files ---
set autoread                    " Reload files changed outside Vim
set autowrite                   " Auto save before commands
set hidden                      " Allow hidden buffers
set history=1000                " Store lots of command history
set noswapfile                  " (Optional) Disable swap files
set nobackup                    " (Optional) Disable backup files
set undofile                    " Persistent undo
set undolevels=1000             " Maximum number of changes that can be undone
set undoreload=10000            " Maximum number lines to save for undo on a buffer reload
set backspace=indent,eol,start  " Make backspace work as expected
set splitbelow                  " Horizontal splits open below
set splitright                  " Vertical splits open to right
set clipboard=unnamed           " Sync with OS clipboard

" --- Search ---
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive if capital letter used
set incsearch                   " Incremental search
set hlsearch                    " Highlight search results

" =============================================================================
"   2. PLUGINS (Vim-Plug)
" =============================================================================
call plug#begin('~/.vim/plugged')

" --- UI & Themes ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

" --- Syntax & Language Support ---
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'gu-fan/riv.vim'                    " RST Support
Plug 'psf/black', { 'branch': 'stable' } " Python Formatter

" --- Specific Tools ---
Plug 'chrisbra/csv.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" --- Utilities ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'                " Git
Plug 'airblade/vim-gitgutter'            " Git Signs
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-startify'                      " Start Screen
Plug 'tpope/vim-obsession'               " Session Auto-save
Plug 'SirVer/ultisnips'                  " Snippet Engine
Plug 'honza/vim-snippets'                " Snippet Library

call plug#end()

" =============================================================================
"   3. THEME SETTINGS
" =============================================================================
set background=dark
colorscheme gruvbox

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
set noshowmode  " Airline handles this

" IndentLine
let g:indentLine_char = '┆'
let g:vim_json_syntax_conceal = 0

" =============================================================================
"   4. PLUGIN CONFIGURATIONS (Logic Only)
" =============================================================================

" --- NERDTree ---
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeWinSize=30
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" Auto-close if NERDTree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" --- Python (Black) ---
" Auto-format on save
autocmd BufWritePre *.py execute ':Black'

" --- RST (Riv) ---
let g:riv_fold_level = 1
let g:riv_auto_fold_force = 1
let g:riv_python_rst2html = 'rst2html.py'

" --- FZF (Fuzzy Finder) ---
let g:fzf_layout = { 'down': '40%' }
" Use Ripgrep if available
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!.git/*"'
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, {'source': 'rg --files --hidden --follow -g "!.git/*"', 'options': '--tiebreak=index'}, <bang>0)
endif
" Match FZF colors to Gruvbox
let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'GruvboxRed'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'GruvboxGreen'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }
" Clean statusline for FZF
autocmd! FileType fzf set laststatus=0 noshowmode
  \| autocmd BufLeave <buffer> set laststatus=2 showmode

" --- Startify (Sessions) ---
let g:startify_session_dir = '~/.vim/session'
let g:startify_session_persistence = 1
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Saved Projects']       },
      \ { 'type': 'files',     'header': ['   Recent Files']         },
      \ { 'type': 'dir',       'header': ['   Current Directory']    },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']            },
      \ ]

" --- UltiSnips ---
" Triggers defined here because they are variables, not maps
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsEditSplit = 'vertical'

" --- CoC Internal Logic (Tab/Enter behavior) ---
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" =============================================================================
"   5. KEYBOARD SHORTCUTS CHEAT SHEET
"   (Everything you press is defined here)
" =============================================================================

" --- The Leader Key ---
let mapleader = ","
let maplocalleader = "\\"

" --- 1. General Editing ---
" Escape insert mode quickly
inoremap jk <Esc>
" Use ; for : (saves shift key)
nnoremap ; :
" Save file
nnoremap <leader>w :w<CR>
" Sudo write
cnoremap w!! w !sudo tee % >/dev/null
" Stop highlighting search results
map <leader><space> :noh<cr>
" Prevent window from popping up when pressing q:
map q: :q

" --- 2. Navigation ---
" Go to Start of line
noremap H ^
" Go to End of line
noremap L $
" Move between split windows (Ctrl + h/j/k/l)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Resize vertical split
nnoremap <Leader>d :vertical resize

" --- 3. Text Manipulation ---
" Yank to end of line
noremap Y y$
" Delete to end of line
nnoremap D d$
" Indent/Dedent visually selected text (keeps selection)
vnoremap < <gv
vnoremap > >gv
" Move line up/down (Alt + j/k) - Optional, very useful
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" --- 4. Python Running ---
" Run current Python file with F5
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:exec '!python' shellescape(@%, 1)<CR>

" --- 5. Plugin Shortcuts ---

" [ NERDTree ] File Explorer
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" [ FZF ] File Search
nnoremap <C-p> :Files<CR>       " Search Files
nnoremap <leader>b :Buffers<CR> " Search Open Buffers
nnoremap <leader>g :Rg<CR>      " Search Text inside files

" [ CoC ] Intelligence
" Go to Definition
nmap <silent> gd <Plug>(coc-definition)
" Go to Type Definition
nmap <silent> gy <Plug>(coc-type-definition)
" Go to Implementation
nmap <silent> gi <Plug>(coc-implementation)
" Find References
nmap <silent> gr <Plug>(coc-references)
" Show Documentation (K)
nnoremap <silent> K :call ShowDocumentation()<CR>

" [ Sessions ]
nnoremap <leader>s :SSave<Space>   " Save Session
nnoremap <leader>sd :SDelete<CR>   " Delete Session
nnoremap <leader>sc :SClose<CR>    " Close Session

" [ Tabs ]
map tn :tabn<CR>      " Next Tab
map tp :tabp<CR>      " Previous Tab
map tt :tabnew        " New Tab
map ts :tab split<CR> " Duplicate into new Tab
