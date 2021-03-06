" VIM Configuration File
" Author:   Tim Snyder <tim.snyder@amd.com>
" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\ 
" Last Modified: tsnyder 18-Feb-09 12:22 
" Note: If you are totally lost with folding turned on, type 'zi' in Normal mode
"	or do Tools->Folding->Enable/Disable Folding in GUI menus
"    TODO List	{{{1
"	 This has been refactored into doc/tsnyder_vimrc.txt.  I don't want to maintain this in two
"	 places  
"   Here is an example of hacking the results of foldtext() with substitute though...
"     should probably move this to ~tsnyder/.vim/after/ftplugin/vim.vim    {{{2
"      im:fdc=2:fml=1:fdm=marker:foldtext=substitute(substitute(foldtext(),'^.*\:','','g'),'".*','',''):fcs=fold\:\ :hl=f-
" DONE {{{2 
"	* Make SplitDrop() check to see if the current window actually has a buffer loaded in it and
"	  that it isn't "no file" - tsnyder 25-Jul-05 10:07
"}}}

" VIMRC Parameters		    {{{1
" ================
" If you set these in your .vimrc, your value will be used because your script is sourced after
" ~tsnyder/rel/vim/.vimrc.
let g:AlwaysToDoKeywords = 'TODO TODO: ToDo: !ACK! XXX !ACHTUNG! WARNING FIXME FIXME: KnownBug: KnownBugs: KnownBug KnownBugs:'


" TODO these should be overridable by user .vimrc but they currently aren't - tsnyder 08-Nov-05
let g:UserPerlBin='/home/tsnyder/src/perl'
let g:UserTemplates='/home/tsnyder/src/templates'

let s:UserBigMoveCount = 5



" VIM Plugins			    {{{1
" ============
" Source global plugins that are NOT in $VIMRUNTIME/plugin for whatever reason {{{2
"
" Define User Command :Man that will open manpages in a new window
" The Man plugin in included in the man filetype plugin and is loaded the first
" time that you load a man page, Sourcing it now, enables :Man without having to load a manpage
" by some other method first 
"
" I accompany this with an alias in my shell to allow viewing manpages with vim
" alias Man	'gvim +"Man \!*" +only'		# capital man uses gvim to load the manpage for syntax coloring
runtime! ftplugin/man.vim

" VIM Syntax Coloring Plugin Parameters	    {{{2
" =====================================
" NOTE: this slows down loading of large perl scripts 
"       but I think the advantages outweigh the costs
"       by large I mean > ~5000 lines of code
let perl_include_pod		    = 1
let perl_want_scope_in_variables    = 1
let perl_extended_vars		    = 1
let perl_fold			    = 1
let perl_fold_blocks		    = 1

" Make NERD_commenter.vim left align all filetype's comments {{{2
let NERD_left_align_regexp = ".*"
let NERD_right_align_regexp = ".*"

" Resolve conflicting mappings between NERD_commenter.vim and cvscommand.vim {{{2
" I'm fixing this for now by disabling all of the cvscommand default mappings 
" can always go back and selectively add mappings back in that I want
let g:no_cvscommand_default_mappings = 1

" Selectively Disable Certain VIM Plugins	      		    {{{2
" =======================================
" Don't source any of the default global plugins, Explorer, ToHtml, etc...
" set noloadplugins

" Don't load tsnyder's boilerplate.vim
" let loaded_boilerplate=1

" Don't load tsnyder's Hotkeys
" let loaded_tsnyder_hotkeys=1
" Don't source tsnyder's AMD_px filetype plugin
" let loaded_AMD_px

" Don't source tsnyder's AMD_v9 filetype plugin
" let loaded_AMD_v9

" VIM Option Initialization	    {{{1
" =========================

" Case Sensitivity in Searches	    {{{2
" ============================

set ignorecase
set smartcase


" Folding			{{{2
" =======

" Default to syntactic folding instead of manual
set foldmethod=syntax

" Always leave folds smaller than &foldminlines open
"set foldminlines=5

