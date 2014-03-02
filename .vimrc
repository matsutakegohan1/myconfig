filetype plugin on
set backspace=indent,eol,start
set runtimepath=~/git/myconfig/.vim/,/usr/share/vim/vim73/
"バインド(<tab>)を変更したい場合
imap <unique> <C-b> <Plug>Jumper

"新しい行のインデントを現在行と同じにする
set autoindent
"Vi互換をオフ
set nocompatible
"タブの代わりに空白文字を挿入する
set expandtab
"インクリメンタルサーチを行う
set incsearch
"行番号を表示する
set number
"シフト移動幅
"set shiftwidth=4
"閉じ括弧が入力されたとき、対応する括弧を表示する
set noshowmatch
let loaded_matchparen = 1
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"カーソルを行頭、行末で止まらないようにする
" set whichwrap=b,s,h,l,<,>,[,]
"検索をファイルの先頭へループしない
set nowrapscan

syntax on

"ウィンドウを最大化して起動
au GUIEnter * simalt ~x

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"日本語入力をリセット
au BufNewFile,BufRead * set iminsert=0
"タブ幅をリセット
au BufNewFile,BufRead * set tabstop=4 shiftwidth=4

".txtファイルで自動的に日本語入力ON
au BufNewFile,BufRead *.txt set iminsert=2
".rhtmlと.rbでタブ幅を変更
au BufNewFile,BufRead *.rhtml   set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

set tags=~/tags/tags,./tags,tags,../tags,~/tags/cpan/tags 


" Ctrl+Jでエスケープ
imap <C-j> <ESC>
" ビープ音を消す
set vb t_vb=

"omni mapping
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>


map ,pt <ESC>:%! perltidy<CR>
map ,ptv <ESC>:%'<, '>! perltidy<CR>

",c でコメントアウト ,u でコメント解除
" Perl
autocmd FileType perl
    \   map ,c :s/^/# /<CR>:noh<CR>
    \ | map ,u :s/^# //<CR>:noh<CR>

" PHP
autocmd FileType php
    \   map ,c :s/^/\/\/ /<CR>:noh<CR>
    \ | map ,u :s/^\/\/ //<CR>:noh<CR>

" vimの256色表示を有効にする。
set t_Co=256

" 表示行単位で行移動するようにする
nnoremap j gj
nnoremap k gk

" 検索語が画面の真ん中に来るようにする
nmap n nzz 
nmap N Nzz 
nmap * *zz 
nmap # #zz 
nmap g* g*zz 
nmap g# g#zz

function! s:PhpStylist()
    execute "w"
    normal ggdG
    execute "0r!~/bin/phpStylist %"
    normal Gdd
endfunction
command! PhpStylist call <SID>PhpStylist()

