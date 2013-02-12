function! UpdatePersistencyOptionsForCCView()
    let abs_path = escape(expand('%:p'), '\')
    if IsEnvVarSet($CLEARCASE_ROOT) == 0 || empty(abs_path)
        return
    endif

    let l:top_lvl_dir = split(abs_path, '/')[0]
    let l:opts_vals = {"undodir": "~/.vim/undofiles/"}
    if abs_path =~ $CLEARCASE_ROOT || l:top_lvl_dir == "vobs"
        for i in items(l:opts_vals)
            let l:undo_dir = expand(i[1] . split($CLEARCASE_ROOT, '/')[1])
            if !isdirectory(l:undo_dir) && !mkdir(l:undo_dir, 'p')
                echoerr "failed to create directory: " . l:undo_dir
            endif
            execute "set " . i[0] . "=" . l:undo_dir
        endfor
    else
        for i in items(l:opts_vals)
            let l:undo_dir = expand(i[1])
            " TODO: refactor redundant parts?
            if !isdirectory(l:undo_dir) && !mkdir(l:undo_dir, 'p')
                echoerr "failed to create directory: " . l:undo_dir
            endif
            execute "set " . i[0] . "=" . l:undo_dir
        endfor
    endif
endfunction
