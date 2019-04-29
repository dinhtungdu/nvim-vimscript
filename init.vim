" Vim Plug
call plug#begin('~/.local/share/nvim/plugged')
" Editor
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'itchyny/lightline.vim'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Linting
Plug 'w0rp/ale'
" PHP-specific integration
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'phpactor/ncm2-phpactor'
" Alignment
Plug 'junegunn/vim-easy-align'
" Syntax
Plug 'sheerun/vim-polyglot'
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
set expandtab
set shiftwidth=2
set smarttab

" Search and replace
vnoremap // y/<C-R>"<CR>
vnoremap <F3> y/<C-r>"<CR>
vnoremap <F4> y:%s/<C-r>"//g<Left><Left>
nmap <Leader>f :Files<CR>
nmap <Leader>F :Ag<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
" Augmenting Ag command using fzf#vim#with_preview function
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--hidden --ignore .git -g ""',
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

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
nnoremap <silent> <Right> :vertical resize +1<cr>
nnoremap <silent> <Left> :vertical resize -1<cr>
nnoremap <silent> <UP> :resize +1<cr>
nnoremap <silent> <Down> :resize -1<cr>

" NERDTree
map <CR> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1

" Alignment
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Linting
let g:ale_php_phpcs_standard = "WordPress"
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_detail)

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

" Completion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set ofu=syntaxcomplete#Complete
autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorOmniError = v:true
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" PHPActor config
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>
" Invoke the context menu
nmap <Leader>m :call phpactor#ContextMenu()<CR>
" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>
" Goto definition of class or class member under the cursor
nmap <Leader>g :call phpactor#GotoDefinition()<CR>
" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>
" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>
" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
