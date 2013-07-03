setlocal colorcolumn=""
setlocal numberwidth=3
set wrap

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

