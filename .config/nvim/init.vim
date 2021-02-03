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

set nobackup nowritebackup
set updatetime=300
set cursorline
set splitbelow splitright
set hidden
set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noinsert,noselect
set noshowcmd
set noshowmode
set pumheight=10
set showtabline=2

" enable true colors in tmux
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" | let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" }}}

" commands and autocommands {{{
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

command! Remove call delete(expand('%')) | bdelete!
" }}}

" statusline {{{
set statusline=\ %f
set statusline+=\ %m
set statusline+=\ %{FugitiveHead()}
set statusline+=\ %{GitgutterStatus()}
set statusline+=%=
set statusline+=%{StatusDiagnostic()}
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
nnoremap <silent> <Esc> :noh<CR><Esc>
noremap <Bslash> ,
nnoremap ZZ :wqall<CR>
nnoremap <C-w>x :q<CR>

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
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'svermeulen/vim-subversive'
    Plug 'svermeulen/vim-cutlass'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ntpeters/vim-better-whitespace', { 'for': [ 'vim', 'zsh', 'tmux', 'snippets' ] }
    Plug 'Asheq/close-buffers.vim', { 'on': 'Bdelete' }
    Plug 'justinmk/vim-dirvish'
    Plug 'vifm/vifm.vim'

    " text objects
    Plug 'wellle/targets.vim'
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire'
    Plug 'beloglazov/vim-textobj-punctuation'
    Plug 'Julian/vim-textobj-variable-segment'
    Plug 'inside/vim-textobj-jsxattr', { 'for': [ 'javascriptreact', 'typescriptreact' ] }

    " development
    Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
    Plug 'mattn/emmet-vim', {'for': [ 'html', 'javascriptreact', 'typescriptreact' ] }
    Plug 'sheerun/vim-polyglot'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim', { 'on': 'GV' }

    " visual
    Plug 'sainnhe/sonokai'
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
nnoremap gmm m'
" }}}

" coc {{{
command! CR CocRestart
command! CC CocConfig
command! -nargs=0 Format :call CocAction('format')

" maps
nmap <silent> [a <Plug>(coc-diagnostic-prev)
nmap <silent> ]a <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-rename)
nmap <silent> gR :CocCommand workspace.renameCurrentFile<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gI <Plug>(coc-references)
nmap <silent> ga <Plug>(coc-codeaction-selected)
xmap <silent> ga <Plug>(coc-codeaction-selected)
nmap <silent> gA <Plug>(coc-codeaction)
nmap <silent> gs :CocCommand editor.action.organizeImport<CR>

" leader maps
nmap <silent> <Leader>ca :CocList diagnostics<CR>
nmap <silent> <Leader>cv :CocList outline<CR>
nmap <silent> <Leader>cp :CocList snippets<CR>
nmap <silent> <Leader>cs :CocCommand snippets.editSnippets<CR>
xmap <silent> <Leader>cs <Plug>(coc-convert-snippet)
nmap <silent> <Leader>cr :CocRestart<CR>
nmap <silent> <Leader>cc :CocConfig<CR>
nmap <silent> <Leader>cx :CocList extensions<CR>
nmap <silent> <Leader>ci :CocInfo<CR>
nmap <silent> <Leader>cq <Plug>(coc-fix-current)

" show vim documentation or lsp hover
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

" text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" range select
nmap <silent> <C-n> <Plug>(coc-range-select)
xmap <silent> <C-n> <Plug>(coc-range-select)

" coc-snippets: <Tab> to select / jump, <C-Space> to select / refresh
inoremap <silent><expr> <TAB>
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<TAB>"
let g:coc_snippet_next = '<Tab>'

inoremap <silent><expr> <C-Space>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#refresh()

" statusline integration
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction
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

" emmet {{{
" don't load at all, since coc-emmet doesn't need it
let g:user_emmet_install_global = 0
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

" gitgutter {{{
" statusline integration
function! GitgutterStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
" }}}

" vim-plug {{{
nmap <silent> <Leader>pp :PlugInstall<CR>
nmap <silent> <Leader>pc :PlugClean<CR>
nmap <silent> <Leader>pu :PlugUpdate<CR>
nmap <silent> <Leader>ps :PlugStatus<CR>
" }}}

" dirvish {{{
" always sort folders first
let g:dirvish_mode = ':sort ,^.*[\/],'
" replace netrw
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" maps
augroup dirvish_bindings
    autocmd!
    autocmd FileType dirvish nnoremap <buffer> a :!touch %
    autocmd FileType dirvish nnoremap <buffer> A :!mkdir %
    autocmd FileType dirvish nnoremap <buffer> S :Shdo<Space>
    autocmd FileType dirvish xnoremap <buffer> S :Shdo<Space>
    autocmd FileType dirvish nnoremap <silent><buffer> v :call dirvish#open('vsplit', 0)<CR>
    autocmd FileType dirvish xnoremap <silent><buffer> v :call dirvish#open('vsplit', 0)<CR>
    autocmd FileType dirvish nnoremap <silent><buffer> s :call dirvish#open('split', 0)<CR>
    autocmd FileType dirvish xnoremap <silent><buffer> s :call dirvish#open('split', 0)<CR>
augroup END
" }}}

" vifm {{{
nmap <Leader>v :Vifm<CR>
" }}}

" theme {{{
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_better_performance = 1
colorscheme sonokai
" }}}
" }}}
