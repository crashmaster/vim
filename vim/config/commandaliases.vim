" Handle quit related typos
command! -nargs=0 QA qa
command! -nargs=0 Qa qa
command! -nargs=0 WQA wqa
command! -nargs=0 WQa wqa
command! -nargs=0 Wqa wqa
command! -nargs=0 WQ wq
command! -nargs=0 Wq wq
command! -nargs=0 WA wa
command! -nargs=0 Wa wa
command! -nargs=0 W w

" Handle buffer-change related typos
command! -nargs=0 Bn bn
command! -nargs=0 BN bn
command! -nargs=0 Bp bp
command! -nargs=0 BP bp

" Special case
silent! cnoreabbrev B# b#