" Make closed folds not be filled with '-' because that makes folded text hard to read
" Note the <Space> that is escaped for fold:
set fillchars=fold:\ 

" If syntax is detected, add column for folding, otherwise, don't, prevents black folding column on
" cterm background
if exists("b:current_syntax")
    set foldcolumn=2
endif

" Formatting and Appearance		    {{{2
" =========================

set formatoptions=tcqorb "tried 'a' but it sucks lines into end of line comments added 'ab' flags - tsnyder 22-Jul-05
set guioptions=agimr

set textwidth=100

" Let vim relax a bit when running scripts and macros, also cuts down on the flicker factor
set lazyredraw

" Don't wrap lines that are longer than the screen
set nowrap
" If I do decide to wrap, then make the lines brake at spaces and otherplaces that make sense
set linebreak

" In insert mode, allow backspacing lines together and initial indentation
set backspace=indent,eol

" Turn on syntax coloring, filetype plugins and filetype intenting {{{3
" ================================================================
syntax enable	    "subtle difference between syntax on and syntax enable - see :help sy
filetype plugin indent on  
				 "}}}


" History		      {{{2
" =======
set history=100		      " keep a lot of command line history (keeps me from getting overzealous with functions, commands, and scritpts...)


" Mapping {{{2
"
" set winaltkeys to no so that Alt keycombos can be mapped as hotkeys without worrying about the  
" GUI menu interfearing with this.  I don't use the menu that much anyway.
set winaltkeys=no

                                           
					    
" Mouse				    {{{2
" =====
" Enable mouse for xterm
set mouse=a

" Status Bar			{{{2
" ==========
 
" Always have a status bar at the bottom even if there is just one window
set laststatus=2
" Put position information in the statusline
set ruler
" Allow windows to be squeezed down to their statusbar
set winminheight=0

" Tabbing and Indentation	    {{{2
" =======================

set smarttab
set softtabstop=3
set shiftwidth=3

set autoindent
set smartindent


" Window Title			{{{2
" ============
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" Depricated vi Opts		{{{2
" ==================
" These first three are Old Schooly Unix Vi options that were set when I inherited this .vimrc 
" I don't have a clue what they do in real Vi but the vim help says they don't do anything in vim.
" - tsnyder 22-Jul-05
set autoprint 
set optimize
set redraw
				"}}}
				
			
" User Functions		{{{1
" ==============
 
function! VarExists(var, val, ...)			"{{{2
   " Do the standard gimme the variable if it exists or just an empty string otherwise
    if exists(a:var) 
	return a:val 
    elseif a:0 != 0
	return a:1
    else
	return '' 
    endif
endfunction
						"}}}
" Stubs for User Functions Requiring has('perl') {{{2
    let s:PerlFunc="ShowINC ShowMain UsePerl ColOrder SetCws Banner PinSplit ColSplit"
    let s:start=0
    while 1
	let s:Fun=matchstr(s:PerlFunc, '\w+', s:start)
	if s:Fun == ""
	    break
	else
	    exec 'function!' s:Fun '(...) range | echoerr' s:Fun "requires has('perl') which " v:version/100 "doesn't have | endfunction"
	    let s:start=matchend(s:PerlFunc, '\w+', s:start)
	endif
    endwhile


function! TermSyntaxColoring() range	"{{{2
    "Set up all the coloring so syntax is legible on terminal emulators, called by au FileType *
    "Reverse video so colors are easy to read when filetype is detected
    highlight Normal ctermbg=Black ctermfg=LightGrey 
    "Don't use bold text for everything.  That is really hard to read...
    highlight Statement   cterm=NONE
    highlight Constant    cterm=NONE
    highlight Comment     cterm=NONE
    highlight Identifier  cterm=NONE
    highlight Type        cterm=NONE
    highlight Special     cterm=NONE
    "Use dark blue for comments and stuff and use cyan for preProc in terminal
"    highlight Comment ctermfg=4
    highlight PreProc     ctermfg=6
endfunction

