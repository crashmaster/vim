setlocal shiftwidth=2        " 2 spaces are used for each step of indent
setlocal tabstop=2           " TAB counts for 2 spaces in the file
setlocal softtabstop=2
setlocal autoindent          " Copy indent from current line when starting a new one
setlocal cindent             " Enables automatic C program indenting
setlocal cinoptions=b1,(0    " Some fine-tuning for cindent

if version >= 703
  set textwidth=99
  set formatoptions-=t
  set colorcolumn=+1
endif

" Some shortcuts:
" In these shortcuts the space added by the abbreviation mechanism is
" useful, so there is no need to eat it up
iabbrev forui for (unsigned int i(0); i <; ++i)<CR>{<CR>}<ESC>2k02f;i
iabbrev fori for (int i(0); i <; ++i)<CR>{<CR>}<ESC>2k02f;i
iabbrev sout std::cout << << std::endl;<ESC>2F i
iabbrev serr std::cerr << << std::endl;<ESC>2F i
iabbrev slog std::clog << << std::endl;<ESC>2F i
iabbrev class class<CR>{<CR>};<ESC>2kA
iabbrev struct struct<CR>{<CR>};<ESC>2kA
iabbrev comm /**<CR><CR>/<UP>
" <c-o> temporary normal mode for 1 command in the insert mode :-)
" This trick is used for eating up the superfluous space.
iabbrev incl #include <%><ESC>F%s<c-o>:call getchar()<CR>

" Open the completion pop up with <TAB>
let g:SuperTabDefaultCompletionType = "context"

" Some clang complete options:
let g:clang_complete_auto = 0
let g:clang_library_path = ""       " g:clang_library_path is site specific
let g:clang_use_library = 1
let g:clang_complete_copen = 1
let g:clang_hl_errors = 0
let g:clang_periodic_quickfix = 0   " Do not update QF periodically
let g:clang_user_options = "-Wall"

" Toggle QF update
nnoremap <silent> <F8> :call g:ClangUpdateQuickFix()<CR>

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

