" Vim Plug
call plug#begin('~/.local/share/nvim/plugged')
" Editor
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'itchyny/lightline.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Linting
Plug 'w0rp/ale', { 'on':  'ALEToggle' } 
" Alignment
Plug 'junegunn/vim-easy-align'
" Completion
Plug 'ervandew/supertab'
" Syntax
Plug 'sheerun/vim-polyglot'
"Plug 'Raimondi/delimitMate'
" Comment
Plug 'scrooloose/nerdcommenter'
" Search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Themes
Plug 'dinhtungdu/ayu-vim'
" Initialize plugin system
call plug#end()

" General
let mapleader=","
syntax enable
" set t_Co=256
set termguicolors
let ayucolor="dark"
colorscheme ayu
set nu
filetype plugin indent on
set nocp
set ruler
set wildmenu
set mouse-=a
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set relativenumber
nmap <Leader>t :tabNext<CR>

" Save cursor position
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

" Clipboard setting
set clipboard^=unnamed,unnamedplus

" Persistent undo
set undofile
set undodir=$HOME/.local/share/nvim/undo
set undolevels=1000
set undoreload=10000

" Code folding
set foldmethod=manual

" Tabs and spacing
set autoindent
set cindent
set tabstop=2
set noexpandtab
set shiftwidth=2
set smarttab

" Search and replace
set hlsearch
set incsearch
set ignorecase
set smartcase
set diffopt +=iwhite
vnoremap // y/<C-R>"<CR>
vnoremap <F3> y/<C-r>"<CR>
vnoremap <F4> y:%s/<C-r>"//g<Left><Left>
nmap <Leader>f :Files<CR>
nmap <Leader>F :GFiles<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
" Augmenting Ag command using fzf#vim#with_preview function
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--hidden --ignore .git',
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Raw ag to passing arguments
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Auto save
"reload when entering the buffer or gaining focus
au FocusGained,BufEnter * :silent! !
"save when exiting the buffer or losing focus
au FocusLost,WinLeave,BufLeave * :silent! w

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" resize panes
nnoremap <silent> <Right> :vertical resize +3<cr>
nnoremap <silent> <Left> :vertical resize -3<cr>
nnoremap <silent> <UP> :resize +3<cr>
nnoremap <silent> <Down> :resize -3<cr>

" NERDTree
map <CR> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1

" Alignment
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Completeion
let g:SuperTabDefaultCompletionType = "<c-n>"

" Linting
let g:ale_php_phpcs_standard = "WordPress"

" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
map <F6> vip:EasyAlign *,<CR>

let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ ',': { 'pattern': ',',  'left_margin': 0, 'right_margin': 1  },
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\|);\|),\|]',
\     'left_margin':   1,
\     'right_margin':  0,
\   },
\ 'd': {
\     'pattern':      ' \(\S\+\s*[;=]\)\@=',
\     'left_margin':  0,
\     'right_margin': 0
\   },
\ ':': {
\     'pattern':      ':',
\     'left_margin':  0,
\     'right_margin': 1
\   },
\ ': ': {
\     'pattern':      ':',
\     'left_margin':  1,
\     'right_margin': 1
\   },
\ ';': {
\     'pattern':      ');',
\     'left_margin':  1,
\     'right_margin': 0
\   },
\ '?': {
\     'pattern':      '?',
\     'left_margin':  1,
\     'right_margin': 1
\   }
\ }

" Lightline config
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" make Vim figure out the Node's module loading rules 
set suffixesadd+=.js " Import js file without extension.
set path+=$PWD/node_modules

" Do a google search
vnoremap <F5> y<Esc>:Open http://google.com/search?q=<C-r>"<CR>
