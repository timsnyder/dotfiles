" Vim filetype plugin customization file
" Language:	Verilog HDL
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 14-Apr-09 16:12 

" override Chih-Tsun's limit of 78 chars in comments
"setlocal tw=100

" setup the 'define' option so we can use [i, ]i, [d, ]d searches
setlocal define=^\\s*`define
setlocal include=^\\s*`include

" Tired of RPL complaining about TABS in verilog.  Set expandtab
setlocal expandtab

" Configure window cleanup var
if !exists("b:undo_ftplugin")
   let b:undo_ftplugin = ''
endif
let b:undo_ftplugin=b:undo_ftplugin." | setlocal define< include< expandtab< | "
