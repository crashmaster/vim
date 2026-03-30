setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal smarttab
setlocal textwidth=79
setlocal formatoptions-=t
setlocal colorcolumn=+1

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