function! <SID>ColorX11RgbTxt() range		"{{{2
    " XXX I spent way too much time trying to get this to work in Aug 2005, it fills the colormap
    "     and then starts doing goofy ass stuff for the rest of the colors.  At some point it would
    "     be cool to learn more about how X handles colors and get this working but as you are about
    "     to see from this comment, it has been a couple months and I haven't done it yet
    "     - tsnyder 06-Nov-05
    " TODO if I ever care about portability, make it check to make sure we are on X not something
    " else
    if &term != 'builtin_gui'
	echoerr "All X11 colors can only properly be displayed in the GUI, do :gui first!"
	return
    endif
    if !has('perl')
	echoerr "This command requires vim be compiled with perl_interface. It seems to be missing."
	return
    endif
    let colorfile = "/usr/lib/X11/rgb.txt"
    "let colorfile = "/home/tsnyder/rgb.txt"
    if !filereadable(colorfile)
	echoerr "Can't find colorfile:".colorfile
	return
    endif

    silent call SplitDrop(colorfile)

    " save global options and registers
    let s:hidden      = &hidden
    let s:lazyredraw  = &lazyredraw
    let s:more	      = &more
    let s:report      = &report
    let s:shortmess   = &shortmess
    let s:wrapscan    = &wrapscan

    " set global options
    set hidden lazyredraw nomore report=99999 shortmess=aoOstTW nowrapscan

    " set local options
    setlocal bt=nofile "not going to save this stuff back to non-writable file so just don't worry if user makes changes, just don't let them write it
    setlocal noro
    file X11ColorPallet
    "sort the color file by colorname ignoring case
    2,$!/tool/pandora/bin/sort -un -k1,1 -k2,2 -k3,3
    " TODO stopped here !!!! - tsnyder 25-Jul-05 01:40
    " while search("^\v\s*\d{3}\s+\d{3}\s+\d{3}\s+\w+$","W")  
    " won't match colors with spaces but they are all duplicates anyway
    syntax clear
    set iskeyword+=" "
    "perldo  while (/\b(\d{1,2})\b/) { my $j = 's/\b$1\b/'.sprintf("%0.3u",$1).'/'; print "do $j\n";  eval $j } 
    perl <<
	#VIM::Msg("lineNum:".VIM::Eval('line(".")'));
	foreach my $i (2 .. $main::curbuf->Count()){
	    my $line = $main::curbuf->Get($i);
	    $line =~ s/^\s+|\s+$//g;
#	    VIM::Msg( "line:$line");
	    my @spline = split " ", $line, 4;
#	    VIM::Msg( 'spline:'.(join ",",@spline));
	    my $colNr = '#'.sprintf('%2.2x'x3,@spline[0..2]);
	    my $col = $spline[3];
	    $line = 
	    sprintf(('%0.3u 'x3).("\t%s"x6),
		    @spline[0..2],
		    $colNr,
		    $col,
		    $col.'_onWhite',
		    $col.'_onBlack',
		    'WhiteOn_'.$col,
		    'BlackOn_'.$col
		   );
	    my $gn = $col;
#	    VIM::Msg( 'gn:'.$gn);
	    $gn =~ s/\s+/_/g;
#	    VIM::Msg( 'gn:'.$gn);
	    if ($col =~ s/(?<!\\)(?=\s)/\\/g){
#		VIM::Msg( 'hi X11rgb_'.$gn.'_onWhite guifg='.$colNr.' guibg=White');
#		VIM::Msg( 'hi X11rgb_'.$gn.'_onBlack guifg='.$colNr.' guibg=Black');
#		VIM::Msg( 'hi X11rgb_WhiteOn_'.$gn.' guibg='.$colNr.' guifg=White');
#		VIM::Msg( 'hi X11rgb_BlackOn_'.$gn.' guibg='.$colNr.' guifg=Black');
#		VIM::Msg( 'syn keyword X11rgb_'.$gn.'_onWhite '.$col.'_onWhite ');
#		VIM::Msg( 'syn keyword X11rgb_'.$gn.'_onBlack '.$col.'_onBlack ');
#		VIM::Msg( 'syn keyword X11rgb_WhiteOn_'.$gn.' WhiteOn_'.$col);
#		VIM::Msg( 'syn keyword X11rgb_BlackOn_'.$gn.' BlackOn_'.$col);
#		VIM::DoCommand( 'call input("hit enter")');
	    }
	    VIM::DoCommand( 'hi X11rgb_'.$gn.'_onWhite guifg='.$colNr.' guibg=White');
	    VIM::DoCommand( 'hi X11rgb_'.$gn.'_onBlack guifg='.$colNr.' guibg=Black');
	    VIM::DoCommand( 'hi X11rgb_WhiteOn_'.$gn.' guibg='.$colNr.' guifg=White');
	    VIM::DoCommand( 'hi X11rgb_BlackOn_'.$gn.' guibg='.$colNr.' guifg=Black');
	    VIM::DoCommand( 'syn match X11rgb_'.$gn.'_onWhite /\<'.$col.'_onWhite\>/');
	    VIM::DoCommand( 'syn match X11rgb_'.$gn.'_onBlack /\<'.$col.'_onBlack\>/');
	    VIM::DoCommand( 'syn match X11rgb_WhiteOn_'.$gn.' /\<WhiteOn_'.$col.'\>/');
	    VIM::DoCommand( 'syn match X11rgb_BlackOn_'.$gn.' /\<BlackOn_'.$col.'\>/');
	    $main::curbuf->Set($i,$line);
	}
