" VIM Syntax File Additions
" Author: tsnyder
" Language: vim
" Last Modified: tsnyder 01-Aug-05 08:18 
" Make single line perl commands be colored correctdly for perl
syn region vimPerlRegion matchgroup=vimScriptDelim start=+\(pe\%[rldo]\)\@<=\s+ end=+$+ contains=@vimPerlScript
