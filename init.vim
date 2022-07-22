"""""""""""""""""""""""
" Python Setup
if has("unix")
  let s:uname = system("uname")
  "if has('nvim')
    "let g:python_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
    "let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
  "else
  let g:python_host_prog = '/usr/bin/python'
  "endif
endif
"

"""""""""""""""""""""""
" vim-plug Setup
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Helper for conditional evaluation of plugin loading
" See: https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-endwise'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
 Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/vim-easy-align'
" Plug 'nacitar/terminalkeys.vim'
 Plug 'schickling/vim-bufonly'
 Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'FooSoft/vim-argwrap'
Plug 'mg979/vim-visual-multi'
Plug 'mileszs/ack.vim'
" CSV Plugin: https://github.com/chrisbra/csv.vim
Plug 'chrisbra/csv.vim'
" Nord theme: https://github.com/arcticicestudio/nord-vim
Plug 'arcticicestudio/nord-vim'
if has('nvim')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
  " Markdown preview plugin: https://github.com/iamcco/markdown-preview.nvim
  " Assumes yarn and node are present on the system
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
endif
if !has('nvim')
  Plug 'drmikehenry/vim-fixkey'
  " This technically works, but I don't want deoplete if I'm outside neovim
  " right now
  " Plug 'Shougo/deoplete.nvim'
  " Plug 'roxma/nvim-yarp'
  " Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()

""""""""""""""""""""""
" Basic configuration
"
set nocp          " Disable vi compatibility, for vim-specific awesomeness
set expandtab     " Expand tabs to spaces
set tabstop=2
set bs=2          " Fix backspace key to work under screen
set shiftwidth=2
set number        " Enable line numbering
set ruler	  " show where you are
" set relativenumber " Enable relative line numbering for easier jump calculations
set autoindent    " When you press enter you stay at the current indent
set autoread	  " reload files when changed on disk, i.e. via `git checkout`
set wildmode=longest,list " Better tab completion for :e and friends
set wildignore=*.rbc,.git,*.o,*.gem
set history=100   " Default is 20, not enough.
set ls=2          " Always display a status line
set complete=.,w,b,u,t,i,kspell
set ignorecase	  " case-insensitive search
set incsearch	  " search as you type
set smartcase	  " case-insensitive search if any caps
set list          " show trailing whitespace
set listchars=tab:▸\ ,trail:▫

set visualbell     " Use visual bell instead of beeping.
set shortmess=atI  " short info tokens, short command line messages, no intro.
set modelines=0    " Disable modelines; not used, risk of security exploits.
set encoding=utf-8 " Default to Unicode/UTF-8 rather than latin1
set ttyfast        " Terminals are plenty fast these days.

set winwidth=81    " Ideal minimum window width of 80 chars

set clipboard=unnamed " Allow clipboard sharing with OS X. See: http://stackoverflow.com/a/680271/259811

set gfn=Monofur:h14

set mouse=a

" noremap ; :

" Comma as leader
let mapleader=","
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap jj <ESC>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <silent> <leader>A :ArgWrap<CR>

" I am too old to relearn that Y copies from cursor position to the end of the line
" I need it to copy the entire line into the butter
" if has('nvim')
"  nnoremap Y Y
" endif

syntax on

filetype plugin indent on
filetype plugin on

" Store temporary files in a central spot
set backup
set backupdir=~/.vim/tmp,~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Persist undo for every edit session
set undofile
set undodir=~/.vim/undo
set undolevels=10000

""""""""""""""""
" PRETTY COLORS
"
if has("gui_running")
  set guioptions=egmrt
endif

" Jun 13 2022 -- probably don't need this any more
" See: https://stackoverflow.com/questions/15375992/vim-difference-between-t-co-256-and-term-xterm-256color-in-conjunction-with-tmu
" set t_Co=256

set background=dark
colorscheme nord

" call togglebg#map("<F3>")

" Bind tab to shift between buffers
" nmap <tab> :bn<cr>
" nmap <s-tab> :bp<cr>

" function! RenameFile()
"     let old_name = expand('%')
"     let new_name = input('New file name: ', expand('%'), 'file')
"     if new_name != '' && new_name != old_name
"         exec ':saveas ' . new_name
"         exec ':silent !rm ' . old_name
"         redraw!
"     endif
" endfunction
" map <leader>n :call RenameFile()<cr>

