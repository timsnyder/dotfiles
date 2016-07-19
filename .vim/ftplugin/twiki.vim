" Vim filetype plugin file
" Language:	TWiki markup
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 10-Oct-07 17:58 

" Set 'compatability' to Vim default so I can span lines in b:undo_ftplugin def
let s:save_cpo = &cpo
set cpo&vim

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
   echoerr "Already did a ftplugin"
  finish
endif

" Only do this $USER hasn't already done it with their own version earlier in 'runtimepath'
if exists("b:loaded_twiki")
   echoerr "TWiki loaded already"
  finish
endif
let b:loaded_twiki = 1

" Don't load another plugin for this buffer
let b:did_ftplugin = 1


" Add mappings, unless the user didn't want this.
if !exists("no_plugin_maps") && !exists("no_twiki_maps")
endif

" Add mappings, unless the user didn't want this.
if !exists("no_plugin_commands") && !exists("no_twiki_commands")
endif

" set the shiftwidth to 3 and don't swap in tab characters for 8 spaces
" so that it is easy to increase/decrease the indent for lists
setlocal shiftwidth=3
setlocal expandtab

"setlocal wrap
setlocal formatoptions+=t

setlocal comments=b:1.,b:*

" Tell Vim how to undo the effects of this ftplugin
" remember that b:did_ftplugin is implicitly unlet'ted when Vim
" executes b:undo_ftplugin
let b:undo_ftplugin = "setlocal wrap< shiftwidth< expandtab< formatoptions< comments<"
		\ . "| unlet b:loaded_twiki"

let &cpo = s:save_cpo