.
    normal 1G
    nohlsearch
    syntax sync minlines=1

    " restore global options and registers
    let &hidden      = s:hidden
    let &lazyredraw  = s:lazyredraw
    let &more	     = s:more
    let &report	     = s:report
    let &shortmess   = s:shortmess
    let &wrapscan    = s:wrapscan

    echoe "Don't have the coloring exactly figured out.  Seems I run out of space to allocate new colors"

endfunction

						"}}}
" Grab the time string under the cursor and yank it into a register {{{2
" TODO Allow formatting change... whatever, time to get going - tsnyder 16-Nov-05
function! GrabTime () range
   "NOTE: it ignores the range, just don't call me 500 times
   let serialtime = expand("<cword>")
   let @a = strftime("%d%b%y",serialtime)
   echom "Grabbed ".@a." into register a"
   return @a
endfunction
map <LocalLeader>t :call GrabTime()<CR>

"}}}

" User Abbreviations		{{{1
" ==================
" :sfind is a real command already
 
" make diffsplit do the splitting vertically without having to remember to type vertical everytime
cabbrev diffsplit vertical diffsplit

" Make the names of design centers always capitalized  {{{2
iab idc IDC
iab bdc BDC
iab asdc ASDC
iab andc ANDC
iab svdc SVDC

						      " }}}

" User Commands			{{{1
" =============

" Reload .vimrc		{{{2
command! Source execute $VIMINIT <Bar> edit


" Open a window that displays all of the current color hilighting {{{2
" I hacked it so the configuration values for all the colors
" would be shown instead of being grepped out - tsnyder 22-Jul-05
command! HilightColors runtime syntax/hitest.vim

" Open a window that displays /usr/lib/X11/rgb.txt with color names fg in each color {{{2
" This currently doesn't work, fills up colormap and I haven't spent time to figure out how to fix
command! ColorPallet call <SID>ColorX11RgbTxt()

