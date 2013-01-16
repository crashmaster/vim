" This config file contains settings related to TAB, indent

set expandtab           " Insert spaces instead of tabs
set shiftwidth=4        " Number of spaces used for each step of indent
set tabstop=4           " Number of spaces that a tab in the file counts for
set softtabstop=4
set nostartofline       " Cursor is kept in the same column

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

