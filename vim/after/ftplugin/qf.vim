setlocal colorcolumn=""
setlocal numberwidth=3

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

