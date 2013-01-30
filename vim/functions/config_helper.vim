" Sources the so-called '.site.vim' config files, in case they exist
function! SourceSiteConfig(scriptPath)
    let l:siteConfFile = a:scriptPath . ".site"
    if filereadable(l:siteConfFile)
        execute "source " . l:siteConfFile
    endif
endfunction

