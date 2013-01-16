" This config file contains user defined functions, needs to be sourced
" early, as other settings may depend on it

" When called, TAB-s became visible as 'T'-s
function! SeeTabs()
  set listchars=tab:\T\ 
endfunction
command! -nargs=0 SeeTabs :call SeeTabs()

" When called, TAB-s will be hidden
function! HideTabs()
  set listchars=trail:-
endfunction
command! -nargs=0 HideTabs :call HideTabs()

" Sources the so-called '.site' config files, in case they exist
function! SourceSiteConfig(scriptPath)
    let l:siteConfFile = a:scriptPath . ".site"
    if filereadable(l:siteConfFile)
        execute "source " . l:siteConfFile
    endif
endfunction

