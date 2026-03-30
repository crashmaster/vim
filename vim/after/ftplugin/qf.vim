setlocal colorcolumn=
setlocal numberwidth=3
setlocal wrap

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
