
" Vim filetype detection plugin file
" Language:	Add-on to verilog file detection for design checks
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 19-Jan-09 11:36 

" vim thinks .lib files are cobol but the ones I look at 
" are much more like verilog. cobol colors them all with ERROR
" - tsnyder 19-May-06
autocmd BufRead *.lib  set filetype=verilog
autocmd BufRead *.tpl  set filetype=verilog


