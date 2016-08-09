  "=============================================================================
  " Plugin's Setup
  "=============================================================================
  if has('vim_starting')
    set nocompatible               " Be iMproved

    " Required:
    set runtimepath+=~/.vim/bundle/Plug.vim/
  endif

  let mapleader = "\<Space>"
  nnoremap <Leader>w :w<CR>
  nnoremap <Leader><Space> :nohlsearch<CR>

  nnoremap <C-]> g<C-]>
  " grep検索実行後にQuickFix Listを表示する
  autocmd QuickFixCmdPost *grep* cwindow

  " ステータス行に現在のgitブランチを表示する
  set statusline+=%{fugitive#statusline()}

  nnoremap <Leader>m :CtrlPMRUFiles<CR>
  nmap <Leader>, :Ag <C-r>=expand("<cword>")<CR><CR>
  nnoremap <Leader>/ :Ag 

  call plug#begin('~/.vim/plugged')

  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

  Plug 'vcscommand.vim'

  " Taglist
  Plug 'taglist.vim'
  let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
  let Tlist_Show_One_File = 1
  let Tlist_Use_Horiz_Window = 1
  let Tlist_WinHeight = 20
  let Tlist_Close_On_Select = 1
  let Tlist_Compact_Format = 1
  let Tlist_Exit_OnlyWindow = 1
  let Tlist_GainFocus_On_ToggleOpen = 1
  map <silent> <leader>l :TlistToggle<CR>

  Plug 'tpope/vim-fugitive'
  Plug 'hrsh7th/vim-versions'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'rking/ag.vim'
  let g:ctrlp_match_window = 'bottom, order:ttb, min:1m max:40'
  let g:ctrlp_working_path_mode = 'w'
  if executable('ag')
    let g:ctrlp_use_caching = 0
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
  endif

  " 自動整形
  Plug 'junegunn/vim-easy-align'
  " EasyAlign
  vmap <Cr> <Plug>(EasyAlign)
  nmap <Leader>a <Plug>(EasyAlign)

  " CoffeeScript用のsyntaxなど
  Plug 'kchmck/vim-coffee-script'

  " カーソル移動を快適に
  " ミニマル設定
  Plug 'Lokaltog/vim-easymotion'
  let g:EasyMotion_do_mapping = 0
  nmap s <Plug>(easymotion-s2)
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1

  Plug 'tpope/vim-repeat'

  Plug 'thinca/vim-ref'
  Plug 'yuku-t/vim-ref-ri'

  nnoremap ,rr :<C-U>Ref ri<Space>

  " ファイルをツリー表示
  Plug 'scrooloose/nerdtree'
  nnoremap <Leader>n :NERDTreeToggle<CR>

  " 構文チェック
  Plug 'scrooloose/syntastic'
  Plug 'pmsorhaindo/syntastic-local-eslint.vim'

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_ruby_rubocop_exec = '/Users/yamamoto/bin/rubocop-syntastic'
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
  let g:syntastic_ruby_checkers = ['rubocop']

  let g:syntastic_javascript_checkers = ['eslint']
  nnoremap <Leader>t :SyntasticToggleMode<CR>
  nnoremap <Leader>c :SyntasticCheck<CR>

  " React
  Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 0
  Plug 'pangloss/vim-javascript'
  autocmd BufNewFile,BufRead *.es6 setf javascript

  " 指定の記号で囲む
  Plug 'tpope/vim-surround'
  " grep検索実行後にQuickFix Listを表示する
  autocmd QuickFixCmdPost *grep* cwindow

  " 行末の半角スペースを可視化
  Plug 'bronson/vim-trailing-whitespace'

  " コメントON/OFFを手軽に実行
  Plug 'tomtom/tcomment_vim'

  " jade
  Plug 'digitaltoad/vim-jade'

  "========================================
  " Ruby & Rails Settings
  "========================================
  " Ruby向けにendを自動挿入してくれる
  Plug 'tpope/vim-endwise'

  Plug 'tpope/vim-rails'
  Plug 'ruby-matchit'

  let g:ruby_path = ''
  let s:plug = {
        \ "plugs": get(g:, 'plugs', {})
        \ }

  function! s:plug.is_installed(name)
      return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
  endfunction

  " 入力補完
  Plug has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'

  if s:plug.is_installed('neocomplete')
    " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#close_popup()."\<C-h>"

    " javascript nodejs
    "autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
    "if !exists('g:neocomplete#sources#omni#functions')
    "  let g:neocomplete#sources#omni#functions = {}
    "endif
    "let g:neocomplete#sources#omni#functions.javascript = 'nodejscomplete#CompleteJS'

    "if !exists('g:neocomplete#sources#omni#input_patterns')
    "  let g:neocomplete#sources#omni#input_patterns = {}
    "endif
    "let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'
  endif

  if s:plug.is_installed('neocomplcache')
    "" neocomplcache用設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
    " demiliter for function compl
    if !exists('g:neocomplcache_delimiter_patterns')
        let g:neocomplcache_delimiter_patterns = {}
    endif
  endif

  Plug 'AndrewRadev/linediff.vim'

  " Add plugins to &runtimepath
  call plug#end()

  " Required:
  filetype plugin indent on

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
  " Anywhere SID.
  function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
  endfunction

  " Set tabline.
  function! s:my_tabline()  "{{{
    let s = ''
    for i in range(1, tabpagenr('$'))
      let bufnrs = tabpagebuflist(i)
      let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
      let no = i  " display 0-origin tabpagenr.
      let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
      let title = fnamemodify(bufname(bufnr), ':t')
      let title = '[' . title . ']'
      let s .= '%'.i.'T'
      let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
      let s .= no . ':' . title
      let s .= mod
      let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
  endfunction "}}}
  let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
  set showtabline=2 " 常にタブラインを表示

  " The prefix key.
  nnoremap    [Tag]   <Nop>
  nmap    t [Tag]
  " Tab jump
  for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
  endfor
  " t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

  map <silent> [Tag]c :tablast <bar> tabnew<CR>
  " tc 新しいタブを一番右に作る
  map <silent> [Tag]x :tabclose<CR>
  " tx タブを閉じる
  map <silent> [Tag]n :tabnext<CR>
  " tn 次のタブ
  map <silent> [Tag]p :tabprevious<CR>
  " tp 前のタブ

  "=============================================================================
  " ファイルを開いた時とのdiffをとる
  "=============================================================================
  set splitright
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
  endif

  "=============================================================================
  " Set Options
  "=============================================================================
  " カラー設定
  colorscheme solarized
  set background=dark
  " 構文毎に文字色を変化
  syntax on
  " タグファイル指定
  set tags=./.tags;
  " 行番号を表示
  set number
  " 対応括弧やブレースを表示
  set showmatch
  set expandtab
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
  set ignorecase
  " 検索結果をハイライト
  set hlsearch
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

  " 不可視文字を可視化
  set list
  set clipboard=unnamed
  set listchars=eol:¬,tab:▸\ ,trail:.

  set foldenable
  set foldmethod=indent
  set foldlevel=1
  set foldnestmax=4
