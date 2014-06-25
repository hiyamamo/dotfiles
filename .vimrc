""""""""""""""""""""""""""""""""""""""
" Plugin's Setup
""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

  " Required:
  call neobundle#begin(expand('~/.vim/bundle/'))

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

  " ファイルオープンを便利に
  NeoBundle 'Shougo/unite.vim'
  " Unite.vimで最近使ったファイルを表示できるようにする
  NeoBundle 'Shougo/neomru.vim'

  """""""""""""""""""""""""""""""
  " Unit.vimの設定
  
  """""""""""""""""""""""""""""""
  " 入力モードで開始する
  let g:unite_enable_start_insert=1
  " バッファ一覧
  noremap <C-P> :Unite buffer<CR>
  " ファイル一覧
  noremap <C-N> :Unite -buffer-name=file file<CR>
  " 最近使ったファイルの一覧
  noremap <C-Z> :Unite file_mru<CR>
  " sourcesを「今開いているファイルのディレクトリ」とする
  noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
  " ウィンドウを分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
  au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
  " ウィンドウを縦に分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
  au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
  " ESCキーを2回押すと終了する
  au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
  au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
  """"""""""""""""""""""""""""""
  " ファイルをツリー表示
  NeoBundle 'scrooloose/nerdtree'

  " Gitを便利に使う
  NeoBundle 'tpope/vim-fugitive'

  " grep検索実行後にQuickFix Listを表示する
  autocmd QuickFixCmdPost *grep* cwindow

  " ステータス行に現在のgitブランチを表示する
  set statusline+=%{fugitive#statusline()}

  " 行末の半角スペースを可視化
  NeoBundle 'bronson/vim-trailing-whitespace'

  " Ruby向けにendを自動挿入してくれる
  NeoBundle 'tpope/vim-endwise'

  " コメントON/OFFを手軽に実行
  NeoBundle 'tomtom/tcomment_vim'

  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck
  """"""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""
" 挿入モード時のステータスラインの色を変更
"""""""""""""""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"""""""""""""""""""""""""""""""""""""
" Set Options 
"
"""""""""""""""""""""""""""""""""""""
" カラー設定
colorscheme murphy
" 構文毎に文字色を変化
syntax on
" 行番号を表示
set number
" 対応括弧やブレースを表示
set showmatch
set tabstop=2
set shiftwidth=2
set smarttab
set whichwrap=b,s,h,l,<,>,[,]
highlight LineNr ctermfg=darkyellow
set laststatus=2
set wildmenu
set showcmd
set smartcase
set hlsearch
set expandtab
set incsearch
set autoindent
set hidden
" ステータス行に表示させる情報の指定(どこからかコピペしたので細かい意味はわかっていない)
 set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
