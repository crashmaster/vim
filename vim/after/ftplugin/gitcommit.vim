if version >= 703
  set textwidth=72
  set formatoptions-=t
  set colorcolumn=+1
endif

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
