set nocompatible        " Vim, behave yourself! You aren't Vi! :)

" Loop through the function definition files and source them
for function_file in split(globpath("$HOME/.vim/functions", "*"), "\n")
    execute "source " . function_file
endfor

for config in split(globpath("$HOME/.vim/config", "*.vim"), "\n")
    if config !~? "\.site"
        execute "source " . config
        call SourceSiteConfig(config)
    endif
endfor

