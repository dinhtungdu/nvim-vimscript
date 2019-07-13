" Vim Plug
call plug#begin('~/.local/share/nvim/plugged')
" Editor
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'
" Linting
Plug 'w0rp/ale', { 'on':  'ALEToggle' } 
" Alignment
Plug 'junegunn/vim-easy-align'
" Completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Syntax
Plug 'sheerun/vim-polyglot'
"Plug 'Raimondi/delimitMate'
" Comment
Plug 'scrooloose/nerdcommenter'
" Search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Themes
Plug 'dinhtungdu/ayu-vim'
" Debugging
Plug 'vim-vdebug/vdebug'
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
set guicursor=

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
nnoremap <F3> yiw/<C-r>"<CR>
nnoremap <F4> yiw:%s/<C-r>"//g<Left><Left>
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

" Linting
let g:ale_php_phpcs_standard = "WordPress"

" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
map <F6> vip:EasyAlign *,<CR>

let g:easy_align_delimiters = {
\ ' ': { 'pattern': ' ',  'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ '=': { 'pattern': '===\|<=>\|\(&&\|||\|<<\|>>\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.-]\?=[#?]\?',
\                         'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ ':': { 'pattern': ':',  'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 },
\ ',': { 'pattern': ',',  'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 },
\ '|': { 'pattern': '|',  'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '.': { 'pattern': '\.', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ '#': { 'pattern': '#\+', 'delimiter_align': 'l', 'ignore_groups': ['!Comment']  },
\ '&': { 'pattern': '\\\@<!&\|\\\\',
\                         'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '{': { 'pattern': '(\@<!{',
\                         'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '}': { 'pattern': '}',  'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': { 'pattern': '[[\]]', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ ')': { 'pattern': ')\|);\|),\|]', 'left_margin': 1, 'right_margin': 0, },
\ 'd': { 'pattern': ' \(\S\+\s*[;=]\)\@=', 'left_margin': 0, 'right_margin': 0 },
\ ';': { 'pattern': ');', 'left_margin': 1, 'right_margin': 0 },
\ '?': { 'pattern': '?', 'left_margin': 1, 'right_margin': 1 }
\ }

" Coc config starts ================

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2
set shortmess=aFc

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set completeopt+=preview

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Coc config ends ==================

" Lightline config
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" make Vim figure out the Node's module loading rules 
set suffixesadd+=.js " Import js file without extension.
set path+=$PWD/node_modules

" Do a google search
vnoremap <Leader>g y<Esc>:Open http://google.com/search?q=<C-r>"<CR>

" Echo Git blame information
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" Large file support
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" Debugging config
let g:vdebug_options= {
\    "port" : 9000,
\    "server" : '',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 0,
\    "ide_key" : '',
\    "path_maps" : {
\    },
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'compact',
\    "marker_default"     : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}
