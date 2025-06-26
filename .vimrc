syntax enable

set hls

" Default colorscheme that I like :)
"colo ron

" Custom colorscheme
"   Range:   233 (darkest) ~ 239 (lightest)
let g:seoul256_background = 235
colo seoul256

"   Range:   252 (darkest) ~ 256 (lightest)
let g:seoul256_light_background = 255

" Switch seoul256 modes
"set background=dark
"set background=light

" Flash screen instead of beep sound
set visualbell

" Change how vim represents characters on the screen
set encoding=utf-8

" Set the encoding of files written
set fileencoding=utf-8

" Set a column at 80 chars
set colorcolumn=80
highlight ColorColumn ctermbg=238


" Language-specific settings
" ts - show existing tab with 4 spaces width
" sw - when indenting with '>', use 4 spaces width
" sts - control <tab> and <bs> keys to match tabstop
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:> foldmethod=indent nofoldenable

" Control all other files
set shiftwidth=4

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" " Hardcore mode, practice no-arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

filetype plugin indent on

" Allow backspace to delete indentation and inserted text
" i.e. how it works in most programs
set backspace=indent,eol,start

" "  General IDE-like features
set number
highlight LineNr ctermfg=grey 
set noautochdir
let mapleader = "'"
" Search selection using `//`
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" Close all buffers except current one
map <leader>o :%bd\|e#<cr>
" Close all quickfix/location windows
map <leader>l :windo lcl\|ccl<cr>
" Close current buffer (using them as tabs)
map <leader>d :bd<cr>

map <leader>c "*y
map <leader>y "*y
map <leader>v "*p
map <leader>p "*p

" If we're not satisfied with the above handling of copy/paste to the system's
" cliboard, we can also try using the following
" set clipboard=unnamedplus

" Personal experiment, also allows for scrolling with mouse near top/bottom of screen
set scrolloff=3

" Allow support for mouse
set mouse=a

" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_auto_type_info=1
let g:go_diagnostics_level=2
let g:go_fmt_command='gofmt'
nmap <silent> <leader>t :GoTestFunc<cr>
nmap <silent> <leader>T :GoTest<cr>

" Ale
let g:ale_sign_error = 'x'
let g:ale_sign_warning = 'o'
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
nmap <silent> <C-k> :ALEPrevious<cr>
nmap <silent> <C-j> :ALENext<cr>

" " Use airline
" Maybe also consider lightline in the future https://github.com/itchyny/lightline.vim 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='bubblegum'

" Use buffers as tabs
nnoremap <silent> + :bn<CR>
nnoremap <silent> _ :bp<CR>

" " Use fzf
set rtp+=/opt/homebrew/opt/fzf

" " Use netrw
let g:netrw_keepdir=1

" NERDTree plugin specific commands
:nnoremap <C-g> :NERDTreeToggle<CR>

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Display in tree mode by default
let g:netrw_liststyle=3

" absolute width of netrw window
let g:netrw_winsize=-35

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" " Use vim-signify
" git clone https://github.com/mhinz/vim-signify ~/.vim/pack/plugins/start/vim-signify
nmap ]c <plug>(signify-next-hunk):SignifyPreviewHunk<CR>
nmap [c <plug>(signify-prev-hunk):SignifyPreviewHunk<CR>

" Store .swp~ files on a different location
" MacOS-specific
" set backupdir=$TMPDIR// 
" set directory=$TMPDIR//
set backupdir=~/.vim/tmpdir//
set directory=~/.vim/tmpdir//

command ComponentDocs :! fn=%:p:h && cn=$(echo $fn | sed -E "s/(.*)\/agent\/component\/(.*)/\2/" | sed -E "s/(.*)\/internal(.*)/\1/" | tr '/' '.') && open --new -a "Google Chrome" --args "https://grafana.com/docs/agent/next/flow/reference/components/$cn"

command References GoReferrers
nnoremap dgg <nop>

