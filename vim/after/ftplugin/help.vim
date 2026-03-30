setlocal colorcolumn=   " Disable vertical textwidth margin.

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