" Vertically split the annotations for current file under CVS control "{{{2
" NOTE this needs to be 
function! AnnotateCVS() range       "{{{3
   " split a new buffer and load annotations for the current buffer 
   "
   " this may be depricated soon in favor of using cvscommander.vim annotate functionality - tsnyder
   " 06-Nov-05
   "

   " Don't want STDERR output in the annotation
   let opt_shellredir = &shellredir
   let &srr = substitute(&srr, '&\|2>\S\+', '', '')

   " Save the current window number so we can end up back here
   let nr = bufnr("%")

   " save cursor and screen position in @s and @t
   let reg_s=@s
   let reg_t=@t
   normal msHmt	

   " save line number of top screen line 
   "let topScrLine = line("'t")
   " Move to first line so scroll binding will work
   normal gg

   " TODO make it so folding is synchronized and not just turned off
   " TODO make querying commnads on version, user ,date to show only lines of interest
   "      they will run a custom diffexpr that generates the ex script for 'diffs'
   "      which are really lines in ChangeLog buffer that match query
   " Turn off folding in Code window and shrink the foldcolumn to 0
   setlocal nofoldenable
   setlocal foldcolumn=0
   

   " Make sure we are in the CVS working directory so rcvs works right
   let cwd = getcwd()
   if cwd != expand("%:p:h")
      cd %:p:h
   endif
   silent! exec 'vnew +0r!\ /proj/verif/bin/rcvs\ annotate\ '.expand('%')

   " TODO this changes histories, fix that
   $delete
   silent! %s/:.*//

   " TODO need to make this work without Tsnyder::Text so function can move into diffim.vim
   if exists("*ColOrder")
      silent! call ColOrder('rest')
   endif
   setlocal nomodified
   setlocal noswapfile
   " I really want this to be a slave window of the other one, closest thing is a helpfile with
   " nomodifiable set.  It will exit if you exit from code window, need to replicate folds in the 
   " actual code window and synch the folds...
   silent! file ChangeLog
   setlocal buftype=nofile
   setlocal nomodifiable
   setlocal noreadonly

   " TODO make it so folding is synchronized and not just turned off
   setlocal foldcolumn=0

   exec 'vertical resize '.(strlen(getline("."))+&fdc)
   setlocal winfixheight

   "put the ChangeLog window on the first line so it lines up with code
   "exec 'normal '.topScrLine.'zt'
   normal gg
   "bind scrolling of ChangeLog so it stays aligned with code
   set scrollbind

   " Go back to real code window
   exec bufwinnr(nr) . "wincmd w"

   " bind scrolling to ChangeLog
   set scrollbind


   "go back to saved cursor and screen position
   normal 'tzt`s	 
   let @s=reg_s
   let @t=reg_t

   " Virtual offset will be off after doing these jumps, need to synchonize the bindings
   " TODO any offsets that ARE correct will be lost by doing this too ...
   syncbind

   " Undo side effects
   let &srr = opt_shellredir
   if cwd != getcwd()
      exec 'cd '.cwd
   endif

endfunction  "}}}
command! Annotate call AnnotateCVS()

" Do the first common steps for turning a case frame into a pla   {{{2
function! <SID>RTLtoPLAstart(wid, bang) range		  "{{{3
   "does the first steps to converting a case statement into a pla, tired of typing them
   "wid is the width of the input vector
   "bang is 
   "operates on the whole file ignoring range

   exec 'saveas'.a:bang.' '.substitute(expand('%:t'),'\..*','.pla', '')
   edit
   exec "g/".a:wid."'b/s/:\s*begin/:\r\t\tbegin/"
   exec "g!/".a:wid."'b/s/^/#/"
   exec "g!/^#/s/".a:wid."'b//"
   g!/^#/s/[_,:]/ /g
   g!/^#/s/?/-/g

endfunction   "}}}

command! -nargs=1 -bang RTLtoPLAstart call <SID>RTLtoPLAstart(<f-args>, "<bang>")

" Search a PLA for a term without craploads of typing  {{{2
function! <SID>FindTerm(...) range   "{{{3
   " It is annoying to type all of the stuff you have to type to search for a term
   " I'm making a command to do it.
   " This first pass implementation of it will just work for PLAs but I hope to either eventually
   " encorporate with PLA.pm or at least make the care/don't care characters conigurable in some way
   "
   " Takes unlimited args that are parsed into a search string and searched.  The characters are
   " handled as follows
   "    whitespace is ignored, the function is meant to be used through the user command interface,
   "    not called directly, hence the <SID> prefix on the Function name
   "
   "    1  becomes [1-]\s*
   "    0  becomes [0-]\s*
   "    -  becomes [10-]\s*
   "
   "    TODO _ needs to be considered whitespace for Verilog purposes
   "         could possibly pawn a lot of this off on PLA.pm but I don't want
   "         to deal with that right now
   "         needs to handle ^$
   let srch = ''
   let idx = 1
   while idx <= a:0
     "each arg should be a chunk of valid PLA characters
     let chunk = a:{idx}
     let len = strlen(chunk)
     let cidx = 0
     while cidx < len
	let char = strpart(chunk, cidx, 1)
	if char == '1' || char == '0'
	   let srch = srch."[".char."-]\\s*"
	elseif char == '-'
	   let srch = srch."[01-]\\s*"
	elseif char == '^' || char == '$'
	   let srch = srch.char.'\s*'
	else 
	   echoerr "Invalid PLA value character ".char." passed to FindTerm as a portion of ".chunk
	endif
	let cidx = cidx + 1
     endwhile
     let idx = idx + 1
   endwhile
   echom "Searching for :".srch
   exec '/'.srch
   "for some reason execing the search like that doesn't write @/ so I can use |n|
   let @/ = srch
endfunction

"}}}
command! -nargs=*  FindTerm call <SID>FindTerm(<f-args>)
									 " }}}
									 

" User Mappings			{{{1
" =============
 
" user mappings converted to a global plugin plugin/tsnyder_hotkeys.vim with the following
" parameters


" User Auto-Commands				{{{1                                                             
" ==================

" Set .pla files to base line configuration with #-style comments
autocmd BufRead *.pla set ft=conf

" Set AMD RTL extension filetypes to verilog
autocmd BufRead *.d,*.rtl,*.rtl.v set filetype=verilog

" Set Flat.log to use AMD_v9 filetype
autocmd BufRead Flat.log set filetype=AMD_v9 

" Make Flat.log cd into the gate directory of the Axe design tree you are in
autocmd BufRead Flat.log lcd `/home/tsnyder/bin/cdaxe gate`


" Get rid of annoying 6.4 b:browsefilter b:match_ignorecase error message
autocmd BufReadPre * let b:browsefilter = '*'
autocmd BufReadPre * let b:match_ignorecase = 0
autocmd BufReadPre * let b:match_words = 0

" Detect the filetype after loading file with :read or equivalent
au FileReadPost * syntax enable

" Always lcd into the directory where the file lives.  I'm tired of typing this all the time
" Has consequence when vim commands that require paths or interact with the shell
" TODO this is broken - tsnyder 12-Dec-05
au FileReadPost * if expand("%:h") != '' |  lcd %:h | endif


" Force cterm to reverse video so coloring is readable
au FileType * call TermSyntaxColoring()
au FileType * set foldcolumn=2

" Always put g:AlwaysToDoKeywords back in the higlighting group stuff
"au FileType * exec 'syn keyword TsnyderAlwaysToDo '.g:AlwaysToDoKeywords.' contained' | hi def link TsnyderAlwaysToDo ToDo

" Not having good luck even with containedin=ALL ... hmmmm
" Create a syntax group for things that I always want to add to Todo
"au Syntax * syn match Todo +?\{3}.\+?\{3}+ containedin=ALL,verilogComment contained
"au Syntax * syn keyword Todo UserTodo Todo ToDo NOTE Note containedin=ALL,verilogComment contained
" Create a syntax group for things that I always want to add to Todo
"au Syntax * syn match AllUnderlined +!\{3}.\+!\{3}+ containedin=ALL contained


au BufNewFile * let s:foundInPath = 0

" If invoked with link that matches, 'fg\=vi\=', and the file does not exist, search for file in 'path' before creating a new one
au BufNewFile * nested if v:progname =~? 'fg\=vi\=' | let s:foundInPath=1 | try | find <afile> | catch 'Can.t find file' |  let s:foundInPath=0 | endtry | endif
au BufNewFile * nested if v:progname =~? 'fgvi\=' | gui | endif

" Turn the visual bell off inside vim
" Turns the visual bell on and sets the loaded termcap bell lentgh to 0
au GUIEnter * set visualbell t_vb=


" Perl Interface Init		    {{{1
" See Also: 
"	'perldoc ~tsnyder/bin/Tsnyder/VIM.pm'
"	:help :perl
"	:<command> help
" =========================================

if has('perl') && exists('g:UserPerlBin') && filereadable(g:UserPerlBin.'/Tsnyder/VIM.pm')
    
    command! PerlVersion  :perl VIM::Msg($])<CR>

    function! ShowINC (...) range
	perl require Data::Dumper; $foo = Data::Dumper::DumperX(\%INC);
	if a:0
	    perl $main::curbuf->Append(scalar(VIM::Eval('line(".")')), (split /\n/, $foo))

	else 
	    perl VIM::Msg($foo);
	endif
    endfunction

    function! ShowMain () range
	perl require Data::Dumper; VIM::Msg(Data::Dumper::DumperX(\%main::))
    endfunction

    function! UsePerl () range
	perl for my $tag (grep /Tsnyder|Banner/, keys %INC) { delete $INC{$tag} }
	":call ShowINC()
	":call ShowMain()
	perl use lib (VIM::Eval('g:UserPerlBin')); use Tsnyder::VIM; $main::tsnyder = new Tsnyder::VIM();
    endfunction

    call UsePerl()

    function! ColOrder (...) range
	perl $main::tsnyder->ColOrder();
    endfunction
    command! -range=% -nargs=* ColOrder <line1>,<line2> call ColOrder(<f-args>)

    " note: function really ignores the range
    function! SetCws (...) range
	perl $main::tsnyder->SetCws();
    endfunction
    command! -range -nargs=* SetCws <line1>,<line2> call SetCws(<f-args>)

    function! Banner (...) range
	perl $main::tsnyder->Banner();
    endfunction
    command! -range -nargs=* Banner <line1>,<line2> call Banner(<f-args>)

    function! PinSplit (...) range
	perl $main::tsnyder->ColSplit(undef, '(.*)/(.*)');
    endfunction
    command! -range -nargs=* PinSplit <line1>,<line2> call PinSplit(<f-args>)

    function! ColSplit (...) range
	perl $main::tsnyder->ColSplit();
    endfunction
    command! -range -nargs=* ColSplit <line1>,<line2> call ColSplit(<f-args>)

endif


" Source $HOME/.vimrc if it exists	    {{{1
" NOTE: If you are in $HOME/.vimrc and you uncomment this, you will get stuck in an infinite loop
"       when you try to open vim.  Don't say I didn't warn you! ;)
if filereadable($HOME.'/.vimrc')
    source $HOME/.vimrc
endif

echohl ErrorMsg
echom "!CHANGE NOTICE!"
echohl WarningMsg
echom " ~tsnyder/rel/vim/.vimrc has been depricated.  Please see ':help tsnyder-setup' for new setup details"
echohl None
" Trash			    {{{1
" =====
"
" comment toggleing using this has been depricated since load of NERD comment plugin
" Set up comment toggleing macros
"au FileType * let w:comStr = (expand("<amatch>") ==? "perl" || expand("<amatch>") ==? "tcsh" || expand("<amatch>") ==? "AMD_px"|| expand("<amatch>") ==? "conf") ? '#' : (expand("<amatch>") ==? "vim") ? '"' : '//'
"au FileType * let w:comStrLen = strlen(substitute(w:comStr, ".", "x", "g"))
"au FileType * let w:comStrSrch = substitute(w:comStr, '\/', '\\/', "g") 
" function! ToggleComment()		"{{{2
" This is deprecated in favor of trying out the NERD commenter - tsnyder 06-Nov-05
" "Toggle comment for current line using line commenting character
" "TODO there is probably a standard way of defining this so I can get rid of w:comStr
" "     There is &commentstring
"   if getline(".") =~ "^\s*".w:comStrSrch 
"     exec "normal :s/^\\(\\s*\\)=w:comStrSrch\<CR>/\\1/\<CR>"
"   else 
"     exec "normal :s/^/=w:comStrSrch\<CR>/\<CR>" 
"   endif
" endfunction

"map <F5> :call ToggleComment()<CR>
