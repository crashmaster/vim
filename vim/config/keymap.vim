" This config file contains settings related to key mappings.

" Switch buffer back and forth:
nnoremap <leader><leader> :b#<CR>

" Search for the text under to cursos till the end of line
nnoremap <silent><leader>z :SelectRobotKeyword<CR>

" Toggel spell checker
nnoremap <silent><leader>a :set spell!<CR>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Make Y behave like other capitals
map Y y$

" Clear search highlights
noremap <silent><leader>/ :nohls<CR>
