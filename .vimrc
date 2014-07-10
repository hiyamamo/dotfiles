  "=============================================================================
  " Plugin's Setup
  "=============================================================================
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

  "=============================================================================
  " Unit.vimの設定
  "=============================================================================
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
  "=============================================================================
  " ファイルをツリー表示
  NeoBundle 'scrooloose/nerdtree'

  " Gitを便利に使う
  NeoBundle 'tpope/vim-fugitive'

  " 指定の記号で囲む
  NeoBundle 'tpope/vim-surround'
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

  " Rubyのリファレンスを引く
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'yuku-t/vim-ref-ri'

  " 入力補完
  NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'

    if neobundle#is_installed('neocomplete')
        " neocomplete用設定
      let g:neocomplete#enable_at_startup = 1
      let g:neocomplete#enable_ignore_case = 1
      let g:neocomplete#enable_smart_case = 1
      if !exists('g:neocomplete#keyword_patterns')
          let g:neocomplete#keyword_patterns = {}
      endif
      let g:neocomplete#keyword_patterns._ = '\h\w*'
  elseif neobundle#is_installed('neocomplcache')
      " neocomplcache用設定
      let g:neocomplcache_enable_at_startup = 1
      let g:neocomplcache_enable_ignore_case = 1
      let g:neocomplcache_enable_smart_case = 1
      if !exists('g:neocomplcache_keyword_patterns')
          let g:neocomplcache_keyword_patterns = {}
      endif
      let g:neocomplcache_keyword_patterns._ = '\h\w*'
      let g:neocomplcache_enable_camel_case_completion = 1
      let g:neocomplcache_enable_underbar_completion = 1
  endif
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

  " demiliter for function compl
  if !exists('g:neocomplcache_delimiter_patterns')
      let g:neocomplcache_delimiter_patterns = {}
      endif
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck

  "=============================================================================
  " Peco
  "=============================================================================
  function! PecoOpen()
    for filename in split(system("find . -type f | peco"), "\n")
      execute "e" filename
    endfor
  endfunction
  nnoremap <Leader> :call PecoOpen()<CR>

  "=============================================================================
  " 挿入モード時のステータスラインの色を変更
  "=============================================================================
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

  "=============================================================================
  " Set Options
  "=============================================================================
  " カラー設定
  colorscheme molokai
  " 構文毎に文字色を変化
  syntax on
  " 透過
  autocmd GUIEnter * set transparency=220
  " タグファイル指定
  set tags=./tags;
  " 行番号を表示
  set number
  " 対応括弧やブレースを表示
  set showmatch
  "タブ文字表示幅
  set tabstop=2
  " Vimが挿入するインデント幅
  set shiftwidth=2
  " 行頭でタブを入力すると'shiftwidth'分だけインデントする
  set smarttab
  " カーソルを行頭、行末で止まらないように
  set whichwrap=b,s,h,l,<,>,[,]
  " 行番号の色
  highlight LineNr ctermfg=darkyellow
  " ステータスライン行
  set laststatus=2
  " コマンドモードで<tab>キーによるファイル名補完を有効化
  set wildmenu
  " コマンドを可視化
  set showcmd
  " 小文字のみで検索した時に大文字小文字を無視
  set smartcase
  " 検索結果をハイライト
  set hlsearch
  " タブ入力を複数の空白入力に置換
  set expandtab
  " 検索ワードを入力した時点で検索を開始
  set incsearch
  " 開業時に前の行のインデントを継続
  set autoindent
  " 保存されていないファイルがあるときでも別のファイルを開ける
  set hidden
  " ステータス行に表示させる情報の指定
  set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
  " スワップファイルを作成しない
  set noswapfile
  " バックアップファイルを作成しない
  set nobackup
  " アンドゥファイルを作成しない
  set noundofile
