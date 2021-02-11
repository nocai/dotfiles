" options
let mapleader=" "
set mouse=a
set clipboard+=unnamedplus
set ignorecase smartcase
set undofile undolevels=100 undoreload=100
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set termguicolors
set cursorline
set hidden

" commands and autocommands
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

" statusline
set statusline=\ %f
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %p%%
set statusline+=\ %l:%c

" maps
nnoremap H ^
onoremap H ^
xnoremap H ^
nnoremap L $
onoremap L $
xnoremap L $

nnoremap <Leader>c :

nmap <Tab> %
xmap <Tab> %
omap <Tab> %

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nnoremap <BS> <C-^>
inoremap <S-Tab> <C-o>A
nnoremap Y y$
nnoremap <silent> <Esc> :nohl<CR>

nnoremap <silent> <expr> <CR> (&buftype is# "quickfix" ? "<CR>" : ":w<CR>")

" plugins
call plug#begin('~/.config/nvim/plugged')
    " basic
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    Plug 'Raimondi/delimitMate'

    " additional functionality
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'svermeulen/vim-cutlass'

    " integrations
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " text objects
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire'

    " visual
    Plug 'sainnhe/sonokai'
call plug#end()

" plugin options
" delimitMate
let g:delimitMate_expand_cr = 1

" cutlass
" m for move (default d behavior)
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D
nnoremap gm m

" fzf
" :Rg only searches file contents, not names
command! -bang -nargs=* Rg
    \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
" maps
nmap <silent> <Leader>f :Files<CR>

" sneak
" enable label mode
let g:sneak#label = 1
" obey smart case
let g:sneak#use_ic_scs = 1

" maps
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

source ~/.config/nvim/theme.vim
