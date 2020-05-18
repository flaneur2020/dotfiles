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
set sw=4
set tabstop=4
" set completeopt-=preview

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
set signcolumn=yes
set laststatus=2
set ruler
set hidden
set showmatch
set list
set listchars=tab:>-     " > is shown at the beginning, - throughout
set scrolloff=4

" cd relative to the current file
autocmd BufEnter * lcd %:p:h

" i don't know how these about
set backspace=indent,eol,start
set nowrap

" no backups
set noswapfile
set nobackup
set nowritebackup

" key bindings
noremap <C-\> :vs<cr>
noremap <UP> gk
noremap <Down> gj
noremap <LEFT> h
noremap <Right> l

au BufNewFile,BufRead *vundle set ft=vim
au BufNewFile,BufRead *tsx set ft=javascript
autocmd FileType ruby,haml,html,jinja,erb,slim,yaml,scss,sass,coffee,treetop,vue set sw=2
autocmd FileType ruby,haml,html,jinja,erb,slim,yaml,scss,sass,coffee,treetop,vue set tabstop=2
autocmd FileType go,java set nolist  " golang 不特殊显示 tab 字符
autocmd FileType markdown set wrap

" trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" PLUGINS

" for NerdTree
let NERDTreeIgnore = ['\env','\.vim$', '\~$', '\.pyc$', '\.o$', '\.swp$', '\.egg-info$', '^dist$', '^build$']
let NERDTreeHightlightCursorline = 1

" for CtrlP
let g:ctrlp_root_markers = ['.ctrlp', '.git']
let g:ctrlp_custom_ignore = {
    \ 'dir': '/venv/\|/tmp/cache/\|/coverage/\|/vendor/\|/eggs/\|/\.egg-info/\|/_site/\|/Godeps/',
    \ 'file': '\.exe$\|\.so$|\.egg$'
    \ }
" ctlp_user_command 这个命令可能导致上面这个 ctrlp_custom_ignore 失效?
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -v "vendor\|venv"']
nnoremap <silent> <Leader>t :CtrlP<CR>

" for go
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

" for lsp
" https://github.com/autozimu/LanguageClient-neovim
let g:LanguageClient_rootMarkers = {
    \ 'go': ['.git', 'go.mod'],
    \ }

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'python': ['pyls'],
    \ 'go': ['gopls'],
    \ 'vue': ['vls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nmap <C-]> gd
noremap <C-t> <C-O>
