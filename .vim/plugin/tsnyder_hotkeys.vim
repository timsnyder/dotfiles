" Vim global plugin file containing Tim Snyder's hotkey mappings
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 04-Mar-07 21:42 
" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\; 


" Avoid issues with 'compatability' option
let s:save_cpo = &cpo
set cpo&vim

" Only do this $USER hasn't already done it with their own version earlier in 'runtimepath' or set
" the variable to avoid my hotkeys being loaded
if exists("loaded_tsnyder_hotkeys")
  finish
endif
let loaded_tsnyder_hotkeys = 1

"TODO if in vim7.0 or more
"     setup a dictionary  
"     redir into dictoinary
"     silent map
"     redir END
"     reverse the dictionary and you have the makings of a reverse maparg() to look up the correct
"     hotkey for the menu
"

" <Plug>TsnyderYankToEOL : Make Y yank to end of like like D deletes to end of line.  {{{1
" I don't care if it is vi compatable, it just makes sense...
if !hasmapto('<Plug>TsnyderYankToEOL')
  map <unique> Y  <Plug>TsnyderYankToEOL
endif
nnoremap <unique> <script> <Plug>TsnyderYankToEOL y$

nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Yank\ To\ EOL<Tab>Y      <Plug>TsnyderYankToEOL

" Jump to diffs			       {{{1
if !exists("no_tsnyder_diff_hotkeys")
    if !hasmapto('<Plug>TsnyderPrevDiff')
      nmap <unique>  <Plug>TsnyderPrevDiff
    endif
    nnoremap <unique> <script> <Plug>TsnyderPrevDiff [czz

    nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Previous\ Diff<Tab><CTRL>P      <Plug>TsnyderPrevDiff

    if !hasmapto('<Plug>TsnyderNextDiff')
      nmap <unique>  <Plug>TsnyderNextDiff
    endif
    nnoremap <unique> <script> <Plug>TsnyderNextDiff ]czz

    nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Next\ Diff<Tab><CTRL>N      <Plug>TsnyderNextDiff
endif

" <Plug>TsnyderResizeVSplitToLnWid : Resize VIM window width to fit linelength {{{1
" NOTE: this does not alter the size of the X window containing vim, only the size of a vertically
" split window

if !hasmapto('<Plug>TsnyderResizeVSplitToLnWid')
  map <unique> <C-w>c <Plug>TsnyderResizeVSplitToLnWid
endif
nnoremap <unique> <script> <Plug>TsnyderResizeVSplitToLnWid :exec 'vertical resize '.(strlen(getline("."))+&foldcolumn)<CR>

nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Yank\ To\ EOL      <Plug>TsnyderResizeVSplitToLnWid

" Make <M-j>,<M-k>,<M-h>,<M-l> move with a count of UserBigMoveCount {{{1

if !exists("UserBigMoveCount")
   let UserBigMoveCount = 5
endif

exec 'nmap <M-j> '.UserBigMoveCount.'j'
exec 'nmap <M-h> '.UserBigMoveCount.'h'
exec 'nmap <M-k> '.UserBigMoveCount.'k'
exec 'nmap <M-l> '.UserBigMoveCount.'l'


" <Plug>TsnyderGoToFile : normal gf -- use :drop instead of :e     {{{1
if !hasmapto('<Plug>TsnyderGoToFile')
  map <unique> gf <Plug>TsnyderGoToFile
endif
noremap <unique> <script> <Plug>TsnyderGoToFile :drop <cfile> <CR>

noremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.GoTo\ File\ Under\ Cursor      <Plug>TsnyderGoToFile
														  
" <Plug>TsnyderSplitGoToFile -- :call SplitDrop(<cfile>) instead of :e that f uses   {{{1
if !hasmapto('<Plug>TsnyderSplitGoToFile')
   " TODO should these be nmaps?
  " NOTE: this should really be mapped to ^Wf by default
  map <unique> gsf <Plug>TsnyderSplitGoToFile
endif
noremap <unique> <script> <Plug>TsnyderSplitGoToFile :Sdrop <cfile><CR>

noremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Split,\ Then\ GoTo\ File\ Under\ Cursor      <Plug>TsnyderSplitGoToFile
" Trick drop into always splitting a new window		{{{2
function! SplitDrop(file) range			"{{{3
    " Bram drastically undercuts the usefulness of :drop, sometimes, I'd like it to split
    " and open an existing open copy of the file if one exists instead of closing out the current
    " If there isn't a file in the current buffer, just close it and then drop.
    if bufname("") == ''
	normal :q<CR>
	exec 'drop '.a:file
    else 
	" Use modified tag to trick drop into always splitting new window
	let tmp=&modified 
	let bn=bufnr("") 
	set modified 
	exec 'drop '.a:file
	call setbufvar(bn,"&mod", tmp)
    endif
endfunction
"}}}
command! -nargs=1 -complete=file Sdrop call SplitDrop(<f-args>)




" Reinitialize Perl Module -- doesn't work quite right  {{{1
"if has('perl') && filereadable(s:UserPerlBin.'/Tsnyder/VIM.pm')
    "map rs  :call UsePerl()<CR>
