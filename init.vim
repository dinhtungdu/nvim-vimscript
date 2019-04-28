" Vim Plug
call plug#begin('~/.local/share/nvim/plugged')
" Editor
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Linting
Plug 'neomake/neomake'
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
" Search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Themes
Plug 'dinhtungdu/ayu-vim'
" Initialize plugin system
call plug#end()

" General
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
nmap <Leader>F :GFiles<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
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
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <UP> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" NERDTree
map <CR> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1

" Alignment
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

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
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>
" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>
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
