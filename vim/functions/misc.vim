function! SeeTabs()
  set listchars=tab:\T\ 
endfunction
command! -nargs=0 SeeTabs :call SeeTabs()

function! HideTabs()
  set listchars=trail:-
endfunction
command! -nargs=0 HideTabs :call HideTabs()

function! SourceSiteConfig(scriptPath)
    if filereadable(a:scriptPath)
        execute "source " . a:scriptPath . ".site"
    endif
endfunction


