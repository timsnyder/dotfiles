" Vim global plugin to help with numeric editing
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tims 15-Apr-21 14:34 
" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\; 


" Avoid issues with 'compatability' option
let s:save_cpo = &cpo
set cpo&vim

" Only do this $USER hasn't already done it with their own version earlier in 'runtimepath' or set
" the variable to avoid my hotkeys being loaded
if exists("loaded_Numeric")
  let &cpo = s:save_cpo
  finish
endif
let loaded_Numeric = 1




" Default behavior is to emulate <CTRL-A>, <CTRL-X>
"let s:Numeric_default = '1'

" function s:isNumeric(arg)   {{{1
"
"    Return 0 if argument is non-numeric, 1 if it is
"
function s:isNumeric(arg)
    if a:arg =~ '[+-]\=\(\d*\.\d\+\|\d\+\(\.\d\+\)\=\)'
	return 1
    endif
    return 0
endfunction

" TODO +float was added at some point in the last 15 years.  Rewrite this to use vim +float support
" if has('float')
if !has('perl')
    let &cpo = s:save_cpo
    " have to have the perl interface for floating point arithmetic
    finish
endif


" function s:Numeric(dir, ...)   {{{1
"
"    Use :perl to do a floating point Numeric operation on the word under the cursor
"
" Args:
"   oper           : operator (+,-,/,*,%,^)
"   amt (optional) : the amount to modify the word the cursor is on by
" 
function s:Numeric(oper, ...)
    if exists("s:Numeric_default")
	let amt = s:Numeric_default
    endif
    if exists("b:Numeric_default")
	let amt = b:Numeric_default
    endif
    if a:0 > 0 
	let amt = a:1
    endif

    if !exists("amt")
	let prompt = a:oper
	if a:oper == '/'
            "0xf7 247 ÷ 
	    let prompt = "\xf7"
	endif
	let amt = input(' '.prompt.' ') 
    endif

    if !exists("amt") || amt == ''
	return
    endif
    if !s:isNumeric(amt) 
	echoerr \'.amt."' is not numeric!"
	return
    endif


    let value = expand("<cWORD>")
    let oper = value.' '.a:oper.' '.amt

    echomsg "doing '".oper."'"

    perl <<
    my ($success, $oper) = VIM::Eval('oper');
    $success or die "Can't evaulate vim variable 'oper'";
    my $result = eval $oper;
    # have to be careful to put quotes around the result
    # because 123.45 evaluates to 12345 in vim expression syntax
    VIM::DoCommand("let value = '$result'");
.
    exec "normal ciW".value

endfunction


" <Plug>NumericAdd : Add to iWORD under cursor  {{{1
if !hasmapto('<Plug>NumericAdd')
  nmap <unique> <kPlus>  <Plug>NumericAdd
endif
nnoremap  <unique> <script> <Plug>NumericAdd <SID>Add
nnoremenu          <script> Plugin.Numeric.Add<Tab>KeyPad+      <SID>Add

nnoremap                   <SID>Add :call <SID>Numeric('+')<CR>

" <Plug>NumericSubtract : Subtract from iWORD under cursor  {{{1
if !hasmapto('<Plug>NumericSubtract')
  nmap <unique> <kMinus>  <Plug>NumericSubtract
endif
nnoremap  <unique> <script> <Plug>NumericSubtract <SID>Subtract
nnoremenu          <script> Plugin.Numeric.Subtract<Tab>KeyPad-      <SID>Subtract

nnoremap                   <SID>Subtract :call <SID>Numeric('-')<CR>

" <Plug>NumericMultiply : Multiply iWORD under cursor  {{{1
if !hasmapto('<Plug>NumericMultiply')
  nmap <unique> <kMultiply>  <Plug>NumericMultiply
endif
nnoremap  <unique> <script> <Plug>NumericMultiply <SID>Multiply
nnoremenu          <script> Plugin.Numeric.Multiply<Tab>KeyPad*      <SID>Multiply

nnoremap                   <SID>Multiply :call <SID>Numeric('*')<CR>

" <Plug>NumericDivide : Divide iWORD under cursor  {{{1
if !hasmapto('<Plug>NumericDivide')
  nmap <unique> <kDivide>  <Plug>NumericDivide
endif
nnoremap  <unique> <script> <Plug>NumericDivide <SID>Divide
nnoremenu          <script> Plugin.Numeric.Divide<Tab>KeyPad/      <SID>Divide

nnoremap                   <SID>Divide :call <SID>Numeric('/')<CR>
"}}}

" function s:Lock(dir, ...)   {{{1
"
"    Accessor function to lock numeric amount to a particular value
"    making Add + Subtract, Increment + Decrement by a fixed value
"
" Args:
"   level          : 'local'|'global' behaves same as :setl vs :set
"   amt (optional) : the amount to lock Numeric on
function s:Lock(level, ...)
    if a:0 > 0
	let amt = a:1
    endif


    if a:level == 'local'
	let lockname = 'b:Numeric_default'
    else
	let lockname = 's:Numeric_default'
    endif

    if exists(lockname)
	if !exists("amt")
	    let amt = input('Lock Numeric Edits To: ','unlock') 
	endif
	if s:isNumeric(amt)
	    let {lockname} = amt
	else 
	    unlet {lockname}
	endif
    else
	if !exists("amt")
	    let amt = input('Lock Numeric Edits To: ') 
	endif
	if s:isNumeric(amt)
	    let {lockname} = amt
	endif
	" TODO do something with the status line like [NL:amt]
	"      when the NL is set
    endif

endfunction

" <Plug>NumericLockLocal : Set/Clear Local Numeric Lock  {{{1
if !hasmapto('<Plug>NumericLockLocal')
  nmap <unique> <Leader>l  <Plug>NumericLockLocal
endif
nnoremap  <unique> <script> <Plug>NumericLockLocal <SID>LockLocal
nnoremenu          <script> Plugin.Numeric.LockLocal<Tab>'Leader'l      <SID>LockLocal

nnoremap                   <SID>LockLocal :call <SID>Lock('local')<CR>
" <Plug>NumericLockGlobal : Set/Clear Global Numeric Lock  {{{1
if !hasmapto('<Plug>NumericLockGlobal')
  nmap <unique> <Leader>L  <Plug>NumericLockGlobal
endif
nnoremap  <unique> <script> <Plug>NumericLockGlobal <SID>LockGlobal
nnoremenu          <script> Plugin.Numeric.LockGlobal<Tab>'Leader'L      <SID>LockGlobal

nnoremap                   <SID>LockGlobal :call <SID>Lock('global')<CR>
"}}}


" undo mucking with compatability
let &cpo = s:save_cpo
