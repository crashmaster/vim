" This config file contains settings related to keeping (or not keeping) data
" of any kind.

set history=5000        " Size of the history table of the entered commands

set noswapfile          " No swap file, what could go wrong? :)
set nobackup            " No backup
set writebackup         " Do not make a backup before overwriting a file

" If persistent undo is available, then use it. This is the only way I could
" figure out for keeping the undo information, when switching buffers.
" NOTE: When unloading a buffer Vim normally destroys the tree of undos created
" for that buffer.
" The other way would be using the hidden option, but that has some drawbacks.
" NOTE: undo files are never deleted by Vim. You need to delete them yourself.
if has("persistent_undo")
    set undodir=~/.vim/undofiles/
    set undofile
    set autowriteall
else
    set hidden          " Do not unload buffer, when abandoned
endif

