	"=============================================================================
	" Plugin's Setup
	"=============================================================================
	if has('vim_starting')
		set nocompatible							 " Be iMproved

		" Required:
		set runtimepath+=~/.vim/bundle/neobundle.vim/
	endif

	"============================================================================
	" Mapping
	"============================================================================
	let mapleader = "\<Space>"

	" 改行
	noremap <C-CR> o<ESC>

	"Yで行末までヤンク
	nnoremap Y y$

	"無効化
	inoremap <C-@> <Nop>

	nnoremap <Leader>w :w!<CR>

	" Required:
	call neobundle#begin(expand('~/.vim/bundle/'))

	" Let NeoBundle manage NeoBundle
	" Required:
	NeoBundleFetch 'Shougo/neobundle.vim'

	NeoBundle 'rking/ag.vim'
	nmap <Leader>, :Ag <C-r>=expand("<cword>")<CR><CR>
	nnoremap <Leader>/ :Ag 
	" CtrlP Settings
	NeoBundle 'ctrlpvim/ctrlp.vim'
	" filename only
  let g:ctrlp_by_filename = 1
  let g:ctrlp_max_files = 3000
	let g:ctrlp_max_depth = 10
	" cwdから再帰的に
  let g:ctrlp_working_path_mode = 'wa'
	let g:ctrlp_match_window = 'bottom, order:bbt, min:1, max:20'
	nnoremap <Leader>m :CtrlPMRUFiles<CR>
	nnoremap <Leader>l :CtrlPLine<CR>

	if executable('ag')
		let g:ctrlp_use_caching=0
		let g:ctrlp_user_command = 'ag -l --nocolor --depth 10 -m 3000 -g "" %s'
	endif

	" 自動整形
	NeoBundle 'junegunn/vim-easy-align'
	" EasyAlign
	vmap <Cr> <Plug>(EasyAlign)
	nmap <Leader>a <Plug>(EasyAlign)

	" CoffeeScript用のsyntaxなど
	NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'mtscout6/vim-cjsx'

	NeoBundle 'tpope/vim-repeat'

	" color theme
	NeoBundle 'chriskempson/vim-tomorrow-theme'

	NeoBundle 'sjl/badwolf'

	NeoBundle 'shougo/neocomplete.vim'
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use ignorecase
	let g:neocomplete#enable_ignore_case = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	"let g:neocomplete#keyword_patterns._ = '\h\w*'

	inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


	"=============================================================================
	" ファイルをツリー表示
	 NeoBundle 'scrooloose/nerdtree'


	" 指定の記号で囲む
	NeoBundle 'tpope/vim-surround'
	" grep検索実行後にQuickFix Listを表示する
	autocmd QuickFixCmdPost *grep* cwindow

	" Ruby向けにendを自動挿入してくれる
	NeoBundle 'tpope/vim-endwise'

	" コメントON/OFFを手軽に実行
	NeoBundle 'tomtom/tcomment_vim'

	" jade
	NeoBundle 'digitaltoad/vim-jade'

	" React
	NeoBundle 'mxw/vim-jsx'
	NeoBundle 'pangloss/vim-javascript'

	call neobundle#end()

	" Required:
	filetype plugin indent on

	" If there are uninstalled bundles found on startup,
	" this will conveniently prompt you to install them.
	NeoBundleCheck

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
	function! s:my_tabline()	"{{{
		let s = ''
		for i in range(1, tabpagenr('$'))
			let bufnrs = tabpagebuflist(i)
			let bufnr = bufnrs[tabpagewinnr(i) - 1]	" first window, first appears
			let no = i	" display 0-origin tabpagenr.
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
	nnoremap		[Tag]	 <Nop>
	nmap		t [Tag]
	" Tab jump
	for n in range(1, 9)
		execute 'nnoremap <silent> [Tag]'.n	':<C-u>tabnext'.n.'<CR>'
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
	" Set Options
	"=============================================================================
	" カラー設定
	colorscheme gruvbox
  " 文字コード設定
  set encoding=utf8
  set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
  set fileformats=unix,dos,mac

	set background=dark
	" 構文毎に文字色を変化
	syntax on
	" タグファイル指定
	set tags=./tags;
	" 行番号を表示
	set number
	" 対応括弧やブレースを表示
	set showmatch
	" showmatchの時間を設定
	set matchtime=1
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
	" 検索時に大文字小文字を無視
	set ignorecase
	" 検索ワードを入力した時点で検索を開始
	set incsearch
	" 改行時に前の行のインデントを継続
	set autoindent
	" 保存されていないファイルがあるときでも別のファイルを開ける
	set hidden
	" ステータス行に表示させる情報の指定
	set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
	"" スワップファイルを作成しない
	set noswapfile
	" バックアップファイルを作成しない
	set nobackup
	"" アンドゥファイルを作成しない
	set noundofile
	" 検索文字をハイライト
	set hlsearch

	set expandtab

	nnoremap <Leader><Space> :nohlsearch<CR>
	" 不可視文字を可視化
	set list

	set clipboard=unnamed

	" settings for colorscheme:gruvbox
	let g:gruvbox_italic=0

	set grepprg=c:/cygwin64/bin/grep\ -nrH

	set display=lastline

  function SetUU()
    set fenc=utf8
    set ff=unix
  endfunction
  command -nargs=0 SetUU call SetUU()
