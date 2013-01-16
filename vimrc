set nocompatible        " Vim, behave yourself! You aren't Vi! :)

" Loop through the vimrc config files and source them
for conf_file in split(globpath("$HOME/.vim/config", '*'), '\n')
    execute "source " . conf_file
endfor
