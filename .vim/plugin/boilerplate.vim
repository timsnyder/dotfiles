" Vim global plugin file containing Tim Snyder's Boilerplate Insertion Stuff
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 18-Feb-09 12:29 
" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\ 
"
" Todo:
"    * handle case where UserPerlBin is not defined or should templates be in the runtime path someplace or both??
"    * make the Updating of the Modified Tag update the copyright too
"


" Avoid issues with 'compatability' option
let s:save_cpo = &cpo
set cpo&vim

" Only do this $USER hasn't already done it with their own version earlier in 'runtimepath' or set
" the variable to avoid my hotkeys being loaded
if !exists("load_boilerplate") || exists("loaded_boilerplate")
  finish
endif
let loaded_boilerplate = 1


" Functions That Actually Do the Work	     {{{1
" ===================================

function! <SID>NewModule() range		"{{{2
" Load Perl Module template, called by au BufRead *.pm
    exec "0r ".g:UserTemplates."/PerlModule.templ"
    let mn = input("Module Name?")
    exec "%s/TEMPLATE_MODULE_NAME/".mn."/g"
    /^TEMPLATE_DISCRIPTION_TEXT
"    normal C
endfunction

function! <SID>Template(type) range		"{{{2
" Load a function or method template from ~tsnyder/src/templates
 if &ft != 'perl'
    echoerr "Boilerplate only supports perl as of right now, not '".&ft."'. Will fix at some point -tsnyder"
    return
 endif
" TODO currently only supports perl
 let name   = input(a:type." Name?")
 let file = g:UserTemplates."/Perl".a:type.".templ" 
 exec "r".file
 exec "'[,']s/TEMPLATE_NAME/".name."/"
 :/TEMPLATE_END/,']delete
 if name == 'AUTOLOAD'
   ?^\(use strict\|package\)
   exec "normal ouse vars qw($AUTOLOAD);\<Esc>"
   /^sub AUTOLOAD
   /my \$self
   exec "normal C$AUTOLOAD =~ /.*::(.*)/;\<CR>my $name = $1;\<CR>$name eq 'DESTROY' and return;\<CR>my $self = $_[0];\<CR>my $sub;"
   exec "/die"
   exec "normal Cif(exists $self->{name}){\<CR>$sub = sub{\<CR>my $self = shift;\<CR>$self->{$name}=shift if @_;\<CR>return $self->{$name};\<CR>};\<CR>}"
   exec "normal oif(defined $sub){\<CR>no strict qw(refs);\<CR>*$AUTOLOAD = $sub;\<CR>goto &$AUTOLOAD;\<CR>use strict;\<CR>}"
   exec "normal ocroak 'Can\\'t locate object method \"'.$name.'\" via package \"'.__PACKAGE__.\<CR>\<TAB>\<TAB>'\" (perhaps you forgot to load \"'.__PACKAGE__.'\"?)';"
   ?^\s*if
   exec "normal O\<CR>#FILL IN THE REST of AUTOLOAD method HERE!!!\<CR>"
 endif
 exec "normal '[/TEMPLATE_DISC\<CR>C"
endfunction

function! <SID>UpdateModifiedTag () range	"{{{2
    " First check to make sure we aren't editing a template
    let fn = expand("%:t")
    if fn =~? '\.templ$'
	return 1
    endif
    " Update modification tag inside embedded documentation
    if exists("b:current_syntax") 
	"let s:foldenable=&foldenable
	let lazyredraw=&lazyredraw  "force the screen to not be redrawn now to avoid possible jumpiness
	set lazyredraw
	"set nofoldenable
	let reg_se=@/
	let reg_s=@s
	let reg_t=@t
	" save cursor and screen position in @s and @t
	normal msHmt
	if b:current_syntax =~? 'perl\|pod'
	    silent! exec 'keepjumps g/Written: /s/Modified: [a-zA-Z].*\(\$\|$\)/Modified: '.$USER strftime("%d-%b-%y %H:%M")'/i'
	    "TODO am I still pushing one search pattern off the history??
	    call histdel('search', -1)
	elseif b:current_syntax =~? 'vim\|tcsh\|help\|AMD_v9\|AMD_px\|conf'
	    "TODO make this use the comment string that is stored in global vim var (see yaks)
	    silent! exec 'keepjumps %s/\(["#]\=\s*Last \(Modified\|Changed\=\):\s*\).*\(\$\|$\)/\1'.$USER strftime("%d-%b-%y %H:%M")"/i"
	    call histdel('search', -1)
	endif
	" go back to saved cursor and screen position
	normal 'tzt`s
	let @s=reg_s
	let @t=reg_t
	"let &foldenable=s:foldenable
	let &lazyredraw=lazyredraw
	let @/=reg_se
    endif
