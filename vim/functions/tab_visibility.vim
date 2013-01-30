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

