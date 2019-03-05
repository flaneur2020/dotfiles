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

" misc
set nu
set wildmenu
set wildignore+=*.o,*.obj,.git,*.pyc,*/venv/*
set ruler
set tags=./tags,./../tags,./../../tags
set hidden
set list
set listchars=tab:>-     " > is shown at the beginning, - throughout

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
    \ 'dir': '/venv/\|/tmp/cache/\|/coverage/\|/vendor/\|/eggs/\|/\.egg-info/\|/_site/\|/_workspace/\|/Godeps/',
    \ 'file': '\.exe$\|\.so$|\.egg$'
    \ }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
nnoremap <silent> <Leader>t :CtrlP<CR>
nnoremap <D-p> :CtrlP<CR>
nnoremap <M-p> :CtrlP<CR>

" for deoplete
let g:deoplete#enable_at_startup = 1

" for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%F
set statusline+=%*
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=1
let g:syntastic_aggregate_errors=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_ballons=has('ballon_eval')
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_jump=1
" let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=3
let g:syntastic_ignore_files = ['^/usr/', '*node_modules*', '*vendor*', '*build*', '*LOCAL*', '*BASE', '*REMOTE*']
let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_javascript_checkers=['jshint', 'jscs']
let g:syntastic_json_checkers=['jsonlint', 'jsonval']
let g:syntastic_ruby_checkers=['rubocop', 'mri']
let g:syntastic_perl_checkers=['perl', 'perlcritic', 'podchecker']
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_cpp_checkers=['gcc', 'cppcheck', 'cpplint', 'ycm', 'clang_tidy', 'clang_check']
let g:syntastic_c_checkers=['gcc', 'make', 'cppcheck', 'clang_tidy', 'clang_check']
let g:syntastic_haml_checkers=['haml_lint', 'haml']
let g:syntastic_html_checkers=['jshint']
let g:syntastic_yaml_checkers=['jsyaml']
let g:syntastic_sh_checkers=['sh', 'shellcheck', 'checkbashisms']
let g:syntastic_vim_checkers=['vimlint']
let g:syntastic_enable_perl_checker=1
let g:syntastic_c_clang_tidy_sort=1
let g:syntastic_c_clang_check_sort=1
let g:syntastic_c_remove_include_errors=1
let g:syntastic_quiet_messages = { "level": "[]", "file": ['*_LOCAL_*', '*_BASE_*', '*_REMOTE_*']  }
let g:syntastic_stl_format = '[%E{E: %fe #%e}%B{, }%W{W: %fw #%w}]'
let g:syntastic_java_javac_options = "-g:none -source 8 -Xmaxerrs 5 -Xmaswarns 5"

let g:godef_split = 0
let g:go_fmt_fail_silently = 1
let g:go_list_type = 'quickfix'
let g:syntastic_go_checkers = ['golint', 'govet', 'gofmt']
let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']

" for lsp
" https://github.com/autozimu/LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'go': ['go-langserver', '-gocodecompletion'],
    \ 'python': ['pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nmap <C-]> gd
noremap <C-t> :bp<CR>
