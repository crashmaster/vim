" This config file contains settings related to the editor's look.

syntax on               " Syntax highlighting, Vim overrules settings
autocmd BufEnter * :syntax sync fromstart

set number              " Show line numbers
set numberwidth=6       " Line numbers 6 charaters wide
set relativenumber      " Show line numbers relative to the cursor
set cursorline          " Highlight the current line
set signcolumn=yes      " Always show sign column

set showcmd             " Show (partial) command in the last line of the screen
set nowrap              " Do not break long lines
set breakindent         " Wrapped lines preserve indentation
set splitbelow          " New horizontal splits open below
set splitright          " New vertical splits open to the right

" A comma separated list of options for insert mode completion:
"    menu       -> use a popup menu to show the possible completions
"    menuone    -> use the popup menu also when there is only one match
"    longest    -> only insert the longest common text of the matches
"    preview    -> show extra information in the preview window (OMITTED)
set completeopt=menu,menuone,longest
set pumheight=20        " Pop up menu has maximal 20 rows

set textwidth=80      " Maximum width of text that is being inserted
set formatoptions-=t  " Do not auto-wrap text using textwidth
set formatoptions-=o  " Do not insert automatically the current comment
                      " leader after hitting 'o' or 'O' in Normal mode
set formatoptions+=j  " Remove comment leader when joining lines
set colorcolumn=+0    " Column highlighted, relative to textwidth

" Set color scheme with fallback
if &t_Co == "256"
  let g:inkpot_black_background = 1
  try
    colorscheme inkpot
  catch
    colorscheme default
  endtry
else
  colorscheme koehler
endif

set laststatus=2
function! GetNumberOfBuffers()
    let l:number_of_buffers=len(getbufinfo({'buflisted':1}))
    return l:number_of_buffers
endfunction
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}%=buffer:%n/%{GetNumberOfBuffers()}\ line:%l/%L\ col:%c%V\ ascii:%b\ %P

hi ColorColumn term=reverse ctermfg=244 ctermbg=235
hi StatusLine term=reverse ctermfg=244 ctermbg=235
au InsertEnter * hi StatusLine term=reverse ctermfg=231 ctermbg=1
au InsertLeave * hi StatusLine term=reverse ctermfg=244 ctermbg=235

" Show TAB-s and superfluous SPACE characters
set list
set listchars=trail:-

" Automatically fitting a quickfix window height
au FileType qf call AdjustWindowHeight(3, 5)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