"endif

" Perl/Programming Macros -- Begin with   {{{1
" ============================================
"

" Timestamp Macros     {{{1
" ========================================
"let s:saveleader = mapleader
"let mapleader = "<C-k>"
if !exists("no_tsnyder_timestamp_hotkeys")
   " User, date and time appended at current cursor location
   map! ut     - =$USER<CR> =strftime("%d-%b-%y %H:%M")<CR>
    "map ut   a - =$USER<CR> =strftime("%d-%b-%y %H:%M")<CR><ESC>? - <CR>
   " User and date appended at current cursor location
   map! ud     - =$USER<CR> =strftime("%d-%b-%y")<CR>
    "map ud   a - =$USER<CR> =strftime("%d-%b-%y")<CR><ESC>? - <CR>
   " Date and time appended at current cursor location
   map! t     - =strftime("%d-%b-%y %H:%M")<CR>
    "map t   a - =strftime("%d-%b-%y %H:%M")<CR><ESC>? - <CR>
   " Date appended at current cursor location
   map! d     =strftime("%d-%b-%y")<CR>
    "map d   a =strftime("%d-%b-%y")<CR><ESC>
 endif "timestamps
 "let mapleader = s:saveleader

"}}}
" Scroll Window			       {{{1

if !exists("no_tsnyder_scroll_hotkeys")

    "BOZO this doesn't work

   if !hasmapto('<Plug>TsnyderScrollRelocateRedrawWin')
     map <unique> <C-.> <Plug>TsnyderScrollRelocateRedrawWin
     let s:menu_accel = '^\.'
   else 
      " TODO find out what it is and set the menu text
      let s:menu_accel = 'USER_SPECIFIED'
   endif
   nnoremap <unique> <script> <Plug>TsnyderScrollRelocateRedrawWin :redraw <CR>

   exec "nnoremenu <script> Plugin.Tim\\ Snyder's\\ Hotkeys.Redraw\\ Window\\ (moved\\ from\\ ^L)<Tab>".s:menu_accel."  <Plug>TsnyderScrollRelocateRedrawWin"

   if !hasmapto('<Plug>TsnyderScrollWinLeft')
     map <unique> <C-h> <Plug>TsnyderScrollWinLeft
   endif
   nnoremap <unique> <script> <Plug>TsnyderScrollWinLeft zh
   nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Scroll\ Window\ Left      <Plug>TsnyderScrollWinLeft

   if !hasmapto('<Plug>TsnyderScrollWinUp')
     map <unique> <C-k> <Plug>TsnyderScrollWinUp
   endif
   nnoremap <unique> <script> <Plug>TsnyderScrollWinUp 
   nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Scroll\ Window\ Up      <Plug>TsnyderScrollWinUp

   if !hasmapto('<Plug>TsnyderScrollWinDown')
     map <unique> <C-j> <Plug>TsnyderScrollWinDown
   endif
   nnoremap <unique> <script> <Plug>TsnyderScrollWinDown 
   nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Scroll\ Window\ Down      <Plug>TsnyderScrollWinDown

   if !hasmapto('<Plug>TsnyderScrollWinRight')
     map <unique> <C-l> <Plug>TsnyderScrollWinRight
   endif
   nnoremap <unique> <script> <Plug>TsnyderScrollWinRight zl
   nnoremenu <script> Plugin.Tim\ Snyder's\ Hotkeys.Scroll\ Window\ Right      <Plug>TsnyderScrollWinRight

endif

" Enclose visually selected text in grouping characters	   {{{1

" Parens						{{{2
vmap <Space>(  <Esc>`<i(<Esc>`>la)<Esc>
vmap <Space>)  <Esc>`<i(<Esc>`>la)<Esc>
" brackets					{{{2
vmap <Space>[  <Esc>`<i[<Esc>`>la]<Esc>
vmap <Space>]  <Esc>`<i[<Esc>`>la]<Esc>
" braces					{{{2
vmap <Space>{  <Esc>`<i{<Esc>`>la}<Esc>
vmap <Space>}  <Esc>`<i{<Esc>`>la}<Esc>
" angle brackets				{{{2
vmap <Space><  <Esc>`<i<<Esc>`>la><Esc>
vmap <Space>>  <Esc>`<i<<Esc>`>la><Esc>
" single quotes					{{{2
vmap <Space>'   <Esc>`<i'<Esc>`>la'<Esc>
" escaped single quotes				{{{2
vmap <Space>\'  <Esc>`<i\'<Esc>`>2la\'<Esc>
" double quotes					{{{2
vmap <Space>"   <Esc>`<i"<Esc>`>la"<Esc>
" escaped double quotes				{{{2
vmap <Space>\"  <Esc>`<i\"<Esc>`>2la\"<Esc>
						"}}}2
						
" Make // do search for visually selected text instead of expanding selection to search match {{{1
" By default hitting / while in visual mode allows you to search as normal and
" Vim expands your selection to what is found.  Sometimes, you just want to
" highlight something and search for what is highlighted
vmap  // y/<C-R>"<CR>
"}}}

let &cpo = s:save_cpo
