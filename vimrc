set nocompatible        " Vim, behave yourself! You aren't Vi! :)

" Loop through the function definition files and source them
for function_file in split(globpath("$HOME/.vim/functions", "*"), "\n")
    execute "source " . function_file
endfor

" TODO: use functions (try_to_source_site_vim_of(config)) for better
" readability
for config in split(globpath("$HOME/.vim/config", "*.vim"), "\n")
    if config !~? "\.site"
        execute "source " . config
        let site = strpart(config, 0, match(config, '\.vim$')) . ".site.vim"
        if filereadable(site)
            execute "source " . site
        endif
    endif
endfor

