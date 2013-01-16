" This config file contains settings related to key mapping

" Switch buffer back and forth
nnoremap <F3> :b#<CR>

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

