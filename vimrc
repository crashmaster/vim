set nocompatible        " Vim, behave yourself! You aren't Vi! :)

" Loop through the function definition files and source them
for function_file in split(globpath("$HOME/.vim/functions", "*"), "\n")
    execute "source " . function_file
endfor

func Cmp(i1, i2)
    return a:i1 == a:i2 ? 0 : a:i1 > a:i2 ? -1 : 1
endfunc

" Loop through the vimrc config files and source them
for config_file in sort(split(globpath("$HOME/.vim/config", "*"), "\n"), "Cmp")
    execute "source " . config_file
endfor

