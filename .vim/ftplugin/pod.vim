" Vim filetype plugin file
" Language:	Perl POD documentation
" Maintainer:	Tim Snyder <tim.snyder@amd.com>
" Last Change:  tsnyder 06-Nov-05 14:32 
" Modeline: vim: fdm=marker fdc=2

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

" Enclose visually selected text in grouping characters	   {{{1
"---------------------------------------------
 
" Perlpod [IBSCLFXEZ]<> formatting block			{{{2
let s:pod_blocks = 'IBSCLFXEZ'
while s:pod_blocks != ''
   let s:pblock = tolower(strpart(s:pod_blocks,0,1))
   let s:pBLOCK = toupper(strpart(s:pod_blocks,0,1))
   if !hasmapto('<Plug>pod_'.s:pBLOCK.'Block')
      "echom 'vmap <buffer> <unique> <LocalLeader> '.s:pblock.' <Plug>pod_'.s:pBLOCK.'Block'
      exec 'vmap <buffer> <unique> <LocalLeader>'.s:pblock.' <Plug>pod_'.s:pBLOCK.'Block'
   endif
   exec 'silent! noremap <buffer> <unique> <Plug>pod_'.s:pBLOCK.'Block <Esc>`<i'.s:pBLOCK.'<<Esc>`>2la><Esc>'
   let s:pod_blocks = strpart(s:pod_blocks,1)
endwhile

						"}}}1
" Insert commonly used structures	   {{{1
"--------------------------------

" Function to make sure there is at least one blank line before and after current line "{{{2
function! <SID>DoubleSpace()	    range

   let cnt     = a:lastline - a:firstline + 1
   echo "cnt:".cnt
   exec "normal ".a:firstline."zz"
   while cnt > 0
     let ln = line(".")
     if ln == 1 || getline(ln-1) !~ "^\s*$" 
	exec "normal O\<Esc>j"
     endif
     if ln == line("$") || getline(ln+1) !~ "^\s*$" 
	exec "normal o\<Esc>j"
     else
	normal j
     endif
     let cnt = cnt - 1
   endwhile
endfunction    
" Insert a "=over 4 =back" block {{{2
if !hasmapto('<Plug>pod_InsertOverBack')
   "echom 'vmap <buffer> <unique> <LocalLeader> '.s:pblock.' <Plug>pod_'.s:pBLOCK.'Block'
   map <buffer> <unique> <LocalLeader>po <Plug>pod_InsertOverBack
endif
silent! noremap <buffer> <unique> <Plug>pod_InsertOverBack o=over 4<CR>=item *<CR>TRSMARK<CR>=back<Esc>:?^=over<CR>:.,/^=back/call <SID>DoubleSpace()<CR>:?^TRSMARK<CR>D

" Insert a arg =item in pod		{{{2
if !hasmapto('<Plug>pod_InsertArg')
   map <buffer> <unique> <LocalLeader>pa <Plug>pod_InsertArg
endif
silent! noremap <buffer> <unique> <Plug>pod_InsertArg o=item $_[0] : [0<Bar>1<Bar><string>] (optional) (default:0)<CR>TRSMARK<Esc>:?^=item<CR>:.,/^/call <SID>DoubleSpace()<CR>:?^TRSMARK<CR>C

"}}}1

" Undo the stuff we changed.
let b:undo_ftplugin = "mapclear <buffer>"


" Restore the saved compatibility options.
let &cpo = s:save_cpo



