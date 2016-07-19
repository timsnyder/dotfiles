" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\ 
" Last Modified: tsnyder 19-Jul-16 07:16 
" Note: If you are totally lost with folding turned on, type 'zi' in Normal mode
"	or do Tools->Folding->Enable/Disable Folding in GUI menus

" This is the file where I'm putting all option settings that are specific for me

" try taking winsize out of sessionoptions to see if that fixes the goofyness with gvim under
" fluxbox
"
" It doesn't, I don't ever use :mksession and that's what uses sessionoptions
"set sessionoptions-="winsize"

" someone is jacking with $VIM/vimrc and causing the filetype detection scripts to be loaded before
" my path is setup and then my personal detection shit doesn't get loaded.  This is ugly but will
" have the effect of resettign filetype detection so that all of the scripts are loaded again:
"unlet did_load_filetypes


runtime tsnyder_vimrc.vim


let load_boilerplate = 1

" set spelling to use my personal word file too
set spellfile=/home/tsnyder/.vim/myvimwords.latin1.add

" turn off the folding in AMD_v9 syntax highlighting to see if v9 loads faster
let AMD_v9Syntax_no_fold = 1

" turn off matchparen by default
"let loaded_matchparen=1

" include Perl in system verilog files. May want to make a seperate preperl type at somepoint
" though.
let verilog_include_perl = 1

let sv_fold = 1
"let verilog_fold = 1

" try turning off smartindenting
set nosmartindent

" try to make folding a little more friendly
set foldminlines=10

au BufReadPost * if &foldlevel == 0 | set foldlevel=1 | endif

" Make the AMD_v9 filetype functions quiet down a bit
" BOZO don't think that I have this set right.  need to make it b:?  
"      need to look at the variable resolution protocol again soon - tsnyder 15-Dec-05
let AMD_v9Quiet = 1

" Make <F8> do pedit on the file under the cursor and the line number that is after the file
function! <SID>PreviewError() range
  let line=getline(".")
  let col=col(".")
  let lazyredraw=&lazyredraw  "force the screen to not be redrawn now to avoid possible jumpiness
  set lazyredraw

  let errline = matchstr(line, '\f*.\{-}\zs\d\+', col)

  exec "pedit +".errline." ".expand("<cfile>")

  normal w

  let &lazyredraw=lazyredraw
endfunction
nmap <F8> :call <SID>PreviewError()<CR>


" Internal VIM path -- used for gf, [f, ]f, ^Wf, :find, etc.	{{{1
" ==============================================================
"set path=./**3
set path+=$HOME
set path+=$VIMRUNTIME

" ABBREVIATIONS							{{{1
" =============

" Don't jump to the first error in the quickfix :make command
"cabbr make make!

" Why can't I ever remember to type the whole damn thing??
cabbr  regs  registers

" Catch command spelling mistakes or shorten commonly typed ones {{{2
cabbrev bs sb
cabbrev cdm cd %:h
cabbrev lcdm lcd %:h

" Adjust Colors	To My Liking				         {{{2
" ==========================
" Look in $VIMRUNTIME/colors/tsnyder.vim for all these settings
colorscheme tsnyder


" OPTIONS											 {{{1
" =======
" I am trying out 'hlsearch' because I've decided it is useful   
" It is annoying that it also highlights stuff when you do a search and replace and some other
" commands.  I think that I like it default off.
" TODO maybe making the backgroud dark grey instead of high-intensity yellow
"      would be more useful and not so annoying when it does highlight a crapload of stuff.
set nohlsearch

" Make <Esc> in normal mode do :nohls to clear search highlighting
" This is useful but it breaks something in my startup so that I 
" end up in oper-waiting mode and moving will delete the moved-across 
" text... not good at all!
" nmap <Esc> :nohls<CR>

" AUTOCOMMANDS											 {{{1
" ============
" Don't screw up colors when you do BufRead because of :r of something				 {{{2
" TODO this isn't the best way to fix this, still flickers like crazy in certain instances
au FileReadPost  * colorscheme tsnyder

" Make syn.log be of type conf... just my preference, makes it easier to read and I'm tired of   {{{2
" typing it - tsnyder 02-Jun-06
au BufRead syn.log,pc*.log set filetype=conf

" Do the initial formatting of fcb.log for me because I'm really tired of doing this junk every time {{{2
" I open it so that I can use the 'gf' normal command
function! <SID>FCB_log_cleanup() range
  let lazyredraw=&lazyredraw  "force the screen to not be redrawn now to avoid possible jumpiness
  set lazyredraw

  let dir=expand("%:p:h")              "get the full path of the directory that the fcb.log is now in
  let buildname=fnamemodify(dir, ":t") "want to just look at the last dir before the fcb.log

  " _building -> _stalled
  " _building -> _building_failed
  " _building -> ''
  let repl=matchstr(buildname, '_\(stalled\|building_failed\)')

  "echom "repl string '".repl."'"

  exec 'silent %s/_building/'.repl.'/g'
  1  "make sure you are at the top of the buffer

  let &lazyredraw=lazyredraw
endfunction

au BufRead fcb.log :call <SID>FCB_log_cleanup()


"}}}1

" Adjust Keyboard Map In Ways That Are More Personal Preferance Than Adding Functionality        {{{1
" =======================================================================================

" Make <F1> another escape key because I never use it to open the help and my fingers are fat {{{2
map! <F1> <Esc>

" Make <PageUp> another backslash key when in insert mode because I'm sick of hitting it and I never {{{2
" page up in insert mode
imap <PageUp> \

" Do something similar with <Home> {{{2
imap <Home> <Backspace>
												"}}}

map + <Plug>NumericAdd
map - <Plug>NumericSubtract

" Fluxbox Specific Adjustments									{{{1
" ============================
" Add pointer callback preferance 'p' to see if that fixes focus issues with fluxbox - tsnyder 22-Jul-05  {{{2
set guioptions+=p	 

