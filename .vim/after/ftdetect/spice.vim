
" Vim filetype detection plugin file
" Language:	Add-on to spice file detection
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 16-Oct-08 10:30 

" There are all kinds of funky extensions at AMD that mean spice
autocmd BufRead *.spi             set filetype=spice
autocmd BufRead *.cnet            set filetype=spice
autocmd BufRead *.cnet.commented  set filetype=spice
autocmd BufRead *.dspf            set filetype=spice
