setlocal shiftwidth=2        " 2 spaces are used for each step of indent
setlocal tabstop=2           " TAB counts for 2 spaces in the file
setlocal softtabstop=2
setlocal autoindent          " Copy indent from current line when starting a new one
setlocal cindent             " Enables automatic C program indenting
setlocal cinoptions=(0       " Some fine-tuning for cindent
setlocal textwidth=79
setlocal formatoptions-=t
setlocal colorcolumn=+1

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif
