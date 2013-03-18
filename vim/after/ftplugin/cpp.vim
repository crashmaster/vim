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

" Open the completion pop up with <TAB>
let g:SuperTabDefaultCompletionType = "context"

" Some clang complete options:
let g:clang_complete_auto = 0
let g:clang_library_path = ""       " g:clang_library_path is site specific
let g:clang_use_library = 1
let g:clang_complete_copen = 1
let g:clang_hl_errors = 1
let g:clang_periodic_quickfix = 1   " Do not update QF periodically
let g:clang_user_options = "-Wall"
let g:clang_snippets = 0

set updatetime=1700

" Toggle QF update
nnoremap <silent> <F8> :call g:ClangUpdateQuickFix()<CR>

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

