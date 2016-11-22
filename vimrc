"Some Basics
set ruler
syntax on
"set cindent

"For Miss Behaviour
set backspace=indent,eol,start
set expandtab
set tabstop=4

"Only those who have been through hell will appreciate this.
command W :w !sudo tee %

"launch off the amazing zeal Doc Viewer
let g:zv_zeal_directory = "/Applications/zeal.app/Contents/MacOS/zeal"

"Whitespace shouldn't be a pain in the arse. Whilst editing others' code
nnoremap <space> i<space><esc>
nnoremap <enter> i<enter><esc>
nnoremap <tab> i<tab><esc>

"For those among us who require that bit of insanity at times
set splitbelow
set splitright
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"For all the wonderful plugins
"set title titlestring=
execute pathogen#infect()
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'vim-ctrlspace/vim-ctrlspace'
set hidden
call vundle#end()
filetype plugin on


"C++ files
autocmd FileType cpp,hpp setlocal expandtab shiftwidth=2 tabstop=2

"C files
autocmd FileType c,h setlocal noexpandtab tabstop=8 "shiftwidth=8 tabstop=8

"makefile
autocmd FileType make setlocal noexpandtab tabstop=8

"====== FROM THE TALK ==========================
"Make the 81st column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"Highlight matches when jumping to next
    " This rewires n and N to do the highlighing
    nnoremap <silent> n   n:call HLNext(0.4)<cr>
    nnoremap <silent> N   N:call HLNext(0.4)<cr>

    function! HLNext (blinktime)
        set invcursorline
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 300) . 'm'
        set invcursorline
        redraw
    endfunction


"Make tabs, trailing whitespace, and non-breaking spaces visible
if (&ft != "c")
    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
"    set list
endif

" Reset title of terminal to full path of open file
" For handling scenario when, vi <file> is already open in a terminal
autocmd BufEnter * let &titlestring = expand("%:p")
set title titlestring=%{expand("%:p")}

"========================== Vundle Plugin =========================
