set nocompatible
" source $VIMRUNTIME/mswin.vim
source ~/.vundle
behave mswin

syntax on
filetype plugin on

" about tab
set autoindent
set smartindent
set smarttab
set expandtab
set completeopt-=preview

" encoding: utf-8
set ambiwidth=double
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set encoding=utf-8

" colors
if !has("nvim")
  set term=screen-256color
end
set t_Co=256
color molokai

" status lines & columns
set nu
set signcolumn=no
set wildmenu
set wildignore+=*.o,*.obj,.git,*.pyc,*/venv/*,*/vendor
set ruler
set hidden
set list
set listchars=tab:>-     " > is shown at the beginning, - throughout
set statusline+=%#warningmsg#
set statusline+=%F
set statusline+=%*

" cd relative to the current file
autocmd BufEnter * lcd %:p:h

" i don't know how these about
set laststatus=2
set scrolloff=4
set lbr
set fo+=mB
set showmatch
set cin
set cino=g0:0t0(sus
" set guifont=WenQuanYi\ Micro\ Hei\ Mono
set hls
set backspace=indent,eol,start
set shiftround
" set whichwrap=b,s,<,>,[,]
set bsdir=buffer
set smartcase
set nowrap
set autoread
set autowrite

" no backups
set noswapfile
set nobackup
set nowritebackup

" key bindings
noremap <C-\> :vs<cr>
inoremap <PageUp> <esc>gka
inoremap <PageDown> <esc>gja
noremap <UP> gk
noremap <Down> gj
noremap <LEFT> h
noremap <Right> l
inoremap <C-Backspace> <C-w>

" high light the cursorline
if !has('gui_running')
  au InsertEnter * set cursorline
  au InsertLeave * set nocursorline
endif

" high light the active window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * silent! set colorcolumn=80
  autocmd WinLeave * silent! set colorcolumn=0
augroup END

" ft
au BufNewFile,BufRead *.tt,*.treetop setf treetop
au BufNewFile,BufRead *.slim set ft=slim
au BufNewFile,BufRead *.scss set ft=scss
au BufNewFile,BufRead *.sass set ft=sass
au BufNewFile,BufRead *.sls set ft=yaml
au BufNewFile,BufRead *.coffee set ft=coffee
au BufNewFile,BufRead *.md set ft=markdown
au BufNewFile,BufRead *vundle set ft=vim
au BufNewFile,BufRead Gemfile,Rakefile,rakefile set ft=ruby
au BufNewFile,BufRead .bash_aliases set ft=sh
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au BufRead,BufNewFile *.avdl setlocal filetype=avro-idl
autocmd FileType * set shiftwidth=4
autocmd FileType * set tabstop=4
autocmd FileType ruby,haml,html,jinja,erb,slim,yaml,scss,sass,coffee,treetop,vue set shiftwidth=2
autocmd FileType ruby,haml,html,jinja,erb,slim,yaml,scss,sass,coffee,treetop,vue set tabstop=2
autocmd FileType python set suffixesadd=
autocmd FileType go,java set nolist  " golang 不特殊显示 tab 字符
autocmd FileType markdown set wrap

" trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" change the annoying paren match
hi MatchParen cterm=bold ctermbg=none ctermfg=none

" on plugins;;;

" NerdTree
let NERDTreeIgnore = ['\env','\.vim$', '\~$', '\.pyc$', '\.o$', '\.swp$', '\.egg-info$', '^dist$', '^build$']
let NERDTreeSortOrder = ['Makefile', '\/$', '\.py$', '\.rb$', '\.md$', '\.html$', '*', '^test_', '\.swp$', '\~$']
let NERDTreeHightlightCursorline = 1
let NERDTreeDirArrows = 0

" CtrlP
let g:ctrlp_root_markers = ['.ctrlp', '.git']
let g:ctrlp_custom_ignore = {
    \ 'dir': '/venv/\|/tmp/cache/\|/coverage/\|/vendor/\|/eggs/\|/\.egg-info/\|/_site/\|/Godeps/',
    \ 'file': '\.exe$\|\.so$|\.egg$'
    \ }
" ctlp_user_command 这个命令可能导致上面这个 ctrlp_custom_ignore 失效?
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -v "vendor\|venv"']
nnoremap <silent> <Leader>t :CtrlP<CR>
nnoremap <D-p> :CtrlP<CR>
nnoremap <M-p> :CtrlP<CR>

" for deoplete
let g:deoplete#enable_at_startup = 1

" for go
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
" autocmd BufWritePost *.go :%! goimports
autocmd BufWritePost *.go :GoImports


" autocmd BufWritePost *.go :GoImports

" for lsp
" https://github.com/autozimu/LanguageClient-neovim
" go get -u github.com/saibing/bingo
let g:LanguageClient_rootMarkers = {
    \ 'go': ['.git', 'go.mod'],
    \ }
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ 'python': ['pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nmap <C-]> gd
noremap <C-t> <C-O>
