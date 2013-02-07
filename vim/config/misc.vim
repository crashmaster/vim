" This config file contains settings related to no specific area, too general
" or just too simple for putting it into a separate file

set history=5000        " Size of the history table of the entered commands

" Each item allows a way to backspace over something:
"   indent      -> allow backspacing over autoindent
"   eol         -> allow backspacing over line breaks (join lines)
"   start       -> allow backspacing over the start of insert
set backspace=indent,eol,start

filetype plugin on      " Enabled loading of plugin files
filetype indent on      " Enabled loading of indent files

set noswapfile          " No swap file, what could go wrong? :)
set nobackup            " No backup
set writebackup         " Do not make a backup before overwriting a file
set hidden              " Do not unload buffer, when abandoned

set ffs=unix,dos,mac    " end-of-line formats that will be tried

set diffopt=context:777 " Show lots of context in diff mode
set diffopt+=iwhite     " Ignore white space charactes in diff

