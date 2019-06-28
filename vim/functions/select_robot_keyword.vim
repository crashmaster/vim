function! SelectRobotKeyword()
    let line = strpart(getline("."), col(".")-1)
    let @/ = line
    set hlsearch
    call histadd("/", line)
endfunction
command! -nargs=0 SelectRobotKeyword :call SelectRobotKeyword()

