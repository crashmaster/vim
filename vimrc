set nocompatible        " Vim should behave like Vim and not like Vi :)
set cpoptions+=$        " Put a '$' at the end of the changed text

set number              " Show line numbers
set numberwidth=6       " Line numbers 6 charaters wide

set hlsearch            " Highlights the last searched pattern
set incsearch           " Search while typing
set ignorecase          " Does not matter if lower or upper case
set smartcase           " Case is ignored unless they are mixed

set history=5000        " Size of the history table of the entered commands

set nostartofline

set expandtab           " Insert spaces instead of tabs
set shiftwidth=4        " Number of spaces used for each step of indent
set tabstop=4           " Number of spaces that a tab in the file counts for
set softtabstop=4

set autowriteall!       " Inverse of autowriteall
set nobackup            " No backup
set hidden              " Do not unload buffer, when abandoned

set backspace=indent,eol,start

set showcmd
set nowrap              " Do not break long lines
set diffopt=context:777 " Show lots of context in diff mode

set completeopt=menu,menuone,longest " Show no preview window
set pumheight=20        " Pop up menu has maximal 20 rows

if version >= 703
    set textwidth=80
    set formatoptions-=t    " Do not auto-wrap text using textwidth
    set formatoptions-=o    " Do not insert automatically the current comment
                            " leader after hitting 'o' or 'O' in Normal mode.
    set colorcolumn=+0
endif

filetype plugin indent on
syntax on
" Set status line to fg: white and bg: none, independent from the color scheme
hi StatusLine ctermfg=white ctermbg=none

set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}%=line:%l/%L\ col:%c%V\ ascii:%b\ %P
hi StatusLine ctermfg=white ctermbg=none
if version >= 700
  au InsertEnter * hi StatusLine ctermbg=1
  au InsertLeave * hi StatusLine ctermfg=white ctermbg=none
endif

set list
set listchars=trail:-

fu! SeeTabs()
  set listchars=tab:\T\ 
endfunc
com! -nargs=0 SeeTabs :call SeeTabs()

fu! HideTabs()
  set listchars=trail:-
endfunc
com! -nargs=0 HideTabs :call HideTabs()

" Some useful insert mode only abbreviations
iabbrev teh the
iabbrev Teh The
iabbrev wheter whether
iabbrev Wheter Whether
iabbrev thsi this
iabbrev Thsi This

" Some shortcuts

" Switch buffer back and forth
nnoremap <F3> :b#<CR>
