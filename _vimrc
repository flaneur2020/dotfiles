set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
source ~/.vundle
behave mswin

syntax on 
filetype plugin on

"about tab
set autoindent
set smartindent
set smarttab 					
set expandtab

" encoding . utf-8 rules!
" let $LANG="zh_CN.UTF-8" " locales
" set fileencoding=utf-8 " prefer
set ambiwidth=double
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set encoding=utf-8

" misc
set nu
set wildmenu
set wildignore+=*.o,*.obj,.git
set ruler
set tags=./tags,./../tags,./../../tags

" ^c^V i don't know how these about
set laststatus=2
set lbr
set fo+=mB 
set showmatch
set cin
set cino=g0:0t0(sus
set guifont=WenQuanYi\ Micro\ Hei\ Mono
set hls
set backspace=indent,eol,start 
set noswapfile
set shiftround
" set whichwrap=b,s,<,>,[,] 
set bsdir=buffer
set smartcase

set nowrap 
set autoread
set autowrite

" trade off the gnome maximized bug
set showtabline=2

" this may help with NERDTree but bad with FuzzyFinder
" set autochdir
autocmd BufEnter * lcd %:p:h

set noswapfile
set nobackup
set nowritebackup

color molokai

" toolbar sucks
set guioptions=ir

au BufNewFile,BufRead *.tt,*.treetop setf treetop
au BufNewFile,BufRead *.slim set ft=slim 
au BufNewFile,BufRead *.scss set ft=scss 
au BufNewFile,BufRead *.sass set ft=sass 
au BufNewFile,BufRead *.coffee set ft=coffee 
au BufNewFile,BufRead *.md set ft=markdown 
au BufNewFile,BufRead *vundle set ft=vim 
au BufNewFile,BufRead Gemfile,Rakefile,rakefile set ft=ruby 
au BufNewFile,BufRead .bash_aliases set ft=sh 

autocmd filetype * set shiftwidth=4
autocmd filetype * set tabstop=4
autocmd filetype ruby,haml,erb,html,slim,yaml,scss,sass,coffee,treetop,htmldjango set shiftwidth=2
autocmd filetype ruby,haml,erb,html,slim,yaml,scss,sass,coffee,treetop,htmldjango set tabstop=2
autocmd filetype markdown set wrap
" autocmd filetype c,cpp color evening

" key bindings
noremap <c-Right> :tabn<cr>
noremap <c-left>  :tabp<cr>

noremap <C-\> :vs<cr>

" pageup & down is annoying
noremap <PageUp> gk
noremap <PageDown> gj
inoremap <PageUp> <esc>gka
inoremap <PageDown> <esc>gja

" windows
noremap <C-Up> <C-W>k<C-W>_
noremap <C-Down> <C-W>j<C-W>_

" v
noremap <UP> gk
noremap <Down> gj
noremap <LEFT> h
noremap <Right> l
noremap <ESC> v<ESC>

inoremap <C-Backspace> <C-w>

cnoreabbrev qt tabc

"
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" on plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NerdTree
let NERDTreeIgnore = ['\env','\.vim$', '\~$', '\.pyc$', '\.o$', '\.swp$', '\.egg-info$', '^dist$', '^build$']
let NERDTreeSortOrder = ['Makefile', '\/$', '\.py$', '\.rb$', '\.md$', '\.html$', '*', '^test_', '\.swp$', '\~$']
let NERDTreeShowBookmarks = 1
let NERDTreeHightlightCursorline = 1
let NERDTreeDirArrows = 0

" Vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_camel_case = 0
let g:vimwiki_CJK_length = 1
let g:vimwiki_list = [{'path': '~/code/wiki/vimwiki/src/',
                    \ 'path_html': '~/code/wiki/vimwiki/',
                    \ 'html_header': '~/code/wiki/vimwiki/src/tpl/head.tpl',
                    \ 'html_footer': '~/code/wiki/vimwiki/src/tpl/foot.tpl'}
                    \ ]

" minibufexplorer

" FuzzyFinder
let g:fuf_previewHeight=0 

" Command-T
let g:CommandTMatchWindowAtTop=1
nnoremap <silent> <Leader>t :CommandTBuffer<CR>

" for a.vim
noremap <Leader>a :A<cr>

" for taglist
noremap <Leader>s :Tlist<cr>

" for ack.vim
let g:ackprg="ack-grep -H --column"

