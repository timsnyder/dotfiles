" Vim support file to augment the default menus
"
" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\ 
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 15-Dec-05 10:33 

" Note that ":an" (short for ":anoremenu") is often used to make a menu work
" in all modes and avoid side effects from mappings defined by the user.

" Make sure the '<' and 'C' flags are not included in 'cpoptions', otherwise
" <CR> would not be recognized.  See ":help 'cpoptions'".
let s:cpo_save = &cpo
set cpo&vim

" Map <F2> to showing me what syntax group is under the cursor {{{1
" TODO there might be transparent groups and you might want to know linking
"      and all that stuff
" TODO probably want this <F2> mapping in tsnyder_hotkeys to be independant of whether or not the
"      user is using the GUI and gets the menu or not
nmap <F2> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
an 50.800 &Syntax.-SEP3-		<Nop>
an 50.810 &Syntax.Echo\ Syn\ &Group\ Under\ Cursor<Tab>F2   :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>


" Restore the previous value of 'cpoptions'.  {{{1
let &cpo = s:cpo_save
unlet s:cpo_save
