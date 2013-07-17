set nocompatible        " Vim, behave yourself! You aren't Vi! :)

" Loop through the function definition files and source them
for function_file in split(globpath("$HOME/.vim/functions", "*"), "\n")
    execute "source " . function_file
endfor

let s:non_site_config_files = []
for i in sort(split(globpath("$HOME/.vim/config", "*.vim"), "\n"))
    if i !~? "\.site"
        call add(s:non_site_config_files, i)
    endif
endfor

for i in s:non_site_config_files
    execute "source " . i
    let tmp = strpart(i, 0, match(i, '\.vim$')) . ".site.vim"
    if filereadable(tmp)
        execute "source " . tmp
    endif
endfor
