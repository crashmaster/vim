setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal smarttab
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

if version >= 703
  set textwidth=79
  set formatoptions-=t
  set colorcolumn=+1
endif

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

