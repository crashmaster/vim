setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal smarttab

if version >= 703
  set textwidth=79
  set formatoptions-=t
  set colorcolumn=+1
endif

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
