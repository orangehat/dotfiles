" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"

""""""""""""""""""""""""""""""""""
"          NeoVundle              "
""""""""""""""""""""""""""""""""""
set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif 

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache' 
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'mattn/emmet-vim'
NeoBundle 't9md/vim-surround_custom_mapping'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'bling/vim-airline'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'fuenor/qfixhowm'

" vim-scripts repos 
NeoBundle 'css_color.vim'
NeoBundle 'surround.vim'

filetype plugin indent on

"---------------------------------------------------------------------------
" vimproc設定
if has('mac')
  let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/vimproc_mac.so'
elseif has('win32')
  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc/autoload/vimproc_win32.dll'
elseif has('win64')
  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc/autoload/vimproc_win64.dll'
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" インデントや<<, >>のタブの幅
set shiftwidth=4
" キーボードで<TAB>キーを押したときの幅
set softtabstop=4
" タブをスペースに展開しない (expandtab:展開する)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1     " ぶら下り可能幅

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set nowrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
:set noundofile


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
 " tagsファイルの重複防止
 set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
 let uname = system('uname')
 if uname =~? "linux"
   set term=builtin_linux
 elseif uname =~? "freebsd"
   set term=builtin_cons25
 elseif uname =~? "Darwin"
   "set term=beos-ansi
   set term=builtin_xterm
 else
   set term=builtin_xterm
 endif
 unlet uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
 set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
 let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
 " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
 set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" ここから自分で指定したもの

" 日本語ヘルプ
set helplang=ja,en

set bg=dark

set noswapfile

set nobackup

" モードラインを有効にする
set modeline

"カーソル行の強調表示
set cursorline

set ruf=%45(%12f%=\ %m%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B]%)
set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L

" ファイルエクスプローラ補完
set wildmode=list,full

" ■などの特殊文字を表示させる
set ambiwidth=double
set showcmd                      " コマンドをステータス行に表示

" クリップボードにコピー
vmap <C-C> "+y

" 挿入モード時、コマンドライン時クリップボードから貼り付け
imap <C-V> <ESC>"+pa
cmap <C-V> <C-R>+
vmap <C-V> d"+P

" クリップボードに切り取り
vmap <C-X> "+d<ESC>

imap <S-Right> <ESC>v<Right>

imap <S-Left> <ESC>v<Left>

imap <S-Up> <ESC>v<Up>

imap <S-Down> <ESC>v<Down>
" 
" ビジュアルモードで * で検索
vnoremap * "zy:let @/ = @z<CR>n

" 検索時カーソルを真ん中に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

" 挿入モードのカーソル移動
inoremap <C-E> <End>
inoremap <C-A> <Home>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-H> <Left>
inoremap <C-L> <Right>

" カッコ/クォート補完
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>

" タブ移動
noremap <C-P> gt
noremap <C-N> gT

" Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" ビジュアルモード時、改行を含めない
vmap $ g_

" Ev/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

"日付挿入
function! InsertCDate(format)
 let old_lc_time = v:lc_time
 try
   exec ':silent! lang time C'
   let datetime = strftime(a:format)
   return datetime
 finally
   exec ':silent! lang time ' . old_lc_time
 endtry
endf
"YYYY-MM-DD HH:MM:SS
inoremap <Leader>date <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR>
nnoremap <Leader>date i<C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR><ESC>
vnoremap <Leader>date s<C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR><ESC>
"RFC2822(WDay, DD Month YYYY HH:MM:SS +-Timezone)
if has('win32')
 "Windowsの%zは「東京 (標準時)」とか返してきて+0900が得られない……
 inoremap <Leader>dt822 <C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S +0900')<CR>
 nnoremap <Leader>dt822 i<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S +0900')<CR><ESC>
 vnoremap <Leader>dt822 s<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S +0900')<CR><ESC>
else
 inoremap <Leader>dt822 <C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S %z')<CR>
 nnoremap <Leader>dt822 i<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S %z')<CR><ESC>
 vnoremap <Leader>dt822 s<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S %z')<CR><ESC>
endif

"入力モード時、ステータスラインのカラーを変更
"augroup InsertHook
"autocmd!
"autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
"autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
"augroup END

" カレントディレクトリのnautilusをvimより立ち上げる
function! Nautilus()
 let current_dir = expand('%:p:h')
 exec 'silent !nautilus ' . current_dir
endfunction
command! -nargs=0 Nautilus call Nautilus()

" Shift-jisで開き直す
function! ShiftJis()
 :edit ++enc=shift-jis
endfunction
command! -nargs=0 ShiftJis call ShiftJis()

