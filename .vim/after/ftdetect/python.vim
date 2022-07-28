
" Vim filetype detection plugin file
" Language:	Add-on to Python file detection for girder files
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	centos 15-Mar-22 04:38 

autocmd BufRead *.girder  set filetype=python
autocmd BufRead *.pyi  set filetype=python