"""""""""""""""""""""""""""""
" HIGHLIGHTING AND FILE TYPES
"

" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/

augroup vimrcEx
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

  " Auto reload this file when editing it
  " au! BufWritePost .vimrc source %

  " Add rails filetype to all ruby files, need to find a way to limit to just rails files maybe
  au BufRead,BufNewFile *.rb set filetype=ruby.rails.rspec
  au BufRead,BufNewFile Isolate set filetype=ruby
  au BufRead,BufNewFile config.ru set filetype=ruby
  au BufRead,BufNewFile *.pp set filetype=ruby

  " Vagrantfiles are Ruby
  au BufRead,BufNewFile Vagrantfile set filetype=ruby

  " Override default modula2 detection, these files are markdown
  au BufNewFile,BufRead *.md set filetype=markdown

  " Don't leave insert mode when I tab away
  " This doesn't work: au BufEnter * :startinsert

  " C style for ruby codes
  au FileType c setl ts=4 sw=4 noexpandtab

  " Exit insert mode when Vim loses focus.
  " A bug prevents this from working: autocmd FocusLost * stopinsert
  " See http://stackoverflow.com/questions/2968548
  autocmd! FocusLost * call feedkeys("\<C-\>\<C-n>")

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

augroup END

"""""""""""""""""""""""
" Airline Configuration
"
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show the buffer number too
let g:airline#extensions#tabline#buffer_nr_show = 1
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

""""""""""""""""""""""""""""""""""""""
" Working with Buffers Instead of Tabs
" See: https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :Sayonara

" Close all OTHER buffers except the current buffer
nmap <leader>bo :BufOnly<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

"""""""""""""""""""""""""""
" NERDTree Configuration
" Show hidden files by default
let NERDTreeShowHidden=1

" Toggle with Ctrl-n
map <C-n> :NERDTreeToggle<CR>

" Close vim if the only thing left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" NERDTree close on open file
let NERDTreeQuitOnOpen=1

" NERDTree ignore
let g:NERDTreeIgnore=['node_modules$[[dir]]', '\.DS_Store$', '.git$[[dir]]', '.next$[[dir]]', '.*\.egg-info$[[dir]]', '\.eggs$[[dir]]', '\.pytest_cache$[[dir]]', '^bazel-.*$[[dir]]']


"""""""""""""""""""""""""""
" Buffergator Configuration
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>


" Make arrow keys work in tmux sessions
if &term =~ '256color'
  set t_ut=
endif

"""""""""""""""""""""""""""
" Markdown Configuration
" Don't automatically fold everything when opening a Markdown doc
" let g:vim_markdown_folding_disabled=1

"""""""""""""""""""""""""""
" MarkdownPreview Configuration
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0
" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1
" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0
" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

"""""""""""""""""""""""""""
" Easy Align Configuration
" From: https://github.com/junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" deoplete configuration
let g:deoplete#enable_at_startup = 1
" Use tab-complete to navigate completions
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" fzf configuration
" This is a wild noremap for me! I've been use ; for : for a long time
" so let's see if this trips me up or makes me superhuman.
" nmap ; :Buffers<CR>
" Search files like the old CTRL-P plugin used to do
" nmap <Leader>p :Files<CR>
set runtimepath+=/usr/local/opt/fzf
nmap <C-p> :FZF<cr>
nmap <leader>p :FZF<cr>
let g:fzf_layout = { 'down': '~30%' }

" Use ripgrep for grep
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

""""""""""""""""""""""""""""""""
" Ack Configuration
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1
cnoreabbrev Ack Ack!
nnoremap <leader>/ :Ack!<Space>

""""""""""""""""""""""""""""""""
" ALE Configuration
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
" Use ALE and also some plugin 'foobar' as completion sources for all code.
" call deoplete#custom#option('sources', {
" \ '_': ['ale'],
" \})
" How can I show errors or warnings in my statusline?
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
" Use <leader>a(j|k) to jump between errors
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

""""""""""""""""""""""""""""""""
" DelimitMate Configuration
" let g:delimitMate_autoclose=1
let g:delimitMate_jump_expansion=1
let g:delimitMate_expand_space=1
let g:delimitMate_expand_cr=2
let g:delimitMate_expand_inside_quotes=1
let g:delimitMate_balance_matchpairs=0

""""""""""""""""""""""""""""""""
" Sayonara Configuration
" Sayonara behavior on certain file types
let g:sayonara_filetypes={ 'nerdtree': 'NERDTreeClose' }

""""""""""""""""""""""""""""""""
" Black Configuration
let g:black_linelength = 100
" To run Black on save...
" autocmd BufWritePre *.py execute ':Black'
