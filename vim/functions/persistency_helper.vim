function! UpdatePersistencyOptionsForCCView()
    if !exists("g:pers_opts") || empty(g:pers_opts)
        return
    endif

    let l:abs_path = escape(expand('%:p'), '\')

    if !IsEnvVarSet($CLEARCASE_ROOT) && l:abs_path =~ "/view/"
        let l:view_name = split(l:abs_path, '/')[1]
        for i in items(g:pers_opts)
            let l:tmp_dir = expand(i[1] . l:view_name)
            if !isdirectory(l:tmp_dir) && !mkdir(l:tmp_dir, 'p')
                echoerr "failed to create directory: " . l:tmp_dir
            endif
            execute "set " . i[0] . "=" . l:tmp_dir
        endfor
    elseif IsEnvVarSet($CLEARCASE_ROOT) && l:abs_path =~ "/vobs/gdb/cudb/"
        let l:view_name = split($CLEARCASE_ROOT, '/')[1]
        for i in items(g:pers_opts)
            let l:tmp_dir = expand(i[1] . l:view_name)
            if !isdirectory(l:tmp_dir) && !mkdir(l:tmp_dir, 'p')
                echoerr "failed to create directory: " . l:tmp_dir
            endif
            execute "set " . i[0] . "=" . l:tmp_dir
        endfor
    else
        for i in items(g:pers_opts)
            execute "set " . i[0] . "=" . i[1]
        endfor
    endif
endfunction

