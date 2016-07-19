" Vim filetype plugin customization file
" Language:	HTML
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 30-Apr-09 15:38 

" Spell checking for HTML files is really good.
setl spell

" Configure window cleanup var
if !exists("b:undo_ftplugin")
   let b:undo_ftplugin = ''
endif
let b:undo_ftplugin=b:undo_ftplugin." | setlocal spell< | "
