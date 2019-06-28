" This config file contains settings related to the editor's look.

syntax on               " Syntax highlighting, Vim overrules settings
autocmd BufEnter * :syntax sync fromstart

set number              " Show line numbers
set numberwidth=6       " Line numbers 6 charaters wide
set relativenumber      " Show line numbers relative to the cursor

set showcmd             " Show (partial) command in the last line of the screen
set nowrap              " Do not break long lines

" A comma separated list of options for insert mode completion:
"    menu       -> use a popup menu to show the possible completions
"    menuone    -> use the popup menu also when there is only one match
"    longest    -> only insert the longest common text of the matches
"    preview    -> show extra information in the preview window (OMITTED)
set completeopt=menu,menuone,longest
set pumheight=20        " Pop up menu has maximal 20 rows

if version >= 703
  set textwidth=80      " Maximum width of text that is being inserted
  set formatoptions-=t  " Do not auto-wrap text using textwidth
  set formatoptions-=o  " Do not insert automatically the current comment
                        " leader after hitting 'o' or 'O' in Normal mode
  set colorcolumn=+0    " Column highlighted, relative to textwidth
endif

" TODO try/catch for setting color scheme
if has("gui_running")
  colorscheme inkpot
else
  if &t_Co == "256"
    " let g:solarized_termcolors=256
    " colorscheme solarized
    let g:inkpot_black_background = 1
    colorscheme inkpot
  else
    colorscheme koehler
  endif
endif

set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}%=line:%l/%L\ col:%c%V\ ascii:%b\ %P

hi ColorColumn term=reverse ctermfg=244 ctermbg=235 gui=reverse
hi StatusLine term=reverse ctermfg=244 ctermbg=235 gui=reverse
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermfg=231 ctermbg=1
  au InsertLeave * hi StatusLine term=reverse ctermfg=244 ctermbg=235
endif

" Show TAB-s and superfluous SPACE characters
set list
set listchars=trail:-

" Automatically fitting a quickfix window height
au FileType qf call AdjustWindowHeight(3, 5)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
