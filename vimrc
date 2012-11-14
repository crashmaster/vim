set nocompatible        " Vim should behave like Vim and not like Vi :)
set cpoptions+=$        " Put a '$' at the end of the changed text

set number              " Show line numbers
set numberwidth=6       " Line numbers 6 charaters wide

set hlsearch            " Highlights the last searched pattern
set incsearch           " Search while typing
set ignorecase          " Does not matter if lower or upper case
set smartcase           " Case is ignored unless they are mixed

set history=1000        " Size of the history table of the entered commands

set autoindent          " Copy indent from current line when starting new line
set cindent             " Enables automatic C program indenting
set cinoptions=b1,(0    " Sime fine-tuning for cindent
set nostartofline

set nobackup            " No backup

set nowrap              " Do not break long lines
if version >= 703
  set textwidth=80
  set formatoptions-=t  " Do not auto-wrap text using textwidth
  set formatoptions-=o  " Do not insert automatically the current comment
                        " leader after hitting 'o' or 'O' in Normal mode.
  set colorcolumn=+0
endif

iabbrev teh the
iabbrev wheter whether
