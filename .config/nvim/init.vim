" vim:fdm=marker:fdl=0
" options {{{
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
" }}}

" commands and autocommands {{{
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
" }}}

" maps {{{
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
" }}}

" plugins {{{
call plug#begin('~/.config/nvim/plugged')
    " basic
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'phaazon/hop.nvim'

    " additional functionality
    Plug 'svermeulen/vim-subversive'
    Plug 'svermeulen/vim-cutlass'
    Plug 'Asheq/close-buffers.vim', { 'on': 'Bdelete' }
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " text objects
    Plug 'wellle/targets.vim'
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire'
    Plug 'beloglazov/vim-textobj-punctuation'
    Plug 'Julian/vim-textobj-variable-segment'
    Plug 'inside/vim-textobj-jsxattr', { 'for': [ 'javascriptreact', 'typescriptreact' ] }

    " development
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'sheerun/vim-polyglot'
    Plug 'mattn/emmet-vim', { 'for': ['html', 'javascriptreact', 'typescriptreact'] }

    " visual
    Plug 'szw/vim-maximizer', { 'on': 'MaximizerToggle' }
    Plug 'akinsho/nvim-bufferline.lua'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'glepnir/galaxyline.nvim'
    Plug 'RRethy/vim-illuminate'
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/edge'
    Plug 'sainnhe/forest-night'

    " other
    Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': 'cd app && yarn install'  }
call plug#end()
" }}}

" plugin options {{{
" subversive {{{
" s for substitute
nmap s <Plug>(SubversiveSubstitute)
xmap s <Plug>(SubversiveSubstitute)
nmap ss <Plug>(SubversiveSubstituteLine)
nmap S <Plug>(SubversiveSubstituteToEndOfLine)
" }}}

" cutlass {{{
" m for move (default d behavior)
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D
nnoremap gm m
" }}}

" close-buffers {{{
nmap <silent> <Leader>b :Bdelete menu<CR>
" }}}

" hop {{{
nmap <silent> <Leader>s :HopWord<CR>
nmap <silent> <Leader>S :HopChar2<CR>
" }}}

" maximizer {{{
nnoremap <silent> <C-w>z :MaximizerToggle<CR>
" }}}

" emmet {{{
let g:user_emmet_leader_key='<C-z>'
" }}}

" vsnip {{{
nmap <Leader>v :VsnipOpenVsplit<CR>
" extend filetypes
let g:vsnip_filetypes = { 'javascriptreact': ['javascript'], 'typescriptreact': ['typescript'] }
" <Tab> / <S-Tab> to expand or jump when available
imap <expr> <Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-o>A'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-o>A'
" }}}
" }}}

" theme {{{
let theme_path = '~/.config/nvim/theme.vim'
if filereadable(expand(theme_path))
    execute 'source' theme_path
endif
" }}}

" lua {{{
lua require("init")
" }}}