" Shift-jisで開き直す
function! Utf8()
 :edit ++enc=utf-8
endfunction
command! -nargs=0 Utf8 call Utf8()

" EUC-JPで開き直す
function! EucJp()
 :edit ++enc=euc-jp
endfunction
command! -nargs=0 EucJp call EucJp()

" 挿入モード時のIMEを記憶させない
"inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" 実体参照入力
function! s:char2entity(str)
    let result = a:str
    if a:str ==? '<'
        let result = '&lt;'
    elseif a:str ==? '>'
        let result = '&gt;'
    elseif a:str ==? '"'
        let result = '&quot;'
    elseif a:str ==? '&'
        let result = '&amp;'
    endif
    return result
endfunction

function! s:entity2char(str)
    let result = a:str
    if a:str ==? '&lt;'
        let result = '<'
    elseif a:str ==? '&gt;'
        let result = '>'
    elseif a:str ==? '&quot;'
        let result = '"'
    elseif a:str ==? '&amp;'
        let result = '&'
    endif
    return result
endfunction

function! s:range2HtmlEntity() range
    silent execute "normal! gv:s/\\%V[\&<>\"]/\\= s:char2entity(submatch(0)) /g\<CR>"
endfunction

function! s:range2HtmlString() range
    silent execute "normal! gv:s/\\%V\&[^;#]\\+;/\\= s:entity2char(submatch(0)) /g\<CR>"
endfunction

" for range command
command! -range Str2HtmlEntity :<line1>,<line2>call s:range2HtmlEntity()
command! -range Entity2HtmlString :<line1>,<line2>call s:range2HtmlString()

" 勝手に改行されるのを修正
autocmd FileType text setlocal textwidth=0

" 文字コードの自動認識
if &encoding !=# 'utf-8'
 set encoding=japan
 set fileencoding=japan
endif
if has('iconv')
 let s:enc_euc = 'euc-jp'
 let s:enc_jis = 'iso-2022-jp'
 " iconvがeucJP-msに対応しているかをチェック
 if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
   let s:enc_euc = 'eucjp-ms'
   let s:enc_jis = 'iso-2022-jp-3'
 " iconvがJISX0213に対応しているかをチェック
 elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
   let s:enc_euc = 'euc-jisx0213'
   let s:enc_jis = 'iso-2022-jp-3'
 endif
 " fileencodingsを構築
 if &encoding ==# 'utf-8'
   let s:fileencodings_default = &fileencodings
   let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
   let &fileencodings = &fileencodings .','. s:fileencodings_default
   unlet s:fileencodings_default
 else
   let &fileencodings = &fileencodings .','. s:enc_jis
   set fileencodings+=utf-8,ucs-2le,ucs-2
   if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
     set fileencodings+=cp932
     set fileencodings-=euc-jp
     set fileencodings-=euc-jisx0213
     set fileencodings-=eucjp-ms
     let &encoding = s:enc_euc
     let &fileencoding = s:enc_euc
   else
     let &fileencodings = &fileencodings .','. s:enc_euc
   endif
 endif
 " 定数を処分
 unlet s:enc_euc
 unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
 function! AU_ReCheck_FENC()
   if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
     let &fileencoding=&encoding
   endif
 endfunction
 autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
 set ambiwidth=double
endif

""""""""""""""""""""""""""""""""""
"        surround.vim            "
""""""""""""""""""""""""""""""""""
autocmd FileType php let g:surround_{char2nr("t")} = "<?php \r ?>"

""""""""""""""""""""""""""""""""""
"        neocomplcache           "
""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . (&indentexpr != '' ? "\<C-f>\<CR>X\<BS>":"\<CR>")
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete


""""""""""""""""""""""""""""""""""
"          unite.vim             "
""""""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" タブを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-o> unite#do_action('tabopen')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q


""""""""""""""""""""""""""""""""""
"           VimShell             "
""""""""""""""""""""""""""""""""""
let g:VimShell_EnableInteractive = 1
" ,vs: シェルを起動
nnoremap <silent> ,vs :VimShell<CR>

""""""""""""""""""""""""""""""""""
"           VimFiler             "
""""""""""""""""""""""""""""""""""
let g:vimfiler_as_default_explorer = 1
noremap <silent> ,vf :VimFiler<CR>


""""""""""""""""""""""""""""""""""
"           VimFiler             "
""""""""""""""""""""""""""""""""""
" キーマップリーダー
let QFixHowm_Key = 'g'

" howm_dirはファイルを保存したいディレクトリを設定
let howm_dir             = '~/Dropbox/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'
