set nowrap
set sidescroll=1
set sidescrolloff=10
set splitbelow
set splitright

" =============================================================================
"   4. PLUGIN CONFIGURATIONS (Logic Only)
" =============================================================================
Plug 'psf/black', {'tag': 'stable'}

" --- NERDTree ---
let g:NERDTreeWinPos = "right"

autocmd BufWritePost *.py execute "silent !black " . shellescape(expand("%")) | silent! checktime | redraw!
" augroup python_autoformat
"    autocmd!
"    autocmd BufWritePost *.py execute "silent !black %" | silent! checktime | redraw!
" augroup END

" Unmap Ctrl+v so it stops pasting and starts block selecting
if has('win32') || has('win64')
    " On Windows, sometimes Ctrl+q is used as a fallback for block select
    " This ensures Ctrl+v does what it's supposed to do
    nnoremap <C-v> <C-v>
    vnoremap <C-v> <C-v>
endif



" --- Ripgrep Configuration ---

" Define the base command with all ignore rules
" --vimgrep: Output format for Vim
" --smart-case: Smart case search
" --hidden: Search hidden files (dotfiles)
" --glob: EXPLICITLY IGNORE these patterns
let g:rg_command = 'rg --vimgrep --no-heading --smart-case --hidden --follow ' .
    \ '--glob "!.git/*" ' .
    \ '--glob "!__pycache__/*" ' .
    \ '--glob "!*.pyc" ' .
    \ '--glob "!node_modules/*"'

" 1. Apply to 'ackprg' (For searching text inside files)
let g:ackprg = g:rg_command

" 2. Apply to 'grepprg' (For standard Vim :grep command)
let &grepprg = g:rg_command

" 3. Apply to FZF (For Ctrl+P file finding)
" FZF needs a slightly different format (files-only mode)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow ' .
    \ '--glob "!.git/*" ' .
    \ '--glob "!__pycache__/*" ' .
    \ '--glob "!*.pyc" ' .
    \ '--glob "!node_modules/*"'

" Update the FZF :Files command to use this
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'source': $FZF_DEFAULT_COMMAND, 'options': '--tiebreak=index'}, <bang>0)


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
" nnoremap <M-j> :m .+1<CR>==
" nnoremap <M-k> :m .-2<CR>==
" inoremap <M-j> <Esc>:m .+1<CR>==gi
" inoremap <M-k> <Esc>:m .-2<CR>==gi
" vnoremap <M-j> :m '>+1<CR>gv=gv
" vnoremap <M-k> :m '<-2<CR>gv=gv

" --- 5. Plugin Shortcuts ---


" [ Tabs ]
" Next Tab
" map tn :tabn<CR>
" map tp :tabp<CR>
" Previous Tab
" map tt :tabnew
" Duplicate into new Tab
" map ts :tab split<CR>

" [ Custom ] Split line at cursor (Shift + s)
" Acts like pressing Enter in normal mode to break the line
nnoremap S i<CR><Esc>

" " Force-clear any existing Ctrl-v mapping
" unmap <C-v>
" iunmap <C-v>

" Explicitly tell Vim to use Ctrl-v for Visual Block
nnoremap vv <C-v>



nmap <space>, :Buffers<CR>


