setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal smarttab
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal textwidth=79
setlocal formatoptions-=t
setlocal colorcolumn=+1

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
