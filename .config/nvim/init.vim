"
" Parts of this file were shamelessly copied from Lucas Costa dotfiles repo
" https://github.com/lucasfcosta/dotfiles
" Thanks, @lucasfcosta !!!
"

set encoding=utf-8          " The encoding displayed
set fileencoding=utf-8      " The encoding written to file
syntax on                   " Enable syntax highlight
set ttyfast                 " Faster redrawing
set lazyredraw              " Only redraw when necessary
set cursorline              " Find the current line quickly.
set wrap                    " linebreak

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Install neomake
Plug 'neomake/neomake'

" Install and configure NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" NERDTree on ctrl+n
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeToggle<CR>
" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" Install and configure FZF for fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" make FZF respect gitignore if `ag` is installed
" you will obviously need to install `ag` for this to work
if (executable('ag'))
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif
nnoremap <C-P> :Files<CR>

" Install and configure ale for linting
Plug 'w0rp/ale'
" fix files on save
let g:ale_fix_on_save = 1
" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000
" use nice symbols for errors and warnings
let g:ale_sign_error = '✗\ '
let g:ale_sign_warning = '⚠\ '
" fixer configurations
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" Install and configure emmet-vim
Plug 'mattn/emmet-vim'
" make emmet behave well with JSX in JS and TS files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}

" Install and configure YouCompleteMe for semantic-based completion
" You need Java8, Rust, Cargo (Rust packages), Go, TSServer, Node and NPM installed and in your PATH
" I'll let these lines commented out so we can install on demand
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --java-completer --ts-completer --go-completer --rust-completer' }
" disable auto_triggering ycm suggestions pane and instead
" use semantic completion only on Ctrl+n
"let ycm_trigger_key = '<C-n>'
"let g:ycm_auto_trigger = 0
"let g:ycm_key_invoke_completion = ycm_trigger_key
" this is some arcane magic to allow cycling through the YCM options
" with the same key that opened it.
" See http://vim.wikia.com/wiki/Improve_completion_popup_menu for more info.
"let g:ycm_key_list_select_completion = ['<TAB>', '<C-j>']
"inoremap <expr> ycm_trigger_key pumvisible() ? '"<C-j>'" : ycm_trigger_key;

call plug#end()

" long lines as just one line (have to scroll horizontally)
set nowrap

" line numbers
set relativenumber
set number

" copy and paste to/from vIM and the clipboard
nnoremap <C-y> +y
vnoremap <C-y> +y
nnoremap <C-p> +P
vnoremap <C-p> +P

" access system clipboard
set clipboard=unnamed

" swapfiles location
set backupdir=/tmp//
set directory=/tmp//

" map fzf to ctrl+p
nnoremap <C-P> :Files<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" => Indentation
"""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
" :help smarttab
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Auto indent
" Copy the indentation from the previous line when starting a new line
set ai

" Smart indent
" Automatically inserts one extra level of indentation in some cases, and works for C-like files
set si

"""""""""""""""""""""""""""""""""""""""""""""""
" => Utils (a.k.a. mess I can't categorize)
"""""""""""""""""""""""""""""""""""""""""""""""

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
