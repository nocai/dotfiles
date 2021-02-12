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

set nobackup nowritebackup
set updatetime=300
set splitbelow splitright
set hidden
set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noinsert,noselect
set pumheight=10
set showtabline=2
set foldlevelstart=99

let g:python_host_prog = $HOME . '/.pyenv/shims/python'
let g:python3_host_prog = $HOME . '/.pyenv/shims/python3'
" }}}

" commands and autocommands {{{
" lua yank highlighting
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

command! Remove call delete(expand('%')) | bdelete!

" automatically create nonexistent directories on :e
augroup create_directory
    autocmd!
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END
" }}}

" statusline {{{
set statusline=\ %f
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %p%%
set statusline+=\ %l:%c
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
inoremap <S-Tab> <C-o>A
nmap <silent> <Leader>x :bd<CR>
nnoremap Y y$
nnoremap <silent> <Esc> :nohl<CR>
noremap <Bslash> ,
nnoremap ZZ :wqall<CR>

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
    Plug 'justinmk/vim-sneak'
    Plug 'Raimondi/delimitMate'

    " additional functionality
    Plug 'svermeulen/vim-subversive'
    Plug 'svermeulen/vim-cutlass'
    Plug 'ntpeters/vim-better-whitespace', { 'for': [ 'vim', 'zsh', 'tmux', 'snippets' ] }
    Plug 'Asheq/close-buffers.vim', { 'on': 'Bdelete' }

    " integrations
    Plug 'mcchrish/nnn.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

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
    Plug 'mhartington/formatter.nvim'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'sheerun/vim-polyglot'
    Plug 'airblade/vim-gitgutter'

    " visual
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/edge'
    Plug 'sainnhe/forest-night'
    Plug 'szw/vim-maximizer', { 'on': 'MaximizerToggle' }
    Plug 'ap/vim-buftabline'

    " other
    Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': 'cd app && yarn install'  }
call plug#end()
" }}}

" plugin options {{{
" delimitMate {{{
let g:delimitMate_expand_cr = 1
" }}}

" subversive {{{
" s for substitute
nmap s <Plug>(SubversiveSubstitute)
xmap s <Plug>(SubversiveSubstitute)
nmap ss <Plug>(SubversiveSubstituteLine)
nmap S <Plug>(SubversiveSubstituteToEndOfLine)
" <Leader>s to substitute over range
nmap <silent> <Leader>s <Plug>(SubversiveSubstituteRange)
xmap <silent> <Leader>s <Plug>(SubversiveSubstituteRange)
nmap <silent> <Leader>ss <Plug>(SubversiveSubstituteWordRange)
" }}}

" cutlass {{{
" m for move (default d behavior)
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D
nnoremap gm m
" }}}

" fzf {{{
" :Rg only searches file contents, not names
command! -bang -nargs=* Rg
    \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
" maps
nmap <silent> <Leader>f :Files<CR>
nmap <silent> <Leader>m :Buffers<CR>
nmap <silent> <Leader>l :BLines<CR>
nmap <silent> <Leader>L :Lines<CR>
nmap <silent> <Leader>r :Rg<CR>
nmap <silent> <Leader>H :History<CR>
" }}}

" close-buffers {{{
nmap <silent> <Leader>b :Bdelete menu<CR>
" }}}

" sneak {{{
" enable label mode
let g:sneak#label = 1
" obey smart case
let g:sneak#use_ic_scs = 1

" maps
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S
omap z <Plug>Sneak_f
omap Z <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
" }}}

" better-whitespace {{{
" enable seamless fixing on save
let g:strip_whitespace_confirm = 0
" also trim empty lines
let g:strip_whitelines_at_eof = 1
" enable when lazy loaded by vim-plug
augroup EnableWhitespacePlugin
    autocmd!
    autocmd User vim-better-whitespace EnableStripWhitespaceOnSave
augroup END
" }}}

" maximizer {{{
nnoremap <silent> <C-w>z :MaximizerToggle<CR>
" }}}

" buftabline {{{
" always show
let g:buftabline_show = 2
" show ordinal numbers
let g:buftabline_numbers = 2
" show buffer state
let g:buftabline_indicators = 1
" bindings
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
" }}}

" nnn {{{
" enable additional actions
let g:nnn#action = {
      \ '<C-t>': 'tab split',
      \ '<C-x>': 'split',
      \ '<C-v>': 'vsplit' }
" maps
nmap <silent> - :NnnPicker %<CR>
nmap <silent> <Leader>n :NnnPicker<CR>
" }}}

" vim-plug {{{
nmap <silent> <Leader>pp :PlugInstall<CR>
nmap <silent> <Leader>pc :PlugClean<CR>
nmap <silent> <Leader>pu :PlugUpdate<CR>
nmap <silent> <Leader>ps :PlugStatus<CR>
" }}}

" theme {{{
let theme_path = '~/.config/nvim/theme.vim'
if filereadable(expand(theme_path))
    execute 'source' theme_path
endif
" }}}
" }}}

" lua {{{
lua require("init")
" }}}
