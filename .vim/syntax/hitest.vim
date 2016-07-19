" Vim syntax file
" Language:	none; used to see highlighting
" Maintainer:	Ronald Schild <rs@scutum.de>
" Last Change:	2001 Sep 02
" Version:	5.4n.1

" To see your current highlight settings, do
"    :so $VIMRUNTIME/syntax/hitest.vim

" save global options and registers
let s:hidden      = &hidden
let s:lazyredraw  = &lazyredraw
let s:more	  = &more
let s:report      = &report
let s:shortmess   = &shortmess
let s:wrapscan    = &wrapscan
let s:statusline  = &statusline	"added - tsnyder 25-Jul-05
let s:register_a  = @a
let s:register_se = @/

let s:statText=''

set statusline=%{'Loading\ Highlight\ Color\ Test'}%=%{s:statText}

"set global options
set hidden lazyredraw nomore report=99999 shortmess=aoOstTW wrapscan

let s:statText="print current highlight settings into register a"
"redrawstatus
redir @a
"again, don't echo stuff to screen - tsnyder 25-Jul-05
silent highlight
redir END

"Open a new window if the current one isn't empty
if line("$") != 1 || getline(1) != ""
  new
endif

"edit temporary file
edit Highlight\ test

"set local options
setlocal autoindent noexpandtab formatoptions=t shiftwidth=16 noswapfile tabstop=16
let &textwidth=&columns

let s:statText="insert highlight settings"
"redrawstatus
% delete
put a

let s:statText="remove the colored xxx items"
"redrawstatus
silent g/xxx /s///e

" remove color settings (not needed here)
"global! /links to/ substitute /\s.*$//e

let s:statText="move linked groups to the end of file"
"redrawstatus
silent global /links to/ move $

let s:statText="move linked group names to the matching preferred groups"
"redrawstatus
silent % substitute /^\(\w\+\)\s*\(links to\)\s*\(\w\+\)$/\3\t\2 \1/e
silent global /links to/ normal mz3ElD0#$p'zdd

let s:statText="delete empty lines"
"redrawstatus
silent global /^ *$/ delete

let s:statText="precede syntax command"
"redrawstatus
silent % substitute /^[^ ]*/syn keyword &\t&/

let s:statText="execute syntax commands"
"redrawstatus
syntax clear
" shouldn't have to echo all this crap to the screen as we build the file, it is probably slowing
" things way way down - tsnyder 25-Jul-05
% yank a
silent @a

let s:statText="remove syntax commands again"
"redrawstatus
silent % substitute /^syn keyword //

let s:statText="pretty formatting"
"redrawstatus
silent global /^/ exe "normal Wi\<CR>\t\eAA\ex"
silent global /^\S/ join

let s:statText="find out first syntax highlighting"
"redrawstatus
let b:various = &highlight.',:Normal,:Cursor,:,'
let b:i = 1
while b:various =~ ':'.substitute(getline(b:i), '\s.*$', ',', '')
   let b:i = b:i + 1
   if b:i > line("$") | break | endif
endwhile

let s:statText="insert headlines"
"redrawstatus
call append(0, "Highlighting groups for various occasions")
call append(1, "-----------------------------------------")

if b:i < line("$")-1
   let b:synhead = "Syntax highlighting groups"
   if exists("hitest_filetypes")
      redir @a
      "don't echo everything to screen - tsnyder 25-Jul-05
      let
      redir END
      silent let @a = substitute(@a, 'did_\(\w\+\)_syn\w*_inits\s*#1', ', \1', 'g')
      silent let @a = substitute(@a, "\n\\w[^\n]*", '', 'g')
      silent let @a = substitute(@a, "\n", '', 'g')
      silent let @a = substitute(@a, '^,', '', 'g')
      if @a != ""
	 let b:synhead = b:synhead." - filetype"
	 if @a =~ ','
	    let b:synhead = b:synhead."s"
	 endif
	 let b:synhead = b:synhead.":".@a
      endif
   endif
   silent call append(b:i+1, "")
   silent call append(b:i+2, b:synhead)
   silent call append(b:i+3, substitute(b:synhead, '.', '-', 'g'))
endif

" remove 'hls' highlighting
nohlsearch
normal 0

" add autocommands to remove temporary file from buffer list
aug highlighttest
   au!
   au BufUnload Highlight\ test if expand("<afile>") == "Highlight test"
   au BufUnload Highlight\ test    bdelete! Highlight\ test
   au BufUnload Highlight\ test endif
   au VimLeavePre * if bufexists("Highlight test")
   au VimLeavePre *    bdelete! Highlight\ test
   au VimLeavePre * endif
aug END

" we don't want to save this temporary file
set nomodified

" the following trick avoids the "Press RETURN ..." prompt
0 append
.

let s:statText="restore global options and registers"
"redrawstatus
let &hidden      = s:hidden
let &lazyredraw  = s:lazyredraw
let &more	 = s:more
let &report	 = s:report
let &shortmess	 = s:shortmess
let &wrapscan	 = s:wrapscan
let @a		 = s:register_a
let &statusline=s:statusline

call histdel("search", -1)
let @/ = s:register_se


" remove variables
unlet s:hidden s:lazyredraw s:more s:report s:shortmess
unlet s:wrapscan s:register_a s:register_se
unlet s:statText s:statusline

" vim: ts=8
