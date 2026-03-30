setlocal textwidth=72
setlocal formatoptions-=t
setlocal colorcolumn=+1

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
