setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal smarttab
setlocal formatoptions-=t
setlocal colorcolumn=

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
