let mapleader = "\<Space>"
let maplocalleader = "\\"

let $DATADIR = stdpath("data")
if exists("$SUDO_USER")
  set nobackup
  set nowritebackup
  set noswapfile
  set noundofile
  set viminfo=
  set viewdir=
else
  let &backupdir=expand($DATADIR . "/backup")
  let &directory=expand($DATADIR . "/swap//")
  let &undodir=expand($DATADIR . "/undo")
  let &viewdir=expand($DATADIR . "/view")
  set undofile
endif

syntax on
set background=dark
"set keymap=russian-jcukenwin
set showcmd
set number
set relativenumber
set smartindent
set breakindent
set clipboard=unnamedplus
set nowrap
set formatoptions=tcroqnj
set joinspaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set ignorecase
set termguicolors
set smartcase
set hidden
set scrolloff=4
set sidescrolloff=4
set list
set listchars=tab:\¦\ ,trail:·,nbsp:░,extends:»,precedes:«
set lazyredraw
set mouse=a
set shortmess=aIcOt
set splitbelow
set splitright
set wildmenu
set wildmode=longest:full,full

let &showbreak="↳"
call matchadd("ColorColumn", "\%80v")

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

inoremap <S-Enter> <C-o>O
nnoremap <S-Enter> O<Esc>j
nnoremap <CR> o<Esc>k

inoremap <C-v> <S-Insert>
vnoremap <C-c> <C-Insert>

noremap <C-s> :up<CR>
inoremap <C-s> <C-o>:up<CR>

nnoremap <A-r> :e<CR>G

noremap <A-s> <cmd>Telescope live_grep<CR>
noremap <A-g> :let @/="\\<".expand("<cword>")."\\>"<CR><cmd>Telescope grep_string<CR>
noremap <A-n> <cmd>Telescope file_browser path=%:p:h<CR>
noremap <A-N> <cmd>Telescope file_browser<CR>
noremap <A-b> <cmd>Telescope find_files<CR>
noremap <A-m> <cmd>Telescope oldfiles<CR>
noremap <A-t> <cmd>Telescope<CR>

noremap <silent> <A-=> <C-w>=
noremap <silent> <A-j> <C-w>-
noremap <silent> <A-k> <C-w>+
noremap <silent> <A-h> <C-w><
noremap <silent> <A-l> <C-w>>
noremap <silent> <A-w> <C-w><C-w>
noremap <silent> <A-q> <C-w><S-w>
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-l> <C-w>l

nnoremap K ddpkJ

nnoremap gb :bn<CR>
nnoremap gB :bp<CR>

nnoremap <Up>    <C-y>
nnoremap <Right> zl
nnoremap <Down>  <C-e>
nnoremap <Left>  zh

nnoremap <leader>. @:

function! StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction
nnoremap <leader>sw :call StripTrailingWhitespaces()<CR>
vnoremap <leader>sw :call StripTrailingWhitespaces()<CR>

augroup EasyAlternate
  autocmd!
  autocmd BufLeave * call EasyAlternate("b")
  autocmd TabLeave * call EasyAlternate("t")
augroup END

let s:ea_prev_view = ""
function! EasyAlternate(...)
  if a:0 == 0
    if s:ea_prev_view == "t"
      execute "tabn " . s:prev_tab
    elseif s:ea_prev_view == "b"
      execute "b " . s:prev_buf
    endif
  else
    if a:1 == "t"
      let s:prev_tab = tabpagenr()
    elseif a:1 == "b" && len(tabpagebuflist()) == 1
      let s:prev_buf = bufnr("%")
    endif
    let s:ea_prev_view = a:1
  endif
endfunction

nnoremap <silent> <leader><leader> :call EasyAlternate()<CR>
vnoremap <silent> <leader><leader> :call EasyAlternate()<CR>

vmap <S-Up>   <Plug>SchleppIndentUp
vmap <S-Down> <Plug>SchleppIndentDown
vmap <Up>     <Plug>SchleppUp
vmap <Down>   <Plug>SchleppDown
vmap <Left>   <Plug>SchleppLeft
vmap <Right>  <Plug>SchleppRight
vmap D        <Plug>SchleppDup
let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlocks = 1
let g:Schlepp#trimWS = 0
let g:Schlepp#reindent = 0

nnoremap <leader>t :Tabularize /
vnoremap <leader>t :Tabularize /

command! -nargs=1 Browse silent execute "!start" '""' shellescape("<args>", 1)

nnoremap <silent> <leader>gb :GBrowse<CR>
vnoremap <silent> <leader>gb :GBrowse<CR>
nnoremap <silent> <leader>gl :GBrowse!<CR>
vnoremap <silent> <leader>gl :GBrowse!<CR>

let g:EditorConfig_exclude_patterns = ["fugitive://.*"]
