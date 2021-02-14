" options
let mapleader=','
set mouse=a
set clipboard+=unnamedplus
set ignorecase smartcase
set history=100
set undofile undolevels=100 undoreload=100
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set termguicolors
set cursorline
set foldlevelstart=99
set noshowcmd noshowmode

set nobackup nowritebackup
set updatetime=300
set splitbelow splitright
set hidden
set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noinsert,noselect
set pumheight=10
set foldlevelstart=99

" commands and autocommands
command! Remove call delete(expand('%')) | bdelete!
command! Trim %s/ \+$//

" lua yank highlighting
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

" automatically create nonexistent directories on :e
augroup create_directory
    autocmd!
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nmap <silent> <Leader>q :call ToggleQuickFix()<CR>

" maps
nnoremap H ^
onoremap H ^
xnoremap H ^
nnoremap L $
onoremap L $
xnoremap L $

nnoremap <Space> :
vnoremap <Space> :

nmap <Tab> %
xmap <Tab> %
omap <Tab> %

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nnoremap <BS> <C-^>
nmap <silent> <Leader>x :bd<CR>
nnoremap Y y$
nnoremap <silent> <Esc> :nohl<CR>
noremap <Bslash> ,
nnoremap ZZ :wqall<CR>

inoremap (; (<CR>)<C-c>O
inoremap {; {<CR>}<C-c>O
inoremap [; [<CR>]<C-c>O

" <CR> to save, except in quickfix buffers
nnoremap <silent> <expr> <CR> (&buftype is# "quickfix" ? "<CR>" : ":w<CR>")

" add k/j movements > 1 to jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" expansion to edit / create file in current buffer directory
nmap <Leader>e :edit <C-r>=expand('%:h')<CR>/

" theme
let theme_path = '~/.config/nvim/theme.vim'
if filereadable(expand(theme_path))
    execute 'source' theme_path
endif

" load lua config
lua require("init")
