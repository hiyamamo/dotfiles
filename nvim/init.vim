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

  nnoremap <Leader>m :CtrlPMRUFiles<CR>
  let g:ctrlp_show_hidden = 1
  nmap <Leader>, :Ag <C-r>=expand("<cword>")<CR><CR>
  nnoremap <Leader>/ :Ag 

  call plug#begin('~/.vim/plugged')

  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'peitalin/vim-jsx-typescript'
  autocmd BufNewFile,BufRead *.tsx, set filetype=typescript.jsx

  Plug 'vim-scripts/vcscommand.vim'
  Plug 'Chiel92/vim-autoformat'

  Plug 'thinca/vim-qfreplace'

  " Taglist
  Plug 'vim-scripts/taglist.vim'
  let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
  let Tlist_Show_One_File = 1
  let Tlist_Use_Horiz_Window = 1
  let Tlist_WinHeight = 20
  let Tlist_Close_On_Select = 1
  let Tlist_Compact_Format = 1
  let Tlist_Exit_OnlyWindow = 1
  let Tlist_GainFocus_On_ToggleOpen = 1
  map <silent> <leader>l :TlistToggle<CR>

  Plug 'rizzatti/dash.vim'
  nmap <silent> <leader>d <Plug>DashSearch
  Plug 'simeji/winresizer'
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

  Plug 'Konfekt/FastFold'

  " CoffeeScript用のsyntaxなど
  Plug 'kchmck/vim-coffee-script'

  Plug 'tpope/vim-repeat'

  Plug 'thinca/vim-ref'
  Plug 'yuku-t/vim-ref-ri'

  nnoremap ,rr :<C-U>Ref ri<Space>

  " ファイルをツリー表示
  Plug 'scrooloose/nerdtree'
  nnoremap <Leader>n :NERDTreeToggle<CR>

  " Async Linter
  Plug 'w0rp/ale'
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  let g:ale_fixers = {
  \   'javascript': [
  \       'prettier-eslint',
  \   ],
  \   'typescript': [
  \       'prettier',
  \   ],
  \   'ruby': [
  \       'rubocop',
  \   ],
  \}
  let g:ale_linters = {'javascript': ['eslint'], 'javascript.jsx': ['eslint'] }

  "let g:ale_javascript_prettier_eslint_use_global = 1
  let g:ale_fix_on_save = 1

  let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
  let g:ale_ruby_rubocop_options = '-D'
  let g:ale_open_list = 0
  " Write this in your vimrc file
  let g:ale_lint_on_text_changed = 'never'
  " You can disable this option too
  " if you don't want linters to run on opening a file
  let g:ale_lint_on_enter = 0

  " React
  Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 0

  Plug 'pangloss/vim-javascript'
  let g:javascript_plugin_flow = 1
  autocmd BufNewFile,BufRead *.es6 setf javascript

  " ======================================
  " Language Server
  " ======================================
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

  let g:LanguageClient_serverCommands = {
  \ 'javascript': ['flow-language-server', '--stdio'],
  \ 'javascript.jsx': ['flow-language-server', '--stdio'],
  \ 'typescript': ['javascript-typescript-stdio'],
  \ 'typescript.jsx': ['javascript-typescript-stdio'],
  \ }

  " (Optionally) automatically start language servers.
  let g:LanguageClient_autoStart = 1

  " grep検索実行後にQuickFix Listを表示する
  autocmd QuickFixCmdPost *grep* cwindow

  " 行末の半角スペースを可視化
  Plug 'bronson/vim-trailing-whitespace'

  "========================================
  " Ruby & Rails Settings
  "========================================
  " Ruby向けにendを自動挿入してくれる
  Plug 'tpope/vim-endwise'

  Plug 'tpope/vim-rails'
  Plug 'vim-scripts/ruby-matchit'

  let g:ruby_path = ''
  let s:plug = {
        \ "plugs": get(g:, 'plugs', {})
        \ }

  function! s:plug.is_installed(name)
      return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
  endfunction

  " 入力補完
  Plug 'roxma/nvim-completion-manager'
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  Plug 'AndrewRadev/linediff.vim'

  " Elm-lang
  Plug 'lambdatoast/elm.vim'

  " Vue-vim
  Plug 'posva/vim-vue'

  " Markdown
  Plug 'plasticboy/vim-markdown'
  Plug 'kannokanno/previm'
  Plug 'tyru/open-browser.vim'

  Plug 'fatih/vim-go'
  autocmd FileType go nmap <leader>b  <Plug>(go-build)
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  au BufRead,BufNewFile *.md set filetype=markdown
  " let g:previm_open_cmd = 'open -a Chrome'

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
  colorscheme solarized8_dark
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

  " ==============================
  " ステータスライン設定
  " =============================
  " ファイル名表示
  set statusline=%F
  " 変更チェック表示
  set statusline+=%m
  " 読み込み専用かどうか表示
  set statusline+=%r
  " ヘルプページなら[HELP]と表示
  set statusline+=%h
  " プレビューウインドウなら[Prevew]と表示
  set statusline+=%w
  " これ以降は右寄せ表示
  set statusline+=%=
  " lintの状態を表示
  set statusline+=[%{ALEGetStatusLine()}]
  " file encoding
  set statusline+=[%{&fileencoding}]
  " file format
  set statusline+=[%{&ff}]
  " column番号
  set statusline+=[%c]
  " ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
  set laststatus=2
  " =============================

  " スワップファイルを作成しない
  set noswapfile
  " バックアップファイルを作成しない
  set nobackup
  " アンドゥファイルを作成しない
  set noundofile

  " 不可視文字を可視化
  set list
  set clipboard=unnamed,unnamedplus
  set listchars=eol:¬,tab:▸\ ,trail:.

  set foldenable
  set foldlevel=1
  set foldmethod=indent
  set foldnestmax=4

  " 折り返しでインデントする
  set breakindent

  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
