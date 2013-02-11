set nocompatible        " Vim, behave yourself! You aren't Vi! :)

" Loop through the function definition files and source them
for function_file in split(globpath("$HOME/.vim/functions", "*"), "\n")
    execute "source " . function_file
endfor

" Loop through the vimrc config files and source them
for config_file in split(globpath("$HOME/.vim/config", "*"), "\n")
    execute "source " . config_file
endfor
