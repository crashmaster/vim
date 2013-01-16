set nocompatible        " Vim should behave like Vim and not like Vi :)

" Loop through the vimrc config files and source them
for conf_file in split(globpath("$HOME/.vim/config", '*'), '\n')
    execute "source " . conf_file
endfor
