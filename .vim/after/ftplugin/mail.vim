" VIM Filetype Plugin Additions 
" Author: tsnyder 
" Language: mail 
" Last Modified: tsnyder 12-Dec-07 20:14 

" Make mail usage recognize numbered lists
setl formatoptions+=n

" make textwidth 75 even though I like it larger for most other things
setl tw=75

" Set up comment format option to unerstand a variety of bulleted lists
" instead of 
setl com=fb\:*,fb\:-,fb\:#,fb\:>

setl spell spelllang=en_us

let b:undo_ftplugin = b:undo_ftplugin." | setl com< fo< tw<"