endfunction


function! <SID>StandardBoilerplateInit () range	"{{{2
    " Replace the standard set of tags with expanded information that Vim can lookup for the user
    "let s:foldenable=&foldenable
    let lazyredraw=&lazyredraw  "force the screen to not be redrawn now to avoid possible jumpiness
    set lazyredraw
    "set nofoldenable
    let reg_se=@/
    silent! :/TEMPLATE_END/,$delete
    silent! %s/\<TEMPLATE_USER_\=NAME\>/\=$USER/g
    silent! %s/\<TEMPLATE_\(CREATION_\=TIME\|DATE\)\>/\=strftime("%d-%b-%y %H:%M")/g
    silent! %s/\<TEMPLATE_FILE_\=NAME\(:[phtre]*\)\=\>/\=(submatch(1) != '') ? expand('<afile>'.submatch(1)) : expand('<afile>:t')/g
    silent! %s/\<TEMPLATE_YEAR\>/\=strftime("%Y")/g 
    silent! /ONELINE\|TEMPLATE_START
    if &foldenable && foldlevel(line("."))
	normal zo 
    endif 
    let &lazyredraw=lazyredraw
    let @/=reg_se
endfunction

"}}}

" Boilerplate Insertion Hotkeys -- Begin with   {{{1
" ==============================================
"
" Insert my personal function/method boilerplate. Based on Current syntax. Currently only Perl is supported - tsnyder 10-Jul-05"

" <Plug>BoilerplateInsertFunction : Insert Function Template  {{{2
if !hasmapto('<Plug>BoilerplateInsertFunction')
  map <unique> <Leader>pf  <Plug>BoilerplateInsertFunction
endif
nnoremap  <unique> <script> <Plug>BoilerplateInsertFunction <SID>InsertFunction
nnoremenu          <script> Plugin.Boilerplate.NewFunction      <SID>InsertFunction

nnoremap                   <SID>InsertFunction :call <SID>Template('Function')<CR>

" <Plug>BoilerplateInsertMethod : Insert Method Template  {{{2
if !hasmapto('<Plug>BoilerplateInsertMethod')
  map <unique> <Leader>pm  <Plug>BoilerplateInsertMethod
endif
nnoremap  <unique> <script> <Plug>BoilerplateInsertMethod <SID>InsertMethod
nnoremenu          <script> Plugin.Boilerplate.NewMethod      <SID>InsertMethod

nnoremap                   <SID>InsertMethod :call <SID>Template('Method')<CR>

"}}}



" Autocommands            {{{1
" ============

" Filetype plugins are awkward in templates in the case of 
" hmmm didn't seem to finish that thought, can't remember why I put this in here now - tsnyder 24-Jul-06
au BufReadPre *.templ  filetype plugin off

au BufNewFile * let s:foundInPath = 0
" Perl Template loading Autocommands that probably should be moved into .vim/after/ftplugin/perl.vim ... {{{2
" But now that there is the foundInPath hack to make the perl templates cooperate with fvi and fgv...
" TODO it would probably make sense to clean this up into a function that just gets called.
au BufNewFile *.p[lm] if s:foundInPath == 0
au BufNewFile *.pm    call <SID>NewModule()
au BufNewFile *.pl    silent exec "0r ".g:UserTemplates."/PerlScript.templ"
au BufNewFile *.p[lm] endif 

au BufNewFile *.v9 silent exec "0r ".g:UserTemplates."/AMD_v9FileHeader.templ"
au BufNewFile *.px silent exec "0r ".g:UserTemplates."/AMD_pxFileHeader.templ"

au BufNewFile *.pod silent exec "0r ".g:UserTemplates."/PodDoc.templ"
au BufNewFile *.pod,*.p[lm],*.v9,*.px keepjumps silent call <SID>StandardBoilerplateInit()

"}}}

" Update Modified: comment with current time when writing a file
au BufWrite *  call <SID>UpdateModifiedTag()
															    

" Plugin Cleanup  {{{1
let &cpo = s:save_cpo
