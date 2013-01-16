" This config file contains settings related to searching

set hlsearch            " Highlights the last searched pattern
set incsearch           " Search while typing
set ignorecase          " Does not matter if lower or upper case
set smartcase           " Case is ignored unless they are mixed

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

