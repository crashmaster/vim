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

set backspace=indent,eol,start

set showcmd
set nowrap              " Do not break long lines

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

set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}%=line:%l/%L\ col:%c%V\ ascii:%b\ %P
hi StatusLine ctermfg=white ctermbg=none
if version >= 700
  au InsertEnter * hi StatusLine ctermbg=1
  au InsertLeave * hi StatusLine ctermfg=white ctermbg=none
endif

set list
set listchars=trail:-

iabbrev teh the
iabbrev wheter whether

nnoremap <F3> :b#<CR>
