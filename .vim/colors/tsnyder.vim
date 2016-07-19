" Vim color file
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 16-Jul-16 12:22 

" This is the color scheme that I use.  I have them all in here just to get them out of my .vimrc
" - tsnyder 06-Nov-05

" Force xterm to only use 8 colors   {{{3
" Needs to be done before turning syntax on if done at all
" I don't think I need it - tsnyder 22-Jul-05
" The termcap entry for xterm is set right on my current system
" But if you set it higher, things do get all crazy
" I think that you could set TERM to xterm-color and maybe get better behavior
" I don't care too much though, I normally use the gui...
if &term =~ "xterm"
    if has("terminfo")
	set t_Co=8
	set t_Sf=[3%p1%dm
	set t_Sb=[4%p1%dm
    else
  	set t_Co=8
  	set t_Sf=[3%dm
  	set t_Sb=[4%dm
    endif
endif

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Always use reverse white on black for gui mode 
set background=dark


" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif


" Use something 'off-white' for normal text so it isn't so burning bright  
highlight Normal     guibg=Black guifg=WhiteSmoke ctermbg=0

" Make Todo not so bright
highlight Todo	     guifg=Black guibg=Yellow2 gui=bold

" Use something 'off-white' for the status bar so I don't end up with horizontal lines burned in my retnas ;)  
" Remember 'reverse' is set by default for both StatusLine highlight groups
highlight StatusLine     guibg=Black guifg=#b0b0b0
highlight VertSplit      guibg=Black guifg=#b0b0b0
highlight StatusLineNC   guibg=Black guifg=#858585


" Make the Folded Highlighting easier to see than the default cyan on light grey 
" Mainly concerned about GUI, it's cyan on black in cterm
highlight Folded     guibg=Black guifg=green
highlight FoldColumn guibg=Black guifg=green

" Make diff coloring the same as tkdiff in the GUI
highlight DiffAdd	guibg=PaleGreen	     guifg=Black gui=bold
highlight DiffChange	guibg=LightSteelBlue guifg=Black
highlight DiffDelete	guibg=Tomato	     guifg=Black gui=bold
highlight DiffText	guibg=DodgerBlue     guifg=Black gui=bold

if v:version >= 700
  " Make ins-completion-menu Not Magenta... damn that's gross
  highlight Pmenu	ctermfg=Black ctermbg=LightGray guibg=Grey
  highlight PmenuSel	ctermfg=Yellow ctermbg=DarkGray  guibg=DarkGrey gui=bold
endif



let colors_name = "tsnyder"

" vim: sw=2
