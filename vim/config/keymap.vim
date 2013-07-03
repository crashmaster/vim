" This config file contains settings related to key mappings.

" Switch buffer back and forth:
nnoremap <leader><leader> :b#<CR>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Make Y behave like other capitals
map Y y$

" Clear search highlights
noremap <silent><Leader>/ :nohls<CR>
