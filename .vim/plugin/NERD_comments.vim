" vim global plugin that provides easy code commenting for various file types
" Last Change:  timothys 25-Apr-20 08:11 
" Maintainer:   Martin Grenfell <mrg39 at student.canterbury.ac.nz>
let s:NERD_comments_version = 1.59


" For help documentation type :help NERD_comments. If this fails, Restart vim
" and try again. If it sill doesnt work... the help page is at the bottom 
" of this file.

" Section: script init stuff {{{1
if exists("loaded_nerd_comments")
   finish
endif
let loaded_nerd_comments = 1

" Section: tabSpace init {{{2
" here we get a string that is the same length as a tabstop but with spaces
" instead of a tab. Also, we store the number of spaces in a tab
let s:tabSpace = ""
let s:spacesPerTab = &tabstop
while s:spacesPerTab > 0
    let s:tabSpace = s:tabSpace . " "
    let s:spacesPerTab = s:spacesPerTab - 1
endwhile
let s:spacesPerTab = &tabstop

" Section: spaces init {{{2
" Occasionally we need to grab a string of spaces so just make one here
let s:spaces = ""
while strlen(s:spaces) < 100
    let s:spaces = s:spaces . "    "
endwhile

" Function: s:InitVariable() function {{{2
" This function is used to intialise a given variable to a given value. The
" variable is only initialised if it does not exist prior
"
" Args:
"   -var: the name of the var to be initialised
"   -value: the value to intialise var to
"
" Returns:
"   1 if the var is set, 0 otherwise
function s:InitVariable(var, value)
    if !exists(a:var)
	execute 'let ' . a:var . ' = ' . a:value
	return 1
    endif
    return 0
endfunction

" Section: variable init calls {{{2
call <SID>InitVariable("g:NERD_use_ada_with_spaces", "0")
call <SID>InitVariable("g:NERD_use_c_style_acedb_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_ch_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_clean_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_clipper_comments", "0")
call <SID>InitVariable("g:NERD_use_multiline_coffee_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_cpp_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_cs_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_dot_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_dylan_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_h_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_hercules_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_idl_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_ishd_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_java_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_javascript_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_kscript_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_mel_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_named_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_pccts_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_php_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_pike_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_pilrc_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_plm_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_pov_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_prolog_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_rc_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_tads_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_tsalt_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_uc_comments", "0")
call <SID>InitVariable("g:NERD_use_c_style_verilog_comments", "0")
call <SID>InitVariable("g:NERD_use_dash_dash_simula_comments", "0")
call <SID>InitVariable("g:NERD_use_dnl_style_automake_comments", "0")
call <SID>InitVariable("g:NERD_use_long_haskell_comments", "0")
call <SID>InitVariable("g:NERD_use_long_lisp_comments", "0")
call <SID>InitVariable("g:NERD_use_long_lua_comments", "0")
call <SID>InitVariable("g:NERD_use_nested_comments_default", "0")
call <SID>InitVariable("g:NERD_use_paren_star_pascal_comments", "0")
call <SID>InitVariable("g:NERD_use_REM_basic_comments", "0")
call <SID>InitVariable("g:NERD_use_single_part_c_comments", "0")

call <SID>InitVariable("g:NERD_allow_any_visual_delims_regexp", '".*"')
call <SID>InitVariable("g:NERD_block_com_after_right", "0")
call <SID>InitVariable("g:NERD_comment_whole_lines_in_v_mode", '0')
call <SID>InitVariable("g:NERD_create_h_filetype", '0')
call <SID>InitVariable("g:NERD_dont_remove_alt_coms", '0')
call <SID>InitVariable("g:NERD_dont_remove_spaces_regexp", '"^python$"')
call <SID>InitVariable("g:NERD_left_align_regexp", '"^$"')
call <SID>InitVariable("g:NERD_lPlace", '"[>"')
call <SID>InitVariable("g:NERD_place_holder_regexp", '".*"')
call <SID>InitVariable("g:NERD_right_align_regexp", '"^$"')
call <SID>InitVariable("g:NERD_rPlace", '"<]"')
call <SID>InitVariable("g:NERD_shut_up", '0')
call <SID>InitVariable("g:NERD_space_delim_filetype_regexp", '"^$"')
call <SID>InitVariable("g:NERD_use_compact_sexy_com_regexp", '"^$"')
call <SID>InitVariable("g:NERD_use_sexy_coms_default_regexp", '"^$"')
call <SID>InitVariable("g:NERD_use_toggle_coms_default", '0')
 
call <SID>InitVariable("g:mapleader", '"\\"')
let s:mapleaderESC = escape(g:mapleader, '\')

call <SID>InitVariable("g:NERD_alt_com_map", '"' . s:mapleaderESC . 'ca"')
call <SID>InitVariable("g:NERD_append_com_map", '"' . s:mapleaderESC . 'cA"')
call <SID>InitVariable("g:NERD_com_align_both_map", '"' . s:mapleaderESC . 'cb"')
call <SID>InitVariable("g:NERD_com_align_left_map", '"' . s:mapleaderESC . 'cl"')
call <SID>InitVariable("g:NERD_com_align_right_map", '"' . s:mapleaderESC . 'cr"')
call <SID>InitVariable("g:NERD_com_in_insert_map", '"' . '<C-c>"')
call <SID>InitVariable("g:NERD_com_line_invert_map", '"' . s:mapleaderESC . 'ci"')
call <SID>InitVariable("g:NERD_com_line_map", '"' . s:mapleaderESC . 'cc"')
call <SID>InitVariable("g:NERD_com_line_nest_map", '"' . s:mapleaderESC . 'cn"')
call <SID>InitVariable("g:NERD_com_line_sexy_map", '"' . s:mapleaderESC . 'cs"')
call <SID>InitVariable("g:NERD_com_line_toggle_map", '"' . s:mapleaderESC . 'c<space>"')
call <SID>InitVariable("g:NERD_com_line_yank_map", '"' . s:mapleaderESC . 'cy"')
call <SID>InitVariable("g:NERD_com_to_end_of_line_map", '"' . s:mapleaderESC . 'c$"')
call <SID>InitVariable("g:NERD_prepend_com_map", '"' . s:mapleaderESC . 'cI"')
call <SID>InitVariable("g:NERD_uncom_line_map", '"' . s:mapleaderESC . 'cu"')
												"}}}

" Section: Comment mapping functions and autocommands {{{1
" ============================================================================
" Section: Comment enabler autocommands {{{2
" ============================================================================

if !exists("nerd_autocmds_loaded")
    let nerd_autocmds_loaded=1

    augroup commentEnablers
	
        if g:NERD_create_h_filetype == 1
            " some versions of vim dont have an h filetype... so we set it
            " ourselves, we also set syntax highlighting to c++ style
	    autocmd BufEnter *.h :setfiletype h | :set syntax=cpp
        endif

	"if the filetype changes then we gotta enable the correct comment
	"mappings 
        autocmd BufEnter * :call <SID>SetUpForNewFiletype(&filetype,0)
	" if the filetype changes force a reload 
	autocmd Syntax * :call <SID>SetUpForNewFiletype(&filetype,1)
    augroup END

endif


" Function: s:SetUpForNewFiletype(filetype) function {{{2
" This function is responsible for setting up buffer scoped variables for the 
" given filetype.
"
" These variables include the comment delimiters for the given filetype and calls
" MapDelimiters or MapDelimitersWithAlternative passing in these delimiters.
"
" Args:
"   -filetype: the filetype to set delimiters for
"   -force:    ignore the test for whether to do this or not. just do it.
"
function s:SetUpForNewFiletype(filetype,force)
    "if we have already set the delimiters for this buffer then dont go thru
    "it again
    if exists("b:left") && b:left != '' && (a:force == 0 || a:force == 'false')
        return
    endif

    let b:sexyComMarker = ''

    "check the filetype against all known filetypes to see if we have
    "hardcoded the comment delimiters to use 
    if a:filetype == "abaqus" 
        call <SID>MapDelimiters("\*\*", "")
    elseif a:filetype == "abc" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "acedb" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_acedb_comments )
    elseif a:filetype == "ada" 
        call <SID>MapDelimitersWithAlternative('--','', '--  ', '', g:NERD_use_ada_with_spaces)
    elseif a:filetype == "ahdl" 
        call <SID>MapDelimiters("--", "")
    " tired of getting error messages for AMD_fmt files - tsnyder 10-Dec-05
    elseif a:filetype == "AMD_fmt"		  
        call <SID>MapDelimiters("","") 
    elseif a:filetype == "CVSAnnotate"		  
        call <SID>MapDelimiters("","") 
    elseif a:filetype == "AMD_px" 
        call <SID>MapDelimiters("#","")
    elseif a:filetype == "AMD_v9" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_verilog_comments)
    elseif a:filetype == "amiga" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "aml" 
        call <SID>MapDelimiters("\\\/\\\*", "")
    elseif a:filetype == "ampl" 
        call <SID>MapDelimiters("\\\\#", "")
    elseif a:filetype == "ant" 
        call <SID>MapDelimiters("<!--","-->") 
    elseif a:filetype == "apache" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "apachestyle" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "asm68k" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "asm" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "asm" 
        call <SID>MapDelimiters("!","") 
    elseif a:filetype == "asn" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "aspvbs" 
        call <SID>MapDelimiters("'", "")
    elseif a:filetype == "atlas" 
        call <SID>MapDelimiters("C","$") 
    elseif a:filetype == "automake" 
        call <SID>MapDelimitersWithAlternative("#","", "dnl ", "", g:NERD_use_dnl_style_automake_comments) 
    elseif a:filetype == "ave" 
        call <SID>MapDelimiters("'","") 
    elseif a:filetype == "awk" 
        call <SID>MapDelimiters("#","") 
    elseif a:filetype == "basic" 
        call <SID>MapDelimitersWithAlternative("'","", "REM ", "", g:NERD_use_REM_basic_comments)
    elseif a:filetype == "b" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "bc" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "bdf" 
        call <SID>MapDelimiters("COMMENT ", "")
    elseif a:filetype == "bib" 
        call <SID>MapDelimiters("","") 
    elseif a:filetype == "bindzone" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "btm" 
        call <SID>MapDelimiters("::", "")
    elseif a:filetype == "caos" 
        call <SID>MapDelimiters("\*", "")
    elseif a:filetype == "catalog" 
        call <SID>MapDelimiters("--","--") 
    elseif a:filetype == "c" 
       call <SID>MapDelimitersWithAlternative("\\\/\\\*","\\\*\\\/", "\\\/\\\/", "", g:NERD_use_single_part_c_comments) 
    elseif a:filetype == "cfg" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "cg" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", 0)
    elseif a:filetype == "ch" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_ch_comments )
    elseif a:filetype == "cl" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "clean" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_clean_comments )
    elseif a:filetype == "clipper" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_clipper_comments )
    elseif a:filetype == "cmake"
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "coffee" 
        call <SID>MapDelimitersWithAlternative("#", "", "###", "###", g:NERD_use_multiline_coffee_comments)
    elseif a:filetype == "conf" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "config" 
        call <SID>MapDelimiters("dnl ", "")
    elseif a:filetype == "cpp" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_cpp_comments)
    elseif a:filetype == "crontab" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "conf"      
        call <SID>MapDelimiters("#", "")  "the default syntax highlighting shows # style comments as comments
    elseif a:filetype == "cs" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_cs_comments)
    elseif a:filetype == "csc" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "csp" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "css" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "cterm" 
        call <SID>MapDelimiters("\*", "")
    elseif a:filetype == "cupl" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "cvs" 
        call <SID>MapDelimiters("CVS:","")
    elseif a:filetype == "dcl" 
        call <SID>MapDelimiters("$!", "")
    elseif a:filetype == "def" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "diff" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "dns" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "dosbatch" 
        call <SID>MapDelimiters("REM ","")
    elseif a:filetype == "dosini" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "dot" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_dot_comments )
    elseif a:filetype == "dracula" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "dsl" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "dtd" 
        call <SID>MapDelimiters("<!--","-->") 
    elseif a:filetype == "dtml" 
        call <SID>MapDelimiters("<dtml-comment>","</dtml-comment>") 
    elseif a:filetype == "dylan" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_dylan_comments )
    elseif a:filetype == "ecd" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "eiffel" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "elf" 
        call <SID>MapDelimiters("'", "")
    elseif a:filetype == "elmfilt" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "erlang" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "eterm" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "expect" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "exports" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "fgl" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "focexec" 
        call <SID>MapDelimiters("-\*", "")
    elseif a:filetype == "form" 
        call <SID>MapDelimiters("\*", "")
    elseif a:filetype == "fortran" 
        call <SID>MapDelimiters("!", "")
    elseif a:filetype == "foxpro" 
        call <SID>MapDelimiters("\*", "")
    elseif a:filetype == "fvwm" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "fx" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", 0)
    elseif a:filetype == "gdb" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "gdmo" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "geek" 
        call <SID>MapDelimiters("GEEK_COMMENT:", "")
    elseif a:filetype == "gitcommit" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "gitconfig" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "gitrebase"
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "gnuplot" 
        call <SID>MapDelimiters("#","")
    elseif a:filetype == "gtkrc" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "haskell" 
        call <SID>MapDelimitersWithAlternative("--","", "{-", "-}", g:NERD_use_long_haskell_comments) 
    elseif a:filetype == "hb" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "h" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_h_comments )
    elseif a:filetype == "help" 
        call <SID>MapDelimiters("\"","")
    elseif a:filetype == "hercules" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_hercules_comments )
    elseif a:filetype == "hog" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "html" 
        call <SID>MapDelimiters("<!--","-->") 
    elseif a:filetype == "twiki" 
        call <SID>MapDelimiters("<!--","-->") 
    elseif a:filetype == "htmlos"
        call <SID>MapDelimiters("#","\\\/#") 
    elseif a:filetype == "ia64" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "icon" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "idlang" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "idl" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_idl_comments )
    elseif a:filetype == "indent" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "inform" 
        call <SID>MapDelimiters("!", "")
    elseif a:filetype == "inittab" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "ishd" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_ishd_comments )
    elseif a:filetype == "iss" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "ist" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "jam" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "java" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_java_comments)
    elseif a:filetype == "javascript" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_javascript_comments)
    elseif a:filetype == "jess" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "jgraph" 
        call <SID>MapDelimiters("(\*","\*)") 
    elseif a:filetype == "jproperties" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "jproperties" 
        call <SID>MapDelimiters("#","")
    elseif a:filetype == "json"
	" json doesn't support comments.  'Disable' them by setting them all to empty string
	call <SID>MapDelimitersWithAlternative("","", "", "", 0)
    elseif a:filetype == "jsp" 
        call <SID>MapDelimiters("<%--", "--%>")
    elseif a:filetype == "kix" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "kscript" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_kscript_comments )
    elseif a:filetype == "lace" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "lex" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "lftp" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "lifelines" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "lilo" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "lisp" 
        call <SID>MapDelimitersWithAlternative(";","", "#|", "|#", g:NERD_use_long_lisp_comments) 
    elseif a:filetype == "lite" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "lotos" 
        call <SID>MapDelimiters("(\*","\*)") 
    elseif a:filetype == "lout" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "lprolog" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "lscript" 
        call <SID>MapDelimiters("'", "")
    elseif a:filetype == "lss" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "lua" 
        call <SID>MapDelimitersWithAlternative("--","", "--[[", "]]", g:NERD_use_long_lua_comments) 
    elseif a:filetype == "lynx" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "m4" 
        call <SID>MapDelimiters("dnl ", "")
    elseif a:filetype == "make" 
        call <SID>MapDelimiters("#","") 
    elseif a:filetype == "Mail"
        call <SID>MapDelimiters("> ","") 
    " tired of getting error messages for man pages - tsnyder 10-Dec-05
    elseif a:filetype == "man"		  
        call <SID>MapDelimiters("","") 
    elseif a:filetype == "maple" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "markdown"
        call <SID>MapDelimiters("#","")
    elseif a:filetype == "masm" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "master" 
        call <SID>MapDelimiters("$", "")
    elseif a:filetype == "matlab" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "mel" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_mel_comments )
    elseif a:filetype == "mf" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "mib" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "mma" 
        call <SID>MapDelimiters("(\*","\*)") 
    elseif a:filetype == "model"
        call <SID>MapDelimiters("$","$") 
    elseif a:filetype =~ "moduala." 
        call <SID>MapDelimiters("(*","*)") 
    elseif a:filetype == "modula2" 
        call <SID>MapDelimiters("(\*","\*)") 
    elseif a:filetype == "modula3" 
        call <SID>MapDelimiters("(\*","\*)") 
    elseif a:filetype == "monk" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "mush" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "muttrc" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "named" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_named_comments )
    elseif a:filetype == "nasm" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "nastran" 
        call <SID>MapDelimiters("$", "")
    elseif a:filetype == "natural" 
        call <SID>MapDelimiters("\\\/\\\*", "")
    elseif a:filetype == "ncf" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "nqc" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "nsis" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "ocaml" 
        call <SID>MapDelimiters("(\*","\*)") 
    elseif a:filetype == "omnimark" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "openroad" 
        call <SID>MapDelimiters("//", "")
    elseif a:filetype == "opl" 
        call <sid>mapdelimiters("REM", "")
    elseif a:filetype == "ora" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "ox" 
        call <SID>MapDelimiters("//", "")
    elseif a:filetype == "pascal" 
        call <SID>MapDelimitersWithAlternative("{","}", "(\\\*", "\\\*)", g:NERD_use_paren_star_pascal_comments)
    elseif a:filetype == "pcap" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "pccts" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_pccts_comments )
    elseif a:filetype == "perl" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "pfmain" 
        call <SID>MapDelimiters("//", "")
    elseif a:filetype == "php" 
        call <SID>MapDelimitersWithAlternative("//","", "\\\/\\\*", "\\\*\\\/", g:NERD_use_c_style_php_comments)
    elseif a:filetype == "phtml" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "pic" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "pike" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_pike_comments )
    elseif a:filetype == "pilrc" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_pilrc_comments )
    elseif a:filetype == "pine" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "plm" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_plm_comments )
    elseif a:filetype == "plsql" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "po" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "pod" 
        call <SID>MapDelimiters('\r=cut\r\#', '\r=pod\r')
    elseif a:filetype == "postscr" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "pov" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_pov_comments )
    elseif a:filetype == "povini" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "ppd" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "ppwiz" 
        call <SID>MapDelimiters(";;", "")
    elseif a:filetype == "procmail" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "progress" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "prolog" 
        call <SID>MapDelimitersWithAlternative("%","","\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_prolog_comments) 
    elseif a:filetype == "psf" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "ptcap" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "python" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "python" 
        call <SID>MapDelimiters("#","") 
    elseif a:filetype == "pyrex" 
        call <SID>MapDelimiters("#","") 
    " tired of getting error messages for quickfix files - tsnyder 10-Dec-05
    elseif a:filetype == "qf"		  
        call <SID>MapDelimiters("","") 
    elseif a:filetype == "radiance" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "ratpoison" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "r" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "rc" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_rc_comments )
    elseif a:filetype == "readline" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "rebol" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "registry" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "remind" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "rexx" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "robots" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "rpl" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "ruby" 
        call <SID>MapDelimiters("#","") 
    elseif a:filetype == "sa" 
        call <SID>MapDelimiters("--","") 
    elseif a:filetype == "samba" 
        call <SID>MapDelimiters(";","") 
    elseif a:filetype == "sas" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "sather" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "scala" 
       call <SID>MapDelimitersWithAlternative("\\\/\\\*","\\\*\\\/", "\\\/\\\/", "", g:NERD_use_single_part_c_comments) 
    elseif a:filetype == "scheme" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "scilab" 
        call <SID>MapDelimiters("//", "")
    elseif a:filetype == "screen" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "scsh" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "sdl" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "sed" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "sgml" 
        call <SID>MapDelimiters("<!",">") 
    elseif a:filetype == "sgmldecl" 
        call <SID>MapDelimiters("--","--") 
    elseif a:filetype == "sgmllnx" 
        call <SID>MapDelimiters("<!--","-->") 
    elseif a:filetype == "sicad" 
        call <SID>MapDelimiters("\*", "")
    elseif a:filetype == "simula" 
        call <SID>MapDelimitersWithAlternative("%", "", "--", "", g:NERD_use_dash_dash_simula_comments)
    elseif a:filetype == "sinda" 
        call <SID>MapDelimiters("$", "")
    elseif a:filetype == "skill" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "slang" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "sl" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "slrnrc" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "sm" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "smil" 
        call <SID>MapDelimiters("<!",">") 
    elseif a:filetype == "smith" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "sml" 
        call <SID>MapDelimiters("(\*","\*)") 
    elseif a:filetype == "snnsnet" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "snnspat" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "snnsres" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "snobol4" 
        call <SID>MapDelimiters("\*", "")
    elseif a:filetype == "spec" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "specman" 
        call <SID>MapDelimiters("//", "")
    elseif a:filetype == "spice" 
        call <SID>MapDelimiters("$", "")
    elseif a:filetype == "sql" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "sqlforms" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "sqlj" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "sqr" 
        call <SID>MapDelimiters("!", "")
    elseif a:filetype == "squid" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "st" 
        call <SID>MapDelimiters("\\\"","\\\"")
    elseif a:filetype == "stp" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "strace" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "tads" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_tads_comments )
    elseif a:filetype == "tags" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "tak" 
        call <SID>MapDelimiters("$", "")
    elseif a:filetype == "tasm" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "tcl" 
        call <SID>MapDelimiters("#","") 
    elseif a:filetype == "terminfo" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "tex" 
        call <SID>MapDelimiters("%","") 
    elseif a:filetype == "texinfo" 
        call <sid>mapdelimiters("@c ", "")
    elseif a:filetype == "texmf" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "text"
	call <SID>MapDelimitersWithAlternative("","", "", "", 0)
    elseif a:filetype == "tf" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "tidy" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "tli" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "trasys" 
        call <sid>mapdelimiters("$", "")
    elseif a:filetype == "tsalt" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_tsalt_comments )
    elseif a:filetype == "tsscl" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "tssgm" 
        call <SID>MapDelimiters('comment = "','"') 
    elseif a:filetype == "uc" 
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_uc_comments )
    elseif a:filetype == "uil" 
        call <SID>MapDelimiters("!", "")
    elseif a:filetype == "vb" 
        call <SID>MapDelimiters("'","") 
    elseif ( a:filetype == "verilog" || a:filetype == "verilog_systemverilog" )
        call <SID>MapDelimitersWithAlternative("\\\/\\\/","", "\\\/\\\*","\\\*\\\/", g:NERD_use_c_style_verilog_comments)
    elseif a:filetype == "vgrindefs" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "vhdl" 
        call <SID>MapDelimiters("--", "")
    elseif a:filetype == "vim" 
        call <SID>MapDelimiters("\"","") 
    elseif a:filetype == "virata" 
        call <SID>MapDelimiters("%", "")
    elseif a:filetype == "vrml" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "vsejcl" 
        call <SID>MapDelimiters("\\\/\\\*", "")
    elseif a:filetype == "webmacro" 
        call <SID>MapDelimiters("##", "")
    elseif a:filetype == "wget" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "winbatch" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "wml" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype =~ "[^w]*sh" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "wvdial" 
        call <SID>MapDelimiters(";", "")
    elseif a:filetype == "xdefaults" 
        call <SID>MapDelimiters("!", "")
    elseif a:filetype == "xf86conf" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "xkb" 
        call <SID>MapDelimiters("//", "")
    elseif a:filetype == "xmath" 
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "xml" 
        call <SID>MapDelimiters("<!--","-->") 
    elseif a:filetype == "xmodmap" 
        call <SID>MapDelimiters("!", "")
    elseif a:filetype == "xpm2" 
        call <SID>MapDelimiters("!", "")
    elseif a:filetype == "xpm" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "xslt" 
        call <SID>MapDelimiters("<!--","-->") 
    elseif a:filetype == "yacc" 
        call <SID>MapDelimiters("\\\/\\\*","\\\*\\\/")
    elseif a:filetype == "yaml"
        call <SID>MapDelimiters("#", "")
    elseif a:filetype == "z8a" 
        call <SID>MapDelimiters(";", "")

    elseif a:filetype == ""
	call <SID>MapDelimitersWithAlternative("","", "", "", 0) 

    "we have not hardcoded the comment delimiters to use for this filetype so
    "get them from &commentstring.
    else
	"print a disclaimer to the user :) 
        call <SID>NerdEcho("NERD_comments:Unknown filetype, setting delimiters by &commentstring", 0)
        
	"here we first get the delimiters then escape all the tricky chars in
	"them (eg *)
	let charsToEsc = '*/\."&$+'
	let left= escape(substitute(&commentstring, '\(.*\)%s.*', '\1', ''), charsToEsc)
	let right= escape(substitute(&commentstring, '.*%s\(.*\)', '\1', 'g'), charsToEsc)

	call <SID>MapDelimiters(left,right)
    endif

    " set up the space string for this filetype. If the user wants this
    " filetype to have a space after the left delim and before the right then
    " b:spaceString is ' '
    if a:filetype =~ g:NERD_space_delim_filetype_regexp 
	let b:spaceString = ' '
    else
	let b:spaceString = ''
    endif

endfunction

" Function: s:MapDelimiters(left, right) function {{{2
" This function is a wrapper for s:MapDelimiters(left, right, leftAlt, rightAlt, useAlt) and is called when there
" is no alternative comment delimiters for the current filetype
"
" Args:
"   -left: the left comment delimiter
"   -right: the right comment delimiter
function s:MapDelimiters(left, right)
    call <SID>MapDelimitersWithAlternative(a:left, a:right, "", "", 0)
endfunction

" Function: s:MapDelimitersWithAlternative(left, right, leftAlt, rightAlt, useAlt) function {{{2
" this function sets up the comment delimiter buffer variables
"
" Args:
"   -left:  the string defining the comment start delimiter
"   -right: the string defining the comment end delimiter
"   -leftAlt:  the string for the alternative comment style defining the comment start delimiter
"   -rightAlt: the string for the alternative comment style defining the comment end delimiter
"   -useAlt: a flag specifying whether to use the alternative comment style 0 is
"    false
function s:MapDelimitersWithAlternative(left, right, leftAlt, rightAlt, useAlt)

    " if the useAlt flag is not set then we use a:left and a:right
    " as the left and right comment delimiters
    if a:useAlt == 0
        let b:left = a:left
        let b:right = a:right
        let b:leftAlt = a:leftAlt
        let b:rightAlt = a:rightAlt
    else
        let b:left = a:leftAlt
        let b:right = a:rightAlt
        let b:leftAlt = a:left
        let b:rightAlt = a:right
    endif
endfunction

" Function: s:SwitchToAlternativeDelimiters(printMsgs) function {{{2
" This function is used to swap the delimiters that are being used to the
" alternative delimiters for that filetype. For example, if a c++ file is
" being edited and // comments are being used, after this function is called
" /**/ comments will be used.
"
" Args:
"   -printMsgs: if this is 1 then a message is echoed to the user telling them
"    if this function changed the delimiters or not 
function s:SwitchToAlternativeDelimiters(printMsgs)
    "if both of the alternative delimiters are empty then there is no
    "alternative comment style so bail out 
    if (b:leftAlt=="" && b:rightAlt=="")
	if a:printMsgs 
	    call <SID>NerdEcho("NERD_comments:Cannot use alternative delimiters, none are specified", 0)
	endif
	return 0
    endif

    "save the current delimiters 
    let tempLeft = b:left
    let tempRight = b:right

    "swap current delimiters for alternative 
    let b:left = b:leftAlt
    let b:right = b:rightAlt
    
    "set the previously current delimiters to be the new alternative ones 
    let b:leftAlt = tempLeft
    let b:rightAlt = tempRight

    "tell the user what comment delimiters they are now using 
    if a:printMsgs
	let leftNoEsc = <SID>UnEsc(b:left,"\\")
	let rightNoEsc = <SID>UnEsc(b:right,"\\")
        call <SID>NerdEcho("NERD_comments:Now using " . leftNoEsc . " " . rightNoEsc . " to delimit comments", 1)
    endif

    return 1
endfunction
												"}}}

" Section: Comment delimiter add/removal functions {{{1
" ============================================================================
" Function: s:AppendCommentToLine(){{{2
" This function appends comment delimiters at the EOL and places the cursor in
" position to start typing the comment
function s:AppendCommentToLine()
    " get the left and right delimiters without any escape chars in them 
    let left2 = <SID>UnEsc(b:left,'\')
    let right2 = <SID>UnEsc(b:right,'\')

    " get the len of the right delim
    let lenRight = strlen(right2) 
    
    let isLineEmpty = strlen(getline(".")) == 0
    let insOrApp = (isLineEmpty==1 ? 'i' : 'A')

    "stick the delimiters down at the end of the line. We have to format the
    "comment with spaces as appropriate 
    if lenRight > 0
        execute ":normal " . insOrApp . (isLineEmpty ? '' : ' ') . left2 . b:spaceString . b:spaceString . right2 . " "
    else
        execute ":normal " . insOrApp.  (isLineEmpty ? '' : ' ') . left2 . b:spaceString . " "
    endif

    " if there is a right delimiter then we gotta move the cursor left
    " by the len of the right delimiter so we insert between the delimiters
    if lenRight > 0 
        let leftMoveAmount = lenRight + strlen(b:spaceString) 
	execute ":normal " . leftMoveAmount . "h"
    endif
    startinsert
endfunction

" Function: s:CommentBlock(top, bottom, lSide, rSide, forceNested ) range {{{2
" This function is used to comment out a region of code. This region is
" specified as a bounding box by arguments to the function. Note that the
" range keyword is specified for this function. This is because this function
" cannot be applied implicitly to every line specified in visual mode
"
" Args:
"   -top: the line number for the top line of code in the region
"   -bottom: the line number for the bottom line of code in the region
"   -lSide: the column number for the left most column in the region
"   -rSide: the column number for the right most column in the region
"   -forceNested: a flag indicating whether comments should be nested 
function s:CommentBlock(top, bottom, lSide, rSide, forceNested ) range
    " we need to create local copies of these arguments so we can modify them
    let top = a:top
    let bottom = a:bottom
    let lSide = a:lSide
    let rSide = a:rSide

    "if the top or bottom line starts with tabs we have to adjust the left and
    "right boundries so that they are set as though the tabs were spaces 
    let topline = getline(top)
    let bottomline = getline(bottom)
    if topline =~ '^\t\t*'  || bottomline =~ '^\t\t*' 
	"find out how many tabs are in the top line and adjust the left
	"boundry accordingly 
	let numTabs = strlen(substitute(topline, '^\(\t*\).*$', '\1', "")) 
	if lSide < numTabs
	    let lSide = s:spacesPerTab * lSide
	else
	    let lSide = (lSide - numTabs) + (s:spacesPerTab * numTabs)
	endif

	"find out how many tabs are in the bottom line and adjust the right
	"boundry accordingly 
	let numTabs = strlen(substitute(bottomline, '^\(\t*\).*$', '\1', "")) 
	let rSide = (rSide - numTabs) + (s:spacesPerTab * numTabs)
    endif
    
    "we must check that bottom IS actually below top, if it is not then we
    "swap top and bottom. Similarly for left and right. 
    if bottom < top
        let temp = top
        let top = bottom
        let bottom = top
    endif
    if rSide < lSide
        let temp = lSide
        let lSide = rSide
        let rSide = temp
    endif

    "if the current delimiters arent multipart then we will switch to the
    "alternative delims (if THEY are) as the comment will be better and more
    "accurate with multipart delims 
    let didSwitchDelims = -1

    "if the right delim isnt empty then we can use it for this comment
    if b:right != '' || &filetype !~ g:NERD_allow_any_visual_delims_regexp
        let didSwitchDelims = 0
    "if the alternative comment right delimter isnt null then we can use the
    "alternative right delims 
    elseif b:rightAlt != ''
        let didSwitchDelims = 1
        call <sid>SwitchToAlternativeDelimiters(0)
    endif


    "get versions of left/right without the escape chars 
    let leftNoEsc = <SID>UnEsc(b:left,"\\")
    let rightNoEsc = <SID>UnEsc(b:right,"\\")

    "we need the len of leftNoEsc soon 
    let lenLeftNoEsc = strlen(leftNoEsc) 
    
    "we need the len of rightNoEsc soon 
    let lenRightNoEsc = strlen(rightNoEsc) 

    "start the commenting from the top and keep commenting till we reach the
    "bottom
    let currentLine=top
    while currentLine <= bottom

	"check if we are allowed to comment this line 
	if <SID>GetCanCommentLine(a:forceNested, currentLine)

	    "convert the leading tabs into spaces 
	    let theLine = getline(currentLine)
            let lineHasLeadTabs = <SID>HasLeadingTab(theLine)
            if lineHasLeadTabs
                let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
            endif

	    "dont comment lines that begin after the right boundry of the
	    "block unless the user has specified to do so
	    if theLine !~ '^ \{' . rSide . '\}' || g:NERD_block_com_after_right==1

		"lineLSide and lineRSide are used as indexes into theLine. They
		"are used to point to index where the left and right
		"delimiters will be placed on the current line. The position
		"of the delimiters may be altered if the current left position
		"is in the middle of a delimiter.
		let lineLSide = lSide
		let lineRSide = rSide

		"If the left or right boundaries are inside an existing
		"delimiter then adjust lineLSide and lineRSide appropriately so
		"that they are just after/before these delimiters
		let offset = <SID>GetIndxInSubstr(lSide-1, leftNoEsc, theLine)
		if offset > 0
		    let lineLSide = lSide + lenLeftNoEsc - offset
		endif
		let offset = <SID>GetIndxInSubstr(lSide-1, rightNoEsc, theLine)
		if offset > 0
		    let lineLSide = lSide - offset
		endif

		let offset = <SID>GetIndxInSubstr(rSide, rightNoEsc, theLine)
		if offset > 0
		    let lineRSide = rSide + lenRightNoEsc - offset
		endif
		let offset = <SID>GetIndxInSubstr(rSide, leftNoEsc, theLine)
		if offset > 0
		    let lineRSide = rSide + lenLeftNoEsc - offset
		endif
		
		let offset = <SID>GetIndxInSubstr(lSide-1, g:NERD_lPlace, theLine)
		if offset > 0
		    let lineLSide = lSide + strlen(g:NERD_lPlace) - offset
		endif
		let offset = <SID>GetIndxInSubstr(lSide-1, g:NERD_rPlace, theLine)
		if offset > 0
		    let lineLSide = lSide -  offset
		endif

		let offset = <SID>GetIndxInSubstr(rSide, g:NERD_rPlace, theLine)
		if offset > 0
		    let lineRSide = rSide + strlen(g:NERD_rPlace) - offset
		endif
		let offset = <SID>GetIndxInSubstr(rSide, g:NERD_lPlace, theLine)
		if offset > 0
		    let lineRSide = rSide + strlen(g:NERD_lPlace) - offset
		endif

		if b:leftAlt != ""
		    let leftANoEsc = <SID>UnEsc(b:leftAlt, '\\')
		    let rightANoEsc = <SID>UnEsc(b:rightAlt, '\\')
		    let lenRightANoEsc = strlen(rightANoEsc)
		    let lenLeftANoEsc = strlen(leftANoEsc)

		    let offset = <SID>GetIndxInSubstr(lSide-1, leftANoEsc, theLine)
		    if offset > 0
			let lineLSide = lSide + lenLeftANoEsc - offset
		    endif
		    let offset = <SID>GetIndxInSubstr(lSide-1, rightANoEsc, theLine)
		    if offset > 0
			let lineLSide = lSide - offset
		    endif

		    let offset = <SID>GetIndxInSubstr(rSide, rightANoEsc, theLine)
		    if offset > 0
			let lineRSide = rSide + lenRightNoEsc - offset
		    endif
		    let offset = <SID>GetIndxInSubstr(rSide, leftANoEsc, theLine)
		    if offset > 0
			let lineRSide = rSide + lenLeftANoEsc - offset
		    endif
		endif

		"attempt to place the cursor in on the left of the boundary box,
		"then check if we were successful, if not then we cant comment this
		"line 
                call setline(currentLine, theLine)
		call cursor(currentLine, lineLSide)
		if col(".") == lineLSide && line(".") == currentLine

		    "stick the left delimiter down 
		    let theLine = strpart(theLine, 0, lineLSide-1) . leftNoEsc . b:spaceString . strpart(theLine, lineLSide-1)

		    "attempt to go the the right boundary to place the right
		    "delimiter, if we cant go to the right boundary then the
		    "comment delimiter will be placed on the EOL. 
		    if rightNoEsc != ''
			call cursor(currentLine, lineRSide+lenLeftNoEsc+strlen(b:spaceString))

			"stick the right delimiter down 
			let lenSS = strlen(b:spaceString)
			let theLine = strpart(theLine, 0, lineRSide+lenLeftNoEsc+lenSS) . b:spaceString . rightNoEsc . strpart(theLine, lineRSide+lenRightNoEsc+lenSS)

			"get the first/last indxes of the delimiters and get
			"the string between them and call it searchStr
			let firstLeftDelim = <SID>FindDelimiterIndex(leftNoEsc, theLine)
			let lastRightDelim = <SID>GetLastIndexOfDelim(rightNoEsc, theLine)

			"if the user has placed somewhere so that
			"NERD_comments doesnt recognise it as a comment
			"delimiter then dont try to use place-holders as we'd
			"probably just screw it up more
			if firstLeftDelim != -1 && lastRightDelim != -1
			    let searchStr = strpart(theLine, 0, lastRightDelim)
			    let searchStr = strpart(searchStr, firstLeftDelim+strlen(leftNoEsc))

			    "replace the outter most delims in searchStr with
			    "place-holders 
			    let theLineWithPlaceHolders = <SID>ReplaceDelims(leftNoEsc, rightNoEsc, g:NERD_lPlace, g:NERD_rPlace, searchStr)

			    "add the right delimiter onto the line 
			    let theLine = strpart(theLine, 0, firstLeftDelim+strlen(leftNoEsc)) . theLineWithPlaceHolders . strpart(theLine, lastRightDelim)
			endif

		    endif
		    
		    
		endif
	    endif

            "restore tabs if needed
            if lineHasLeadTabs
                let theLine = <SID>ConvertLeadingSpacesToTabs(theLine)
            endif

            call setline(currentLine, theLine)
        endif


        "move onto the next line 
        let currentLine = currentLine + 1
    endwhile
    
    "if we switched delims then we gotta go back to what they were before 
    if didSwitchDelims == 1
        call <SID>SwitchToAlternativeDelimiters(0)
    endif
endfunction

" Function: s:CommentLines(forceNested, alignLeft, alignRight, firstLine, lastLine) range {{{2
" This function comments a range of lines.
"
" Args:
"   -forceNested: a flag indicating whether the called is requesting the comment
"    to be nested if need be
"   -alignRight/alignLeft: 0/1 if the comments delimiters should/shouldnt be
"    aligned left/right
"   -firstLine/lastLine: the top and bottom lines to comment
function s:CommentLines(forceNested, alignLeft, alignRight, firstLine, lastLine) range
    " we need to get the left and right indexes of the leftmost char in the
    " block of of lines and the right most char so that we can do alignment of
    " the delimiters if the user has specified
    let leftAlignIndx = <SID>GetLeftMostIndx(a:forceNested, a:firstLine, a:lastLine)
    let rightAlignIndx = <SID>GetRightMostIndx(a:forceNested, a:firstLine, a:lastLine)

    " gotta add the length of the left delimiter onto the rightAlignIndx cos
    " we'll be adding a left delim to the line
    let rightAlignIndx = rightAlignIndx + strlen(<SID>UnEsc(b:left, '\')) + strlen(b:spaceString)

    " now we actually comment the lines. Do it line by line 
    let currentLine = a:firstLine
    while currentLine <= a:lastLine

	" get the next line, check commentability and convert spaces to tabs 
	let theLine = getline(currentLine)
        let lineHasLeadingTabs = <SID>HasLeadingTab(theLine)
	let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
	if <SID>GetCanCommentLine(a:forceNested, currentLine) 
            "if the user has specified forceNesting then we check to see if we
            "need to switch delimiters for place-holders
            if a:forceNested && &filetype =~ g:NERD_place_holder_regexp
                let theLine = <SID>SwapOutterMultipPartDelimsForPlaceHolders(theLine)
            endif
            
            " find out if the line is commented using normal delims and/or
            " alternate ones 
            let isCommented = <SID>IsCommented(b:left, b:right, theLine)
            let isCommentedAlt = <SID>IsCommented(b:leftAlt, b:rightAlt, theLine)
        
            " check if we can comment this line 
            if (!isCommented && !isCommentedAlt) || &filetype =~ g:NERD_place_holder_regexp || b:right==""
                if a:alignLeft
                    let theLine = <SID>AddLeftDelimAligned(b:left, theLine, leftAlignIndx)
                else
                    let theLine = <SID>AddLeftDelim(b:left, theLine)
                endif
                if a:alignRight
                    let theLine = <SID>AddRightDelimAligned(b:right, theLine, rightAlignIndx)
                else
                    let theLine = <SID>AddRightDelim(b:right, theLine)
                endif
            endif
        endif

        " restore leading tabs if appropriate 
	if lineHasLeadingTabs
	    let theLine = <SID>ConvertLeadingSpacesToTabs(theLine)
	endif

	" we are done with this line 
	call setline(currentLine, theLine)
	let currentLine = currentLine + 1
    endwhile

endfunction

" Function: s:CommentLinesSexy(topline, bottomline) function {{{2
" This function is used to comment lines in the 'Sexy' style. eg in c:
" /*
"  * This is a sexy comment
"  */
" Args:
"   -topline: the line num of the top line in the sexy comment
"   -bottomline: the line num of the bottom line in the sexy comment
function s:CommentLinesSexy(topline, bottomline) range

    let left = <SID>UnEsc(<SID>GetSexyComLeft(), '\')
    let right = <SID>UnEsc(<SID>GetSexyComRight(), '\')

    "check if we can do a sexy comment with the available delimiters 
    if left == -1 || right == -1
	return -1
    endif

    let sexyComMarker = <SID>GetSexyComMarker()
    let sexyComMarkerUnEsc = <SID>UnEsc(sexyComMarker, '\')


    " we jam the comment as far to the right as possible 
    let leftAlignIndx = <SID>GetLeftMostIndx(1, a:topline, a:bottomline)

    "check whether the user has specified that this filetype use compact sexy
    "delimiters: i.e that the left/right delimiters should appear on the first
    "and last lines of the code and not on separate lines above/below the
    "first/last lines of code
    if &filetype =~ g:NERD_use_compact_sexy_com_regexp
	
	"comment the top line 
	let theLine = getline(a:topline)
        let lineHasTabs = <SID>HasLeadingTab(theLine)
        if lineHasTabs
            let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
        endif
        let theLine = <SID>SwapOutterMultipPartDelimsForPlaceHolders(theLine)
	let theLine = <SID>AddLeftDelimAligned(left, theLine, leftAlignIndx)
        if lineHasTabs
            let theLine = <SID>ConvertLeadingSpacesToTabs(theLine)
        endif
	call setline(a:topline, theLine)

	"comment the bottom line 
	let theLine = getline(a:bottomline)
        let lineHasTabs = <SID>HasLeadingTab(theLine)
        if lineHasTabs
            let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
        endif
        let theLine = <SID>SwapOutterMultipPartDelimsForPlaceHolders(theLine)
        let theLine = <SID>AddRightDelim(right, theLine)
        if lineHasTabs
            let theLine = <SID>ConvertLeadingSpacesToTabs(theLine)
        endif
	call setline(a:bottomline, theLine)
    else

	" add the left delimiter one line above the lines that are to be commented 
	call cursor(a:topline, 1) 
	execute 'normal! O'
	call setline(a:topline, strpart(s:spaces, 0, leftAlignIndx) . left )

	" add the right delimiter after bottom line (we have to add 1 cos we moved
	" the lines down when we added the left delim
	call cursor(a:bottomline+1, 1) 
	execute 'normal! o'
	call setline(a:bottomline+2, strpart(s:spaces, 0, leftAlignIndx) . strpart(s:spaces, 0, strlen(left)-strlen(sexyComMarkerUnEsc)) . right )

    endif

    " go thru each line adding the sexyComMarker marker to the start of each
    " line in the appropriate place to align them with the comment delims
    let currentLine = a:topline+1
    while currentLine <= a:bottomline + (&filetype !~ g:NERD_use_compact_sexy_com_regexp)
	" get the line and convert the tabs to spaces 
	let theLine = getline(currentLine)
        let lineHasTabs = <SID>HasLeadingTab(theLine)
        if lineHasTabs
            let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
        endif

	let theLine = <SID>SwapOutterMultipPartDelimsForPlaceHolders(theLine)

        " add the sexyComMarker 
        let theLine = strpart(s:spaces, 0, leftAlignIndx) . strpart(s:spaces, 0, strlen(left)-strlen(sexyComMarkerUnEsc)) . sexyComMarkerUnEsc . b:spaceString . strpart(theLine, leftAlignIndx)

        if lineHasTabs
            let theLine = <SID>ConvertLeadingSpacesToTabs(theLine)
        endif

        " set the line and move onto the next one 
        call setline(currentLine, theLine)
        let currentLine = currentLine + 1
    endwhile

endfunction

" Function: s:CommentLinesToggle(forceNested, alignLeft, alignRight, firstLine, lastLine) range {{{2
" Applies "toggle" commenting to the given range of lines
"
" Args:
"   -forceNested: a flag indicating whether the called is requesting the comment
"    to be nested if need be
"   -alignRight/alignLeft: 0/1 if the comments delimiters should/shouldnt be
"    aligned left/right
"   -firstLine/lastLine: the top and bottom lines to comment
function s:CommentLinesToggle(forceNested, alignLeft, alignRight, firstLine, lastLine) range
    " we need to get the left and right indexes of the leftmost char in the
    " block of of lines and the right most char so that we can do alignment of
    " the delimiters if the user has specified
    let leftAlignIndx = <SID>GetLeftMostIndx(a:forceNested, a:firstLine, a:lastLine)
    let rightAlignIndx = <SID>GetRightMostIndx(a:forceNested, a:firstLine, a:lastLine)

    " gotta add the length of the left delimiter onto the rightAlignIndx cos
    " we'll be adding a left delim to the line
    let rightAlignIndx = rightAlignIndx + strlen(<SID>UnEsc(b:left, '\')) + strlen(b:spaceString)

    " now we actually comment the lines. Do it line by line 
    let currentLine = a:firstLine
    while currentLine <= a:lastLine

	" get the next line, check commentability and convert spaces to tabs 
	let theLine = getline(currentLine)
        let lineHasLeadingTabs = <SID>HasLeadingTab(theLine)
	let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
        if theLine !~ '^[ \t]*$' && <SID>GetCanToggleCommentLine(a:forceNested, currentLine) 

            "if the user has specified forceNesting then we check to see if we
            "need to switch delimiters for place-holders
            if &filetype =~ g:NERD_place_holder_regexp
                let theLine = <SID>SwapOutterMultipPartDelimsForPlaceHolders(theLine)
            endif

            if a:alignLeft
                let theLine = <SID>AddLeftDelimAligned(b:left, theLine, leftAlignIndx)
            else
                let theLine = <SID>AddLeftDelim(b:left, theLine)
            endif
            if a:alignRight
                let theLine = <SID>AddRightDelimAligned(b:right, theLine, rightAlignIndx)
            else
                let theLine = <SID>AddRightDelim(b:right, theLine)
            endif

        "re-align the delims existing if needed 
        elseif (a:alignLeft || a:alignRight) && !a:forceNested && (<SID>IsCommentedFromStartOfLine(b:left, theLine) || <SID>IsCommentedFromStartOfLine(b:leftAlt, theLine)) 
            "get the delims the line is commented with 
            if <SID>IsCommentedFromStartOfLine(b:left, theLine) 
                let l:left = b:left
                let l:right = b:right
            else
                let l:left = b:leftAlt
                let l:right = b:rightAlt
            endif
            let theLine = <SID>UncommentLineNormal(theLine)

            if a:alignLeft
                let theLine = <SID>AddLeftDelimAligned(l:left, theLine, leftAlignIndx)
            else
                let theLine = <SID>AddLeftDelim(l:left, theLine)
            endif
            if a:alignRight
                let theLine = <SID>AddRightDelimAligned(l:right, theLine, rightAlignIndx)
            else
                let theLine = <SID>AddRightDelim(l:right, theLine)
            endif

        endif

        " restore leading tabs if appropriate 
	if lineHasLeadingTabs
	    let theLine = <SID>ConvertLeadingSpacesToTabs(theLine)
	endif

	" we are done with this line 
	call setline(currentLine, theLine)
	let currentLine = currentLine + 1
    endwhile

endfunction

" Function: s:CommentRegion(topline, topCol, bottomLine, bottomCol) function {{{2
" This function is designed to comment chunks of text selected in visual mode.
" It will comment exactly the text that they have selected.
" Args:
"   -topLine: the line num of the top line in the sexy comment
"   -topCol: top left col for this comment
"   -bottomline: the line num of the bottom line in the sexy comment
"   -bottomCol: the bottom right col for this comment
"   -forceNested: whether the caller wants comments to be nested if the
"    line(s) are already commented
function s:CommentRegion(topLine, topCol, bottomLine, bottomCol, forceNested) range
    "we may need to switch to the alt delims if the current ones arent
    "multi-part.
    let didSwitchDelims = -1

    "if the right delim isnt empty then we can use it for this comment
    if b:right != '' || &filetype !~ g:NERD_allow_any_visual_delims_regexp
        let didSwitchDelims = 0
    "if the alternative comment right delimter isnt null then we can use the
    "alternative right delims 
    elseif b:rightAlt != ''
        let didSwitchDelims = 1
        call <sid>SwitchToAlternativeDelimiters(0)
    endif

    "if there is only one line in the comment then just do it 
    if a:topLine == a:bottomLine
        call <SID>CommentBlock(a:topLine, a:bottomLine, a:topCol, a:bottomCol, a:forceNested)
    
    "there are multiple lines in the comment 
    else
        "comment the top line
        call <SID>CommentBlock(a:topLine, a:topLine, a:topCol, strlen(getline(a:topLine)), a:forceNested)

        "comment out all the lines in the middle of the comment 
        let topOfRange = a:topLine+1
        let bottomOfRange = a:bottomLine-1
        if topOfRange <= bottomOfRange
            call <SID>CommentLines(a:forceNested, 0, 0, topOfRange, bottomOfRange)
        endif

        "comment the bottom line 
        let bottom = getline(a:bottomLine)
        let numLeadingSpacesTabs = strlen(substitute(bottom, '^\([ \t]*\).*$', '\1', ''))
        call <SID>CommentBlock(a:bottomLine, a:bottomLine, numLeadingSpacesTabs+1, a:bottomCol, a:forceNested)

    endif

    "stick the cursor back on the char it was on before the comment
    call cursor(a:topLine, a:topCol + strlen(b:left) + &filetype =~ g:NERD_space_delim_filetype_regexp)
     
    "if we switched delims then we gotta go back to what they were before 
    if didSwitchDelims == 1
        call <SID>SwitchToAlternativeDelimiters(0)
    endif
    

endfunction


" Function: s:DoComment(forceNested, isVisual, alignLeft, alignRight, isSexy) function {{{2
" This function is a Wrapper for the main commenting functions
"
" Args:
"   -forceNested: a flag indicating whether comments should be nested 
"   -isVisual: a flag indicating whether the comment is requested in visual
"    mode or not
"   -alignLeft/alignRight: flags indicating whether the comment delimiters should be
"    aligned left/right
"   -isSexy: a flag indicating whether the comment is to be "sexy" or not
"   -isToggle: indicates whether the comment is a toggle comment
"   -isInvert: a flag indicating if the requested comment is a invert comment
function s:DoComment(forceNested, isVisual, alignLeft, alignRight, isSexy, isToggle, isInvert) range
    " we want case sensitivity when commenting 
    let prevIgnoreCase = &ignorecase
    set noignorecase

    " remember where teh cursor was intially so we can move it back
    if a:isVisual
        normal! gv
    endif
    call <SID>SaveCursorPosition()

    " find what visual mode the user is in and comment accordingly 
    if a:isVisual && visualmode() == ""
        call <SID>CommentBlock(line("'<"), line("'>"), col("'<"), col("'>"), a:forceNested)
    elseif a:isVisual && visualmode() == "v" && (g:NERD_comment_whole_lines_in_v_mode==0 || (g:NERD_comment_whole_lines_in_v_mode==2 && <SID>HasMultipartDelims()))
        call <SID>CommentRegion(line("'<"), col("'<"), line("'>"), col("'>"), a:forceNested)
    elseif a:isInvert
        call <SID>InvertComment(a:firstline, a:lastline)
    elseif a:isSexy
	" see if the selected regions have any sexy comments 
        let currentLine = a:firstline
        let foundSexyCom=0
        while(currentLine <= a:lastline)
            if(<SID>FindBoundingLinesOfSexyCom(currentLine) != -1)
                let foundSexyCom=1
                break
            endif
            let currentLine = currentLine + 1
        endwhile

	" we dont allow nested comments yet.. 
        if foundSexyCom 
            call <SID>NerdEcho("NERD_comments: Sexy comment aborted. Nested sexy commenting not supported", 0)
        else
            call <SID>CommentLinesSexy(a:firstline, a:lastline)
        endif

    " check if the user requested a toggle comment 
    elseif a:isToggle
        let theLine = getline(a:firstline)
	if <SID>FindBoundingLinesOfSexyCom(a:firstline)!=-1 || <SID>IsCommentedFromStartOfLine(b:left, theLine) || <SID>IsCommentedFromStartOfLine(b:leftAlt, theLine)
	    execute ':' . a:firstline . ',' . a:lastline .'call <SID>UncommentLines(1)'
	else
	    call <SID>CommentLinesToggle(a:forceNested, a:alignLeft, a:alignRight, a:firstline, a:lastline)
	endif

    " if nothing else then just default to normal commenting
    else
        call <SID>CommentLines(a:forceNested, a:alignLeft, a:alignRight, a:firstline, a:lastline)
    endif

    let &ignorecase = prevIgnoreCase

    " move the cursor back to where it was 
    call <SID>RestoreCursorPostion() 

endfunction

" Function: s:InvertComment(firstLine, lastLine) function {{{2
" Inverts the comments on the lines between and including the given line
" numbers i.e all commented lines are uncommented and vice versa
" Args:
"   -firstLine: the top of the range of lines to be inverted
"   -lastLine: the bottom of the range of lines to be inverted
function s:InvertComment(firstLine, lastLine) range

    " go thru all lines in teh given range 
    let currentLine = a:firstLine
    while currentLine <= a:lastLine
        let theLine = getline(currentLine)

        let sexyComBounds = <SID>FindBoundingLinesOfSexyCom(currentLine) 

        " if the line is commented normally, uncomment it 
        if <SID>IsCommentedFromStartOfLine(b:left, theLine) || <SID>IsCommentedFromStartOfLine(b:leftAlt, theLine)
            execute ':' currentLine . ',' . currentLine . 'call <SID>UncommentLines(1)'
            let currentLine = currentLine + 1

        " check if the line is commented sexually 
        elseif sexyComBounds != -1
            let topBound = substitute(sexyComBounds, '\(.*\),.*', '\1', '')
            let bottomBound = substitute(sexyComBounds, '.*,\(.*\)', '\1', '')
            let numLinesBeforeSexyComRemoved = <SID>GetNumLinesInBuf()
            call <SID>UncommentLinesSexy(topBound, bottomBound)

            "move to the line after last line of the sexy comment
            let numLinesAfterSexyComRemoved = <SID>GetNumLinesInBuf()
            let currentLine = bottomBound - (numLinesBeforeSexyComRemoved - numLinesAfterSexyComRemoved) + 1

        " the line isnt commented 
        else
            call <SID>CommentLinesToggle(1, 0, 0, currentLine, currentLine)
            let currentLine = currentLine + 1
        endif

    endwhile
endfunction

" Function: s:PlaceDelimitersAndInsBetween() function {{{2
" This is function is called to place comment delimiters down and place the
" cursor between them
function s:PlaceDelimitersAndInsBetween()
    " get the left and right delimiters without any escape chars in them 
    let left2 = <SID>UnEsc(b:left,"\\")
    let right2 = <SID>UnEsc(b:right,"\\")

    let theLine = getline(".")

    let lineHasLeadTabs = <SID>HasLeadingTab(theLine) || (theLine =~ '^ *$' && !&expandtab)

    "convert tabs to spaces and adjust teh cursors column to take this into
    "account
    let untabbedCol = <SID>GetUntabbedCol(theLine, col("."))
    call setline(line("."), <SID>ConvertLeadingTabsToSpaces(theLine))
    call cursor(line("."), untabbedCol)

    " get the len of the right delim
    let lenRight = strlen(right2) 

    let isDelimOnEOL = col(".") >= strlen(getline("."))

    " if the cursor is in the first col then we gotta insert rather than
    " append the comment delimiters here  
    let insOrApp = (col(".")==1 ? 'i' : 'a')

    " place the delimters down. We do it differently depending on whether
    " there is a left AND right delimiter 
    if lenRight > 0 
        execute ":normal " . insOrApp . left2 . b:spaceString . b:spaceString . right2 
        execute ":normal " . (lenRight + strlen(b:spaceString)) . "h"
    else
        execute ":normal " . insOrApp . left2 . b:spaceString  

        " if we are tacking the delim on the EOL then we gotta add a space
        " after it cos when we go out of insert mode the cursor will move back
        " one and the user wont be in position to type the comment.
        if isDelimOnEOL
            execute 'normal a '
        endif
    endif
    normal l
        
    "if needed convert spaces back to tabs and adjust teh cursors col
    "accordingly 
    if lineHasLeadTabs
        let tabbedCol = <SID>GetTabbedCol(getline("."), col("."))
        call setline(line("."), <SID>ConvertLeadingSpacesToTabs(getline(".")))
        call cursor(line("."), tabbedCol)
    endif

    startinsert
endfunction
 
" Function: s:PrependCommentToLine(){{{2
" This function prepends comment delimiters to the start of line and places
" the cursor in position to start typing the comment
function s:PrependCommentToLine()
    " get the left and right delimiters without any escape chars in them 
    let left2 = <SID>UnEsc(b:left,'\')
    let right2 = <SID>UnEsc(b:right,'\')

    " get the len of the right delim
    let lenRight = strlen(right2) 


    "if the line is empty then we need to know about this later on
    let isLineEmpty = strlen(getline(".")) == 0

    "stick the delimiters down at the start of the line. We have to format the
    "comment with spaces as appropriate 
    if lenRight > 0
        execute ":normal I" . left2 . b:spaceString . b:spaceString . right2 
    else
        execute ":normal I" . left2 . b:spaceString 
    endif

    " if there is a right delimiter then we gotta move the cursor left
    " by the len of the right delimiter so we insert between the delimiters
    if lenRight > 0 
        let leftMoveAmount = lenRight + strlen(b:spaceString) 
	execute ":normal " . leftMoveAmount . "h"
    endif
    normal l

    "if the line was empty then we gotta add an extra space on the end because
    "the cursor will move back one more at the end of the last "execute"
    "command
    if isLineEmpty && lenRight == 0
        execute ":normal a "
    endif

    startinsert
endfunction
" Function: s:RemoveDelimiters(left, right, line) {{{2
" this function is called to remove the first left comment delimiter and the
" last right delimiter of the given line. 
"
" The args left and right must be strings. If there is no right delimiter (as
" is the case for e.g vim file comments) them the arg right should be ""
"
" Args:
"   -left: the left comment delimiter
"   -right: the right comment delimiter
"   -line: the line to remove the delimiters from
function s:RemoveDelimiters(left, right, line)

    "get the left and right delimiters without the esc chars. Also, get their
    "lengths
    let l:left = <SID>UnEsc(a:left,"\\")
    let l:right = <SID>UnEsc(a:right,"\\")
    let lenLeft = strlen(left)
    let lenRight = strlen(right)

    let delimsSpaced = (b:spaceString == ' ' || &filetype !~ g:NERD_dont_remove_spaces_regexp)
    
    let line = a:line

    "look for the left delimiter, if we find it, remove it. 
    let leftIndx = <SID>FindDelimiterIndex(a:left, line)
    if leftIndx != -1
        let line = strpart(line, 0, leftIndx) . strpart(line, leftIndx+lenLeft)

	"if the user has specified that there is a space after the left delim
	"then check for the space and remove it if it is there
	if delimsSpaced && strpart(line, leftIndx, 1) == ' '
	    let line = strpart(line, 0, leftIndx) . strpart(line, leftIndx+1)
	endif
    endif

    "look for the right delimiter, if we find it, remove it 
    let rightIndx = <SID>FindDelimiterIndex(a:right, line)
    if rightIndx != -1
        let line = strpart(line, 0, rightIndx) . strpart(line, rightIndx+lenRight)

	"if the user has specified that there is a space before the right delim
	"then check for the space and remove it if it is there
	if delimsSpaced && strpart(line, rightIndx-1, 1) == ' ' && right != ''
	    let line = strpart(line, 0, rightIndx-1) . strpart(line, rightIndx)
	endif
    endif

    return line
endfunction

" Function: s:UncommentLines(onlyWholeLineComs) {{{2
" Args:
" This function uncomments the given lines
function s:UncommentLines(onlyWholeLineComs) range
    "make local copies of a:firstline and a:lastline and, if need be, swap
    "them around if the top line is below the bottom
    let l:firstline = a:firstline
    let l:lastline = a:lastline
    if firstline > lastline
	let firstline = lastline
	let lastline = a:firstline
    endif

    "go thru each line uncommenting each line removing sexy comments
    let currentLine = firstline
    while currentLine <= lastline

	"check the current line to see if it is part of a sexy comment 
	let sexyComBounds = <SID>FindBoundingLinesOfSexyCom(currentLine)
	if sexyComBounds != -1

            "we need to store the num lines in the buf before the comment is
            "removed so we know how many lines were removed when the sexy com
            "was removed
            let numLinesBeforeSexyComRemoved = <SID>GetNumLinesInBuf()

            "extract the top/bottom lines of the sexy comment and call the
            "appropriate function to remove the comment  
            let topBound = substitute(sexyComBounds, '\(.*\),.*', '\1', '')
            let bottomBound = substitute(sexyComBounds, '.*,\(.*\)', '\1', '')
            call <SID>UncommentLinesSexy(topBound, bottomBound)

            "move to the line after last line of the sexy comment
            let numLinesAfterSexyComRemoved = <SID>GetNumLinesInBuf()
            let currentLine = bottomBound - (numLinesBeforeSexyComRemoved - numLinesAfterSexyComRemoved) + 1
	
	"no sexy com was detected so uncomment the line as normal 
	else
	    let theLine = getline(currentLine)
	    if a:onlyWholeLineComs && (<SID>IsCommentedFromStartOfLine(b:left, theLine) || <SID>IsCommentedFromStartOfLine(b:leftAlt, theLine))
		call <SID>UncommentLinesNormal(currentLine, currentLine)
	    elseif !a:onlyWholeLineComs
		call <SID>UncommentLinesNormal(currentLine, currentLine)
	    endif
            let currentLine = currentLine + 1
	endif
    endwhile

endfunction

" Function: s:UncommentLinesSexy(topline, bottomline) {{{2
" This function removes all the comment characters associated with the sexy
" comment spanning the given lines
" Args:
"   -topline/bottomline: the top/bottom lines of the sexy comment
function s:UncommentLinesSexy(topline, bottomline)
    let left = <SID>GetSexyComLeft()
    let right = <SID>GetSexyComRight()

    "check if it is even possible for sexy comments to exist with the
    "available delimiters 
    if left == -1 || right == -1
	return -1
    endif

    let leftUnEsc = <SID>UnEsc(left, '\')
    let rightUnEsc = <SID>UnEsc(right, '\')

    let sexyComMarker = <SID>GetSexyComMarker()
    let sexyComMarkerUnEsc = <SID>UnEsc(sexyComMarker, '\')

    let removeSpace = (b:spaceString == ' ' || &filetype !~ g:NERD_dont_remove_spaces_regexp)


    "the markerOffset is how far right we need to move the sexyComMarker to
    "line it up with the end of the left delim
    let markerOffset = strlen(leftUnEsc)-strlen(sexyComMarkerUnEsc)

    " go thru the intermediate lines of the sexy comment and remove the
    " sexy comment markers (eg the '*'s on the start of line in a c sexy
    " comment) 
    let currentLine = a:topline+1
    while currentLine < a:bottomline
        let theLine = getline(currentLine)

        " remove the sexy comment marker from the line. We also remove the
        " space after it if there is one and if appropriate options are set
        let sexyComMarkerIndx = stridx(theLine, sexyComMarkerUnEsc)
        let l:spaceString = ''
        if strpart(theLine, sexyComMarkerIndx+strlen(sexyComMarkerUnEsc), 1) == ' '  && removeSpace
            let l:spaceString = ' '
        endif
        let theLine = strpart(theLine, 0, sexyComMarkerIndx - markerOffset) . strpart(theLine, sexyComMarkerIndx+strlen(sexyComMarkerUnEsc)+strlen(l:spaceString))

        let theLine = <SID>SwapOutterPlaceHoldersForMultiPartDelims(theLine)

        " move onto the next line 
        call setline(currentLine, theLine)
        let currentLine = currentLine + 1
    endwhile

    " gotta make a copy of a:bottomline cos we modify the position of the
    " last line  it if we remove the topline 
    let bottomline = a:bottomline

    " get the first line so we can remove the left delim from it 
    let theLine = getline(a:topline)

    " if the first line contains only the left delim then just delete it 
    if theLine =~ '^[ \t]*' . left . '[ \t]*$' && &filetype !~ g:NERD_use_compact_sexy_com_regexp
	call cursor(a:topline, 1)
	normal dd
	let bottomline = bottomline - 1
    
    " topline contains more than just the left delim 
    else

	" remove the delim. If there is a space after it
	" then remove this too if appropriate
	let delimIndx = stridx(theLine, leftUnEsc)
	let l:spaceString = ''
	if strpart(theLine, delimIndx+strlen(leftUnEsc), 1) == ' ' && removeSpace
	    let l:spaceString = ' '
	endif
	let theLine = strpart(theLine, 0, delimIndx) . strpart(theLine, delimIndx+strlen(leftUnEsc)+strlen(l:spaceString))
	let theLine = <SID>SwapOutterPlaceHoldersForMultiPartDelims(theLine)
	call setline(a:topline, theLine)
    endif

    " get the last line so we can remove the right delim
    let theLine = getline(bottomline)

    " if the bottomline contains only the right delim then just delete it 
    if theLine =~ '^[ \t]*' . right . '[ \t]*$'
	call cursor(bottomline, 1)
	normal dd

    " the last line contains more than the right delim  
    else
	" remove the right delim. If there is a space after it and
	" if the appropriate options are set then remove this too.
	let delimIndx = <SID>GetLastIndexOfDelim(rightUnEsc, theLine)
	let l:spaceString = ''
	if strpart(theLine, delimIndx+strlen(leftUnEsc), 1) == ' '  && removeSpace
	    let l:spaceString = ' '
	endif
	let theLine = strpart(theLine, 0, delimIndx) . strpart(theLine, delimIndx+strlen(rightUnEsc)+strlen(l:spaceString))

	" if the last line also starts with a sexy comment marker then we
	" remove this as well
	if theLine =~ '^[ \t]*' . sexyComMarker

	    " remove the sexyComMarker. If there is a space after it,
	    " remove this too if b:spaceString == ' '
	    let sexyComMarkerIndx = stridx(theLine, sexyComMarkerUnEsc)
	    let l:spaceString = ''
	    if strpart(theLine, sexyComMarkerIndx+strlen(sexyComMarkerUnEsc), 1) == ' '  && removeSpace
		let l:spaceString = ' '
	    endif
	    let theLine = strpart(theLine, 0, sexyComMarkerIndx - markerOffset ) . strpart(theLine, sexyComMarkerIndx+strlen(sexyComMarkerUnEsc)+strlen(l:spaceString))
	endif

	let theLine = <SID>SwapOutterPlaceHoldersForMultiPartDelims(theLine)
	call setline(bottomline, theLine)
    endif

endfunction

" Function: s:UncommentLineNormal(line) {{{2
" uncomments the given line and returns the result
" Args:
"   -line: the line to uncomment
function s:UncommentLineNormal(line)
    let line = a:line

    "get the comment status on the line so we know how it is commented 
    let lineCommentStatus =  <SID>IsCommentedOuttermost(b:leftAlt, b:rightAlt, b:left, b:right, line) 

    "it is commented with b:left and b:right so remove these delims
    if lineCommentStatus == 1 
        let line = <SID>RemoveDelimiters(b:leftAlt, b:rightAlt, line)
    
    "it is commented with b:leftAlt and b:rightAlt so remove these delims
    elseif lineCommentStatus == 2 && g:NERD_dont_remove_alt_coms==0
        let line = <SID>RemoveDelimiters(b:left, b:right, line)
    
    "it is not properly commented with any delims so we check if it has
    "any random left or right delims on it and remove the outtermost ones 
    else

        "get the positions of all delim types on the line 
        let indxLeft = <SID>FindDelimiterIndex(b:left, line)
        let indxLeftAlt = <SID>FindDelimiterIndex(b:leftAlt, line)
        let indxRight = <SID>FindDelimiterIndex(b:right, line)
        let indxRightAlt = <SID>FindDelimiterIndex(b:rightAlt, line)

        "remove the outter most left comment delim 
        if indxLeft != -1 && (indxLeft < indxLeftAlt || indxLeftAlt == -1)
            let line = <SID>ReplaceLeftMostDelim(b:left, '', line)
        elseif indxLeftAlt != -1
            let line = <SID>ReplaceLeftMostDelim(b:leftAlt, '', line)
        endif

        "remove the outter most right comment delim 
        if indxRight != -1 && (indxRight < indxRightAlt || indxRightAlt == -1)
            let line = <SID>ReplaceRightMostDelim(b:right, '', line)
        elseif indxRightAlt != -1
            let line = <SID>ReplaceRightMostDelim(b:rightAlt, '', line)
        endif
    endif


    let indxLeft = <SID>FindDelimiterIndex(b:left, line)
    let indxLeftAlt = <SID>FindDelimiterIndex(b:leftAlt, line)
    let indxLeftPlace = <SID>FindDelimiterIndex(g:NERD_lPlace, line)

    "if there are place-holders on the line then we check to see if they are
    "the outtermost delimiters on the line. If so then we replace them with
    "real delimiters
    if indxLeftPlace != -1 
        if (indxLeftPlace < indxLeft || indxLeft==-1) && (indxLeftPlace < indxLeftAlt || indxLeftAlt==-1)
            if b:right != ""
                let line = <SID>ReplaceDelims(g:NERD_lPlace, g:NERD_rPlace, <SID>UnEsc(b:left, "\\"), <SID>UnEsc(b:right, "\\"), line)
            else
                let line = <SID>ReplaceDelims(g:NERD_lPlace, g:NERD_rPlace, <SID>UnEsc(b:leftAlt, "\\"), <SID>UnEsc(b:rightAlt, "\\"), line)
            endif
        endif
    endif

    return line
endfunction

    " Function: s:UncommentLinesNormal(topline, bottomline) {{{2
    " This function is called to uncomment lines that arent a sexy comment
    " Args:
    "   -topline/bottomline: the top/bottom line numbers of the comment
    function s:UncommentLinesNormal(topline, bottomline)
	let currentLine = a:topline
	while currentLine <= a:bottomline
	    let line = getline(currentLine)
	    call setline(currentLine, <SID>UncommentLineNormal(line))
	    let currentLine = currentLine + 1
	endwhile
    endfunction
												"}}}


" Section: Other helper functions {{{1
" ============================================================================

" Function: s:AddLeftDelim(delim, theLine) {{{2
" Args:
function s:AddLeftDelim(delim, theLine)
    return substitute(a:theLine, '^\([ \t]*\)', '\1' . a:delim . b:spaceString, '')
endfunction

" Function: s:AddLeftDelimAligned(delim, theLine) {{{2
" Args:
function s:AddLeftDelimAligned(delim, theLine, alignIndx)
    return strpart(a:theLine, 0, a:alignIndx) . <SID>UnEsc(a:delim, '\') . b:spaceString . strpart(a:theLine, a:alignIndx)
endfunction

" Function: s:AddRightDelim(delim, theLine) {{{2
" Args:
function s:AddRightDelim(delim, theLine)
    if a:delim == ''
        return a:theLine
    else
        return substitute(a:theLine, '$', b:spaceString . a:delim, '')
    endif
endfunction

" Function: s:AddRightDelimAligned(delim, theLine, alignIndx) {{{2
" Args:
function s:AddRightDelimAligned(delim, theLine, alignIndx)
    if a:delim == ""
        return a:theLine
    else

        " when we align the right delim we are just adding spaces
        " so we get a string containing the needed spaces (it
        " could be empty)
        let extraSpaces = ''
        let extraSpaces = strpart(s:spaces, 0, a:alignIndx-strlen(a:theLine))

        " add the right delim 
        return substitute(a:theLine, '$', b:spaceString . extraSpaces . a:delim, '')
    endif
endfunction

" Function: s:ConvertLeadingSpacesToTabs(line) {{{2
" This function takes a line and converts all leading tabs on that line into
" spaces
"
" Args:
"   -line: the line whose leading tabs will be converted
function s:ConvertLeadingSpacesToTabs(line)
    let toReturn  = a:line
    while toReturn =~ '^\t*' . s:tabSpace . '\(.*\)$'
	let toReturn = substitute(toReturn, '^\(\t*\)' . s:tabSpace . '\(.*\)$'  ,  '\1\t\2' , "")
    endwhile
    
    return toReturn
endfunction


" Function: s:ConvertLeadingTabsToSpaces(line) {{{2
" This function takes a line and converts all leading spaces on that line into
" tabs
"
" Args:
"   -line: the line whose leading spaces will be converted
function s:ConvertLeadingTabsToSpaces(line)
    let toReturn  = a:line
    while toReturn =~ '^\( *\)\t'
	let toReturn = substitute(toReturn, '^\( *\)\t',  '\1' . s:tabSpace , "")
    endwhile
    
    return toReturn
endfunction

" Function: s:CountNonESCedOccurances(str, searchstr, escChar) {{{2
" This function counts the number of substrings contained in another string.
" These substrings are only counted if they are not escaped with escChar
" Args:
"   -str: the string to look for searchstr in
"   -searchstr: the substring to search for in str
"   -escChar: the escape character which, when preceding an instance of
"    searchstr, will cause it not to be counted
function s:CountNonESCedOccurances(str, searchstr, escChar)
    "get the index of the first occurance of searchstr
    let indx = stridx(a:str, a:searchstr)


    "if there is an instance of searchstr in str process it
    if indx != -1 
        "get the remainder of str after this instance of searchstr is removed
        let lensearchstr = strlen(a:searchstr)
        let strLeft = strpart(a:str, indx+lensearchstr)

        "if this instance of searchstr is not escaped, add one to the count
        "and recurse. If it is escaped, just recurse 
        if !<SID>IsEscaped(a:str, indx, a:escChar)
            return 1 + <SID>CountNonESCedOccurances(strLeft, a:searchstr, a:escChar)
        else
            return <SID>CountNonESCedOccurances(strLeft, a:searchstr, a:escChar)
        endif
    endif
endfunction

" Function: s:FindDelimiterIndex(delimiter, line) {{{2
" This function is used to get the string index of the input comment delimiter
" on the input line. If no valid comment delimiter is found in the line then
" -1 is returned
" Args:
"   -delimiter: the delimiter we are looking to find the index of
"   -line: the line we are looking for delimiter on
function s:FindDelimiterIndex(delimiter, line)
     
    "make sure the delimiter isnt empty otherwise we go into an infintie loop.
    if a:delimiter == ""
        return -1
    endif

    "get the delimiter without esc chars and its length
    let l:delimiter = <SID>UnEsc(a:delimiter,"\\")
    let lenDel = strlen(l:delimiter)

    "get the index of the first occurance of the delimter 
    let delIndx = stridx(a:line, l:delimiter)

    "keep looping thru the line till we either find a real comment delimiter
    "or run off the EOL 
    while delIndx != -1

        "if we are not off the EOL get the str before the possible delimiter
        "in question and check if it really is a delimiter. If it is, return
        "its position 
        if delIndx != -1
            if <SID>IsDelimValid(l:delimiter, delIndx, a:line)
                return delIndx
            endif
        endif

        "we have not yet found a real comment delimiter so move past the
        "current one we are lookin at 
        let restOfLine = strpart(a:line, delIndx + lenDel)
        let distToNextDelim = stridx(restOfLine , l:delimiter)

        "if distToNextDelim is -1 then there is no more potential delimiters
        "on the line so set delIndx to -1. Otherwise, move along the line by
        "distToNextDelim 
        if distToNextDelim == -1
            let delIndx = -1
        else
            let delIndx = delIndx + lenDel + distToNextDelim
        endif
    endwhile

    "there is no comment delimiter on this line 
    return -1
endfunction

" Function: s:FindBoundingLinesOfSexyCom(lineNum) {{{2
" This function takes in a line number and tests whether this line number is
" the top/bottom/middle line of a sexy comment. If it is then the top/bottom
" lines of the sexy comment are returned
" Args:
"   -lineNum: the line number that is to be tested whether it is the
"    top/bottom/midddle line of a sexy com
" Returns:
"   A string that has the top/bottom lines of the sexy comment encoded in it.
"   The format is 'topline,bottomline'. If a:lineNum turns out not to be the
"   top/bottom/middle of a sexy comment then -1 is returned
function s:FindBoundingLinesOfSexyCom(lineNum)

    "find which delimiters to look for as the start/end delims of the comment 
    let left = ''
    let right = ''
    if b:right != ''
	let left = b:left
	let right = b:right
    elseif b:rightAlt != ''
	let left = b:leftAlt
	let right = b:rightAlt
    else
	return -1 
    endif
    let leftUnEsc = <SID>UnEsc(left, '\')
    let rightUnEsc = <SID>UnEsc(right, '\')

    let sexyComMarker = <SID>GetSexyComMarker()

    "initialise the top/bottom line numbers of the sexy comment to -1
    let top = -1
    let bottom = -1

    let currentLine = a:lineNum
    while top == -1 || bottom == -1 
	let theLine = getline(currentLine)
	
	"check if the current line is the top of the sexy comment
	if theLine =~ '^[ \t]*' . left && theLine !~ '.*' . right
	    let top = currentLine
	    let currentLine = a:lineNum

	"check if the current line is the bottom of the sexy comment
	elseif theLine =~ '^[ \t]*' . right && theLine !~ '.*' . left
	    let bottom = currentLine
	
	"the right delimiter is on the same line as the last sexyComMarker 
	elseif theLine =~ '^[ \t]*' . sexyComMarker . '.*' . right
		let bottom = currentLine

	"we have not found the top or bottom line so we assume currentLine is an
	"intermediate line and look to prove otherwise 
	else

	    "if the line doesnt start with a sexyComMarker then it is not a sexy
	    "comment 
	    if theLine !~ '^[ \t]*' . sexyComMarker
		return -1
	    endif

	endif

	"if top is -1 then we havent found the top yet so keep looking up 
	if top == -1
	    let currentLine = currentLine - 1
	"if we have found the top line then go down looking for the bottom 
	else
	    let currentLine = currentLine + 1
	endif
	
    endwhile

	"encode the answer in a string and return it 
    return top . ',' . bottom
endfunction


" Function: s:GetCanCommentLine(forceNested, line) {{{2
"This function is used to determine whether the given line can be commented.
"It returns 1 if it can be and 0 otherwise
"
" Args:
"   -forceNested: a flag indicating whether the caller wants comments to be nested
"    if the current line is already commented
"   -lineNum: the line num of the line to check for commentability
function s:GetCanCommentLine(forceNested, lineNum)
    let theLine = getline(a:lineNum)

    " make sure we don't comment lines that are just spaces or tabs or empty.
    if theLine =~ "^[ \t]*$" 
	return 0
    endif
    
    "if the line is part of a sexy comment then just flag it...  
    if <SID>FindBoundingLinesOfSexyCom(a:lineNum) != -1
	return 0
    endif

    let isCommented = <SID>IsCommentedNormOrSexy(a:lineNum)
    let canUsePlaceHolders = (&filetype =~ g:NERD_place_holder_regexp)

    "if the line isnt commented return true
    if !isCommented 
	return 1
    endif

    "if the line is commented but nesting is allowed then return true
    if a:forceNested && (b:right=='' || canUsePlaceHolders)
	return 1
    endif

    return 0
endfunction

" Function: s:GetCanToggleCommentLine(forceNested, line) {{{2
"This function is used to determine whether the given line can be toggle commented.
"It returns 1 if it can be and 0 otherwise
"
" Args:
"   -lineNum: the line num of the line to check for commentability
function s:GetCanToggleCommentLine(forceNested, lineNum)
    let theLine = getline(a:lineNum)
    if (<SID>IsCommentedFromStartOfLine(b:left, theLine) || <SID>IsCommentedFromStartOfLine(b:leftAlt, theLine)) && !a:forceNested
        return 0
    endif

    " make sure we don't comment lines that are just spaces or tabs or empty.
    if theLine =~ "^[ \t]*$" 
	return 0
    endif
    
    "if the line is part of a sexy comment then just flag it...  
    if <SID>FindBoundingLinesOfSexyCom(a:lineNum) != -1
	return 0
    endif

    return 1
endfunction


" Function: s:GetColWierd() {{{2
" This function returns the column the cursor is in. It is needed cos finding
" out what col you are in when in visual mode is wierd
function s:GetColWierd()
    " get out of vis mode cos we cant get the col we are in if it is on... its
    " wierd but it works
    if visualmode() == "" ||  visualmode() == "V" || visualmode() == "v"
	normal 
        normal gv
        return col(".")
    else
        return col(".")
    endif
endfunction


" Function: s:GetIndxInSubstr(indx, substr, str) {{{2
" This function look for an occurance of substr that is pointed to by indx. An
" int is returned indicating how many chars into substr indx occurs. For
" example if str is "abcfoobar" and substr is "foobar" and indx is 5 then 2 is
" returned cos indx points 2 chars into substr
" 
" Args:
"   -indx: the indx to look for the occurance of substr at
"   -substr: the substring that we will get the relative index of indx to
"   -str: the string to look in
function s:GetIndxInSubstr(indx, substr, str)
    "validate params 
    if a:substr=="" || a:str=="" || a:indx<0
	return -1
    endif

    let lenSubstr = strlen(a:substr)

    "i is used to measure the relative dist from the last occurance of substr
    "to the next one. i2 is the absolute indx of the current instance of
    "substsr
    let i = 0 
    let i2 = 0
    
    "keep looping till there are no more instances of substr left
    while i != -1

	"get the indx of the next occurance of substr 
	let i = stridx(strpart(a:str, i2), a:substr)
	let i2 = i2 + i

	"if indx lies inside this instance of substr return its relative
	"position inside the substr 
	if i != -1 && a:indx < i2+lenSubstr && a:indx >= i2
	    return a:indx - i2
	endif

	"move past this instance of substr 
	let i2 = i2 + lenSubstr

    endwhile

    return -1
endfunction




" Function: s:GetLastIndexOfDelim(delim, str) {{{2
" This function takes a string and a delimiter and returns the last index of
" that delimiter in string
" Args:
"   -delim: the delimiter to look for
"   -str: the string to look for delim in
function s:GetLastIndexOfDelim(delim, str)
    let delim = <SID>UnEsc(a:delim, '\\')
    let lenDelim = strlen(delim)

    "set index to the first occurance of delim. If there is no occurance then
    "bail
    let indx = <SID>FindDelimiterIndex(delim, a:str)
    if indx == -1
	return -1
    endif

    "keep moving to the next instance of delim in str till there is none left 
    while 1
	
	"search for the next delim after the previous one
	let searchStr = strpart(a:str, indx+lenDelim)
	let indx2 = <SID>FindDelimiterIndex(delim, searchStr)

	"if we find a delim update indx to record the position of it, if we
	"dont find another delim then indx is the last one so break out of
	"this loop 
	if indx2 != -1
	    let indx = indx + indx2 + lenDelim
	else
	    break
	endif
    endwhile

    return indx

endfunction

" Function: s:GetLeftMostIndx(countCommentedLines, topline, bottomline) {{{2
" This function takes in 2 line numbers and returns the index of the left most
" char (that is not a space or a tab) on all of these lines. 
" Args:
"   -countCommentedLines: 1 if lines that are commented are to be checked as
"    well. 0 otherwise
"   -topline: the top line to be checked
"   -bottomline: the bottom line to be checked
function s:GetLeftMostIndx(countCommentedLines, topline, bottomline)
    
    " declare the left most index as an extreme value 
    let leftMostIndx = 1000

    " go thru the block line by line updating leftMostIndx 
    let currentLine = a:topline
    while currentLine <= a:bottomline

	" get the next line and if it is allowed to be commented, or is not
	" commented, check it
	let theLine = getline(currentLine)
	if theLine !~ '^[ \t]*$' && (a:countCommentedLines || (!<SID>IsCommented(b:left, b:right, theLine) && !<SID>IsCommented(b:leftAlt, b:rightAlt, theLine)))
	    " convert spaces to tabs and get the number of leading spaces for
	    " this line and update leftMostIndx if need be
            let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
	    let leadSpaceOfLine = strlen( substitute(theLine, '\(^[ \t]*\).*$','\1','') ) 
	    if leadSpaceOfLine < leftMostIndx
		let leftMostIndx = leadSpaceOfLine
	    endif

	endif

	" move on to the next line 
	let currentLine = currentLine + 1
    endwhile

    if leftMostIndx == 1000
	return 0
    else
	return leftMostIndx
    endif
endfunction

" Function: s:GetRightMostIndx(countCommentedLines, topline, bottomline) {{{2
" This function takes in 2 line numbers and returns the index of the right most
" char on all of these lines. 
" Args:
"   -countCommentedLines: 1 if lines that are commented are to be checked as
"    well. 0 otherwise
"   -topline: the top line to be checked
"   -bottomline: the bottom line to be checked
function s:GetRightMostIndx(countCommentedLines, topline, bottomline)
    let rightMostIndx = -1

    " go thru the block line by line updating rightMostIndx 
    let currentLine = a:topline
    while currentLine <= a:bottomline

	" get the next line and see if it is commentable, otherwise it doesnt
	" count
	let theLine = getline(currentLine)
	if theLine !~ '^[ \t]*$' && (a:countCommentedLines || (!<SID>IsCommented(b:left, b:right, theLine) && !<SID>IsCommented(b:leftAlt, b:rightAlt, theLine)))

	    " update rightMostIndx if need be 
	    let theLine = <SID>ConvertLeadingTabsToSpaces(theLine)
	    let lineLen = strlen(theLine)
	    if lineLen > rightMostIndx
		let rightMostIndx = lineLen
	    endif
	endif

	" move on to the next line 
	let currentLine = currentLine + 1
    endwhile
    
    return rightMostIndx
endfunction

" Function: s:GetNumLinesInBuf() {{{2
" Returns the number of lines in the current buffer
function s:GetNumLinesInBuf()
    return line('$')
endfunction

" Function: s:GetSexyComMarker() {{{2
" Returns the sexy comment marker for the current filetype.
" The sexy comment marker is the last char of the delimiter pair that has both
" left and right delims and has the longest left delim
function s:GetSexyComMarker()
    let sexyComMarker = b:sexyComMarker

    "if there isnt a sexyComMarker hardcoded then get one from the longest
    "left delimiter that has a corresponding right delim 
    if sexyComMarker == ''
	let lenLeft = strlen(<SID>UnEsc(b:left, '\'))
	let lenLeftAlt = strlen(<SID>UnEsc(b:leftAlt, '\'))
	let left = ''
	let right = ''
	if b:right != '' && lenLeft >= lenLeftAlt
	    let left = b:left
	elseif b:rightAlt != ''
	    let left = b:leftAlt
	else
	    return -1 
	endif

	"get the last char of left 
	let sexyComMarker = strpart(left, strlen(left)-1)

	let charsToEsc = '*/\."&$+'
	let sexyComMarker = escape(sexyComMarker, charsToEsc)
    endif
    return sexyComMarker
endfunction

" Function: s:GetSexyComLeft() {{{2
" Returns the left delimiter for sexy comments for this filetype or -1 if
" there is none
function s:GetSexyComLeft()
    let lenLeft = strlen(<SID>UnEsc(b:left, '\'))
    let lenLeftAlt = strlen(<SID>UnEsc(b:leftAlt, '\'))
    let left = ''
    if b:right != '' && lenLeft >= lenLeftAlt
	let left = b:left
    elseif b:rightAlt != ''
	let left = b:leftAlt
    else
	return -1
    endif
    return left
endfunction

" Function: s:GetSexyComRight() {{{2
" Returns the right delimiter for sexy comments for this filetype or -1 if
" there is none
function s:GetSexyComRight()
    let lenLeft = strlen(<SID>UnEsc(b:left, '\'))
    let lenLeftAlt = strlen(<SID>UnEsc(b:leftAlt, '\'))
    let left = ''
    if b:right != '' && lenLeft >= lenLeftAlt
	let right = b:right
    elseif b:rightAlt != ''
	let right = b:rightAlt
    else
	return -1
    endif
    return right
endfunction

" Function: s:GetTabbedCol(line, col) {{{2
" Gets the col number for given line and existing col number. The new col
" number is the col number when all leading spaces are converted to tabs
" Args:
"   -line:the line to get the rel col for
"   -col: the abs col 
function s:GetTabbedCol(line, col)
    let lineTruncated = strpart(a:line, 0, a:col)
    let lineSpacesToTabs = substitute(lineTruncated, s:tabSpace, '\t', 'g')
    return strlen(lineSpacesToTabs)
endfunction
" Function: s:GetUntabbedCol(line, col) {{{2
" Takes a line and a col and returns the absolute column of col taking into
" account that a tab is worth 3 or 4 (or whatever) spaces.
" Args:
"   -line:the line to get the abs col for
"   -col: the col that doesnt take into account tabs
function s:GetUntabbedCol(line, col)
    let lineTruncated = strpart(a:line, 0, a:col)
    let lineTabsToSpaces = substitute(lineTruncated, '\t', s:tabSpace, 'g')
    return strlen(lineTabsToSpaces)
endfunction
" Function: s:HasMultipartDelims() {{{2
" Returns 1 iff the current filetype has at least one set of multipart delims
function s:HasMultipartDelims()
    return (b:left != '' && b:right != '') || (b:leftAlt != '' && b:rightAlt != '')
endfunction

" Function: s:HasLeadingTab(str) {{{2
" Returns 1 iff the input has >= 1 leading tab
function s:HasLeadingTab(str)
    return a:str =~ '^\t.*'
endfunction

" Function: s:InstallDocumentation(full_name, revision)              {{{2
"   Install help documentation.
" Arguments:
"   full_name: Full name of this vim plugin script, including path name.
"   revision:  Revision of the vim script. #version# mark in the document file
"              will be replaced with this string with 'v' prefix.
" Return:
"   1 if new document installed, 0 otherwise.
" Note: Cleaned and generalized by guo-peng Wen.
"
" Note about authorship: this function was taken from the vimspell plugin
" which can be found at http://www.vim.org/scripts/script.php?script_id=465
"
function s:InstallDocumentation(full_name, revision)
    " Name of the document path based on the system we use:
    if has("vms")
         " No chance that this script will work with
         " VMS -  to much pathname juggeling here.
         return 1
    elseif (has("unix"))
        " On UNIX like system, using forward slash:
        let l:slash_char = '/'
        let l:mkdir_cmd  = ':silent !mkdir -p '
    else
        " On M$ system, use backslash. Also mkdir syntax is different.
        " This should only work on W2K and up.
        let l:slash_char = '\'
        let l:mkdir_cmd  = ':silent !mkdir '
    endif

    let l:doc_path = l:slash_char . 'doc'
    let l:doc_home = l:slash_char . '.vim' . l:slash_char . 'doc'

    " Figure out document path based on full name of this script:
    let l:vim_plugin_path = fnamemodify(a:full_name, ':h')
    let l:vim_doc_path    = fnamemodify(a:full_name, ':h:h') . l:doc_path
    if (!(filewritable(l:vim_doc_path) == 2))
         "Doc path: " . l:vim_doc_path
        call <SID>NerdEcho("Doc path: " . l:vim_doc_path, 0)
        execute l:mkdir_cmd . '"' . l:vim_doc_path . '"'
        if (!(filewritable(l:vim_doc_path) == 2))
            " Try a default configuration in user home:
            let l:vim_doc_path = expand("~") . l:doc_home
            if (!(filewritable(l:vim_doc_path) == 2))
                execute l:mkdir_cmd . '"' . l:vim_doc_path . '"'
                if (!(filewritable(l:vim_doc_path) == 2))
                    " Put a warning:
                    call <SID>NerdEcho("Unable to open documentation directory", 0)
                    call <SID>NerdEcho(" type :help add-local-help for more informations.", 0)
                    echo l:vim_doc_path
                    return 0
                endif
            endif
        endif
    endif

    " Exit if we have problem to access the document directory:
    if (!isdirectory(l:vim_plugin_path) || !isdirectory(l:vim_doc_path) || filewritable(l:vim_doc_path) != 2)
        return 0
    endif

    " Full name of script and documentation file:
    let l:script_name = fnamemodify(a:full_name, ':t')
    let l:doc_name    = fnamemodify(a:full_name, ':t:r') . '.txt'
    let l:plugin_file = l:vim_plugin_path . l:slash_char . l:script_name
    let l:doc_file    = l:vim_doc_path    . l:slash_char . l:doc_name

    " Bail out if document file is still up to date:
    if (filereadable(l:doc_file) && getftime(l:plugin_file) < getftime(l:doc_file))
        return 0
    endif

    " Prepare window position restoring command:
    if (strlen(@%))
        let l:go_back = 'b ' . bufnr("%")
    else
        let l:go_back = 'enew!'
    endif

    " Create a new buffer & read in the plugin file (me):
    setl nomodeline
    exe 'enew!'
    exe 'r ' . l:plugin_file

    setl modeline
    let l:buf = bufnr("%")
    setl noswapfile modifiable

    norm zR
    norm gg

    " Delete from first line to a line starts with
    " === START_DOC
    1,/^=\{3,}\s\+START_DOC\C/ d

    " Delete from a line starts with
    " === END_DOC
    " to the end of the documents:
    /^=\{3,}\s\+END_DOC\C/,$ d

    " Remove fold marks:
    % s/{\{3}[1-9]/    /

    " Add modeline for help doc: the modeline string is mangled intentionally
    " to avoid it be recognized by VIM:
    call append(line('$'), '')
    call append(line('$'), ' v' . 'im:tw=78:ts=8:ft=help:norl:')

    " Replace revision:
    "exe "normal :1s/#version#/ v" . a:revision . "/\<CR>"
    exe "normal :%s/#version#/ v" . a:revision . "/\<CR>"

    " Save the help document:
    exe 'w! ' . l:doc_file
    exe l:go_back
    exe 'bw ' . l:buf

    " Build help tags:
    exe 'helptags ' . l:vim_doc_path

    return 1
endfunction


" Function: s:IsCommentedNormOrSexy(lineNum) {{{2
"This function is used to determine whether the given line is commented with
"either set of delimiters or if it is part of a sexy comment
"
" Args:
"   -lineNum: the line number of the line to check
function s:IsCommentedNormOrSexy(lineNum)
    let theLine = getline(a:lineNum)

    "if the line is commented normally return 1
    if <SID>IsCommented(b:left, b:right, theLine) || <SID>IsCommented(b:leftAlt, b:rightAlt, theLine)
	return 1
    endif

    "if the line is part of a sexy comment return 1 
    if <SID>FindBoundingLinesOfSexyCom(a:lineNum) != -1
	return 1
    endif
    return 0
endfunction

" Function: s:IsCommented(left, right, line) {{{2
"This function is used to determine whether the given line is commented with
"the given delimiters
"
" Args:
"   -line: the line that to check if commented
"   -left/right: the left and right delimiters to check for
function s:IsCommented(left, right, line)
    "if the line isnt commented return true
    if <SID>FindDelimiterIndex(a:left, a:line) != -1 && (<SID>FindDelimiterIndex(a:right, a:line) != -1 || a:right == "")
	return 1
    endif
    return 0
endfunction

" Function: s:IsCommentedFromStartOfLine(left, line) {{{2
"This function is used to determine whether the given line is commented with
"the given delimiters at the start of the line i.e the left delimiter is the
"first thing on the line (apart from spaces\tabs)
"
" Args:
"   -line: the line that to check if commented
"   -left: the left delimiter to check for
function s:IsCommentedFromStartOfLine(left, line)
    let theLine = <SID>ConvertLeadingTabsToSpaces(a:line)
    let numSpaces = strlen(substitute(theLine, '^\( *\).*$', '\1', ''))
    let delimIndx = <SID>FindDelimiterIndex(a:left, theLine)
    return delimIndx == numSpaces
endfunction

" Function: s:IsCommentedOuttermost(left, right, leftAlt, rightAlt, line) {{{2
" Finds the type of the outtermost delims on the line
"
" Args:
"   -line: the line that to check if the outtermost comments on it are
"    left/right
"   -left/right: the left and right delimiters to check for
"   -leftAlt/rightAlt: the left and right alternative delimiters to check for
"
" Returns:
"   0 if the line is not commented with either set of delims
"   1 if the line is commented with the left/right delim set
"   2 if the line is commented with the leftAlt/rightAlt delim set
function s:IsCommentedOuttermost(left, right, leftAlt, rightAlt, line)
    "get the first positions of the left delims and the last positions of the
    "right delims
    let indxLeft = <SID>FindDelimiterIndex(a:left, a:line)
    let indxLeftAlt = <SID>FindDelimiterIndex(a:leftAlt, a:line)
    let indxRight = <SID>GetLastIndexOfDelim(a:right, a:line)
    let indxRightAlt = <SID>GetLastIndexOfDelim(a:rightAlt, a:line)

    "check if the line has a left delim before a leftAlt delim 
    if (indxLeft <= indxLeftAlt || indxLeftAlt == -1) && indxLeft != -1 
	"check if the line has a right delim after any rightAlt delim
	if (indxRight > indxRightAlt && indxRight > indxLeft) || a:right == ''
	    return 1
	endif

    "check if the line has a leftAlt delim before a left delim 
    elseif (indxLeftAlt <= indxLeft || indxLeft == -1) && indxLeftAlt != -1
	"check if the line has a rightAlt delim after any right delim
	if (indxRightAlt > indxRight && indxRightAlt > indxLeftAlt) || a:rightAlt == ''
	    return 2
	endif
    else
	return 0
    endif

    return 0

endfunction


" Function: s:IsDelimValid(delimiter, delIndx, line) {{{2
" This function is responsible for determining whether a given instance of a
" comment delimiter is a real delimiter or not. For example, in java the
" // string is a comment delimiter but in the line:
"               System.out.println("//");
" it does not count as a comment delimiter. This function is responsible for
" distinguishing between such cases. It does so by applying a set of
" heuristics that are not fool proof but should work most of the time.
"
" Args:
"   -delimiter: the delimiter we are validating
"   -delIndx: the position of delimiter in line
"   -line: the line that delimiter occurs in
"
" Returns:
" 0 if the given delimiter is not a real delimiter (as far as we can tell) , 
" 1 otherwise
function s:IsDelimValid(delimiter, delIndx, line)
    "get the delimiter without the escchars 
    let l:delimiter = <SID>UnEsc(a:delimiter,"\\")

    "get the strings before and after the delimiter 
    let preComStr = strpart(a:line, 0, a:delIndx)
    let postComStr = strpart(a:line, a:delIndx+strlen(delimiter))

    "to check if the delimiter is real, make sure it isnt preceded by
    "an odd number of quotes and followed by the same (which would indicate
    "that it is part of a string and therefore is not a comment)
    if !<SID>IsNumEven(<SID>CountNonESCedOccurances(preComStr, '"', "\\")) && !<SID>IsNumEven(<SID>CountNonESCedOccurances(postComStr, '"', "\\")) 
        return 0
    endif
    if !<SID>IsNumEven(<SID>CountNonESCedOccurances(preComStr, "'", "\\")) && !<SID>IsNumEven(<SID>CountNonESCedOccurances(postComStr, "'", "\\")) 
        return 0
    endif
    if !<SID>IsNumEven(<SID>CountNonESCedOccurances(preComStr, "`", "\\")) && !<SID>IsNumEven(<SID>CountNonESCedOccurances(postComStr, "`", "\\")) 
        return 0
    endif


    "if the comment delimiter is escaped, assume it isnt a real delimiter 
    if <SID>IsEscaped(a:line, a:delIndx, "\\")
        return 0
    endif
    
    "vim comments are so fuckin stupid!! Why the hell do they have comment
    "delimiters that are used elsewhere in the syntax?!?! We need to check
    "some conditions especially for vim 
    if &filetype == "vim"
	if !<SID>IsNumEven(<SID>CountNonESCedOccurances(preComStr, '"', "\\"))
	    return 0
	endif
        
        "if the delimiter is on the very first char of the line or is the
        "first non-tab/space char on the line then it is a valid comment delimiter 
        if a:delIndx == 0 || a:line =~ "^[ \t]\\{" . a:delIndx . "\\}\".*$"
            return 1
        endif

        let numLeftParen =<SID>CountNonESCedOccurances(preComStr, "(", "\\") 
        let numRightParen =<SID>CountNonESCedOccurances(preComStr, ")", "\\") 

        "if the quote is inside brackets then assume it isnt a comment 
        if numLeftParen > numRightParen
           return 0
        endif

        "if the line has an even num of unescaped "'s then we can assume that
        "any given " is not a comment delimiter
        if <SID>IsNumEven(<SID>CountNonESCedOccurances(a:line, "\"", "\\"))
            return 0
        endif
    endif

    return 1

endfunction

" Function: s:IsNumEven(num) {{{2
" A small function the returns 1 if the input number is even and 0 otherwise
" Args:
"   -num: the number to check
function s:IsNumEven(num)
    return (a:num % 2) == 0
endfunction

" Function: s:IsEscaped(str, indx, escChar) {{{2
" This function takes a string, an index into that string and an esc char and
" returns 1 if the char at the index is escaped (i.e if it is preceded by an
" odd number of esc chars)
" Args:
"   -str: the string to check
"   -indx: the index into str that we want to check
"   -escChar: the escape char the char at indx may be ESCed with
function s:IsEscaped(str, indx, escChar)
    "initialise numEscChars to 0 and look at the char before indx 
    let numEscChars = 0
    let curIndx = a:indx-1

    "keep going back thru str until we either reach the start of the str or
    "run out of esc chars 
    while curIndx >= 0 && strpart(a:str, curIndx, 1) == a:escChar
        
        "we have found another esc char so add one to the count and move left
        "one char
        let numEscChars  = numEscChars + 1
        let curIndx = curIndx - 1

    endwhile

    "if there is an odd num of esc chars directly before the char at indx then
    "the char at indx is escaped
    return !<SID>IsNumEven(numEscChars)
endfunction

" Function: s:IsSexyComment(topline, bottomline) {{{2
" This function takes in 2 line numbers and returns 1 if the lines between and
" including the given line numbers are a sexy comment. It returns 0 otherwise.
" Args:
"   -topline: the line that the possible sexy comment starts on
"   -bottomline: the line that the possible sexy comment stops on
function s:IsSexyComment(topline, bottomline)

    "get the delim set that would be used for a sexy comment 
    let left = ''
    let right = ''
    if b:right != ''
	let left = b:left
	let right = b:right
    elseif b:rightAlt != ''
	let left = b:leftAlt
	let right = b:rightAlt
    else
	return 0
    endif

    "swap the top and bottom line numbers around if need be  
    let topline = a:topline
    let bottomline = a:bottomline
    if bottomline < topline 
	topline = bottomline
	bottomline = a:topline
    endif

    "if there is < 2 lines in the comment it cannot be sexy 
    if (bottomline - topline) <= 0
	return 0
    endif

    "if the top line doesnt begin with a left delim then the comment isnt sexy 
    if getline(a:topline) !~ '^[ \t]*' . left
	return 0
    endif

    "if there is a right delim on the top line then this isnt a sexy comment 
    if <SID>FindDelimiterIndex(right, getline(a:topline)) != -1
	return 0
    endif
    
    "if there is a left delim on the bottom line then this isnt a sexy comment 
    if <SID>FindDelimiterIndex(left, getline(a:bottomline)) != -1
	return 0
    endif

    "if the bottom line doesnt begin with a right delim then the comment isnt
    "sexy 
    if getline(a:bottomline) !~ '^.*' . right . '$'
		return 0
    endif

    let sexyComMarker = <SID>GetSexyComMarker()

    "check each of the intermediate lines to make sure they start with a
    "sexyComMarker 
    let currentLine = a:topline+1
    while currentLine < a:bottomline
	let theLine = getline(currentLine)

	if theLine !~ '^[ \t]*' . sexyComMarker 
		return 0
	endif

	"if there is a right delim in an intermediate line then the block isnt
	"a sexy comment
	if <SID>FindDelimiterIndex(right, theLine) != -1
		return 0
	endif

	let currentLine = currentLine + 1
    endwhile

    "we have not found anything to suggest that this isnt a sexy comment so
    "return 1 
    return 1

endfunction

" Function: s:NerdEcho(msg, typeOfMsg) {{{2
" Echos the given message in the given style iff the NERD_shut_up option is
" not set
" Args:
"   -msg: the message to echo
"   -typeOfMsg: 0 = warning message
"               1 = normal message
function s:NerdEcho(msg, typeOfMsg)
    if g:NERD_shut_up
        return
    endif

    if a:typeOfMsg == 0
        echohl WarningMsg
        echo a:msg
        echohl None
    elseif a:typeOfMsg == 1
        echo a:msg
    endif
endfunction

" Function: s:ReplaceDelims(toReplace1, toReplace2, replacor1, replacor2, str) {{{2
" This function takes in a string, 2 delimiters in that string and 2 strings
" to replace these delimiters with.
" 
" Args:
"   -toReplace1: the first delimiter to replace
"   -toReplace2: the second delimiter to replace
"   -replacor1: the string to replace toReplace1 with
"   -replacor2: the string to replace toReplace2 with
"   -str: the string that the delimiters to be replaced are in
function s:ReplaceDelims(toReplace1, toReplace2, replacor1, replacor2, str)
    let line = <SID>ReplaceLeftMostDelim(a:toReplace1, a:replacor1, a:str)
    let line = <SID>ReplaceRightMostDelim(a:toReplace2, a:replacor2, line)
    return line
endfunction

" Function: s:ReplaceLeftMostDelim(toReplace, replacor, str) {{{2
" This function takes a string and a delimiter and replaces the left most
" occurance of this delimiter in the string with a given string
"
" Args:
"   -toReplace: the delimiter in str that is to be replaced
"   -replacor: the string to replace toReplace with
"   -str: the string that contains toReplace
function s:ReplaceLeftMostDelim(toReplace, replacor, str)
    let toReplace = <SID>UnEsc(a:toReplace, '\\')
    let replacor = <SID>UnEsc(a:replacor, '\\')
    "get the left most occurance of toReplace 
    let indxToReplace = <SID>FindDelimiterIndex(toReplace, a:str)

    "if there IS an occurance of toReplace in str then replace it and return
    "the resulting string 
    if indxToReplace != -1
	let line = strpart(a:str, 0, indxToReplace) . replacor . strpart(a:str, indxToReplace+strlen(toReplace))
	return line
    endif

    return a:str
endfunction

" Function: s:ReplaceRightMostDelim(toReplace, replacor, str) {{{2
" This function takes a string and a delimiter and replaces the right most
" occurance of this delimiter in the string with a given string
"
" Args:
"   -toReplace: the delimiter in str that is to be replaced
"   -replacor: the string to replace toReplace with
"   -str: the string that contains toReplace
" 
function s:ReplaceRightMostDelim(toReplace, replacor, str)
    let toReplace = <SID>UnEsc(a:toReplace, '\\')
    let replacor = <SID>UnEsc(a:replacor, '\\')
    let lenToReplace = strlen(toReplace)

    "get the index of the last delim in str 
    let indxToReplace = <SID>GetLastIndexOfDelim(toReplace, a:str)

    "if there IS a delimiter in str, replace it and return the result 
    let line = a:str
    if indxToReplace != -1
	let line = strpart(a:str, 0, indxToReplace) . replacor . strpart(a:str, indxToReplace+strlen(toReplace))
    endif
    return line
endfunction

" Function: s:SaveCursorPosition() {{{2
" Saves where the cursor is using the s and t registers. See also
" RestoreCursorPostion()
function s:SaveCursorPosition()
    " see :h restore-position for details of how this works
    let b:old_s_reg=@s
    let b:old_t_reg=@t
    normal! ms
    normal! H
    normal! mt
    normal! ``
endfunction

" Function: s:SwapOutterMultipPartDelimsForPlaceHolders(line) {{{2
" This function takes a line and swaps the outter most multi-part delims for
" place holders
" Args:
"   -line: the line to swap the delims in
" 
function s:SwapOutterMultipPartDelimsForPlaceHolders(line)
    " find out if the line is commented using normal delims and/or
    " alternate ones 
    let isCommented = <SID>IsCommented(b:left, b:right, a:line)
    let isCommentedAlt = <SID>IsCommented(b:leftAlt, b:rightAlt, a:line)

    let line2 = a:line

    "if the line is commented and there is a right delimiter, replace
    "the delims with place-holders
    if isCommented && b:right != ""
	let line2 = <SID>ReplaceDelims(b:left, b:right, g:NERD_lPlace, g:NERD_rPlace, a:line)
    
    "similarly if the line is commented with the alternative
    "delimiters 
    elseif isCommentedAlt && b:rightAlt != ""
	let line2 = <SID>ReplaceDelims(b:leftAlt, b:rightAlt, g:NERD_lPlace, g:NERD_rPlace, a:line)
    endif

    return line2
endfunction


" Function: s:SwapOutterPlaceHoldersForMultiPartDelims(line) {{{2
" This function takes a line and swaps the outtermost place holders for
" multi-part delims
" Args:
"   -line: the line to swap the delims in
" 
function s:SwapOutterPlaceHoldersForMultiPartDelims(line)
    let left = ''
    let right = ''
    if b:right != ''
	let left = b:left
	let right = b:right
    elseif b:rightAlt != ''
	let left = b:leftAlt
	let right = b:rightAlt
    endif

    let line = <SID>ReplaceDelims(g:NERD_lPlace, g:NERD_rPlace, left, right, a:line)
    return line
endfunction

" Function: s:RestoreCursorPosition() {{{2
" Restores where the cursor is using the s and t registers. See also
" RestoreCursorPostion(). Sets the s and t registers back to their original
" values before SaveCursorPosition was called
function s:RestoreCursorPostion()
    " see :h restore-position for details of how this works
    let @s=b:old_s_reg
    let @t=b:old_t_reg
    normal! `t
    normal! zt
    normal! `s
endfunction
" Function: s:UnEsc(str, escChar) {{{2
" This function removes all the escape chars from a string
" Args:
"   -str: the string to remove esc chars from
"   -escChar: the escape char to be removed
function s:UnEsc(str, escChar)
    return substitute(a:str, a:escChar, "", "g")
endfunction
												"}}}

" Section: Comment mapping setup {{{1
" ===========================================================================
" This is where the mappings calls are made that set up the commenting key
" mappings.

" set up the mapping to switch to/from alternative delimiters 
execute 'nnoremap <silent>' . g:NERD_alt_com_map . ' :call <SID>SwitchToAlternativeDelimiters(1)<cr>'

" set up the mappings to comment out lines
execute 'nnoremap <silent>' . g:NERD_com_line_map . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 0, 0, 0, 0, g:NERD_use_toggle_coms_default, 0)<cr><ESC>'
execute 'vnoremap <silent>' . g:NERD_com_line_map . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 1, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, &filetype =~ g:NERD_use_sexy_coms_default_regexp, g:NERD_use_toggle_coms_default, 0)<cr><ESC>'

" set up the mappings to comment out lines
execute 'nnoremap <silent>' . g:NERD_com_line_toggle_map . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 0, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, 0, 1, 0)<cr><ESC>'
execute 'vnoremap <silent>' . g:NERD_com_line_toggle_map . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 1, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, 0, 1, 0)<cr><ESC>'

" set up the mappings to comment out lines sexily
execute 'nnoremap <silent>' . g:NERD_com_line_sexy_map . ' :call <SID>DoComment(0, 0, 0, 0, 1, 0, 0)<CR>'
execute 'vnoremap <silent>' . g:NERD_com_line_sexy_map . ' :call <SID>DoComment(0, 1, 0, 0, 1, 0, 0)<CR>'

" set up the mappings to do invert comments
execute 'nnoremap <silent>' . g:NERD_com_line_invert_map . ' :call <SID>DoComment(0, 0, 0, 0, 0, 0, 1)<CR>'
execute 'vnoremap <silent>' . g:NERD_com_line_invert_map . ' :call <SID>DoComment(0, 1, 0, 0, 0, 0, 1)<CR>'

" set up the mappings to yank then comment out lines
execute 'nmap <silent>' . g:NERD_com_line_yank_map . ' "0Y' . g:NERD_com_line_map 
execute 'vmap <silent>' . g:NERD_com_line_yank_map . ' "0ygv' . g:NERD_com_line_map

" set up the mappings for left aligned comments 
execute 'nnoremap <silent>' . g:NERD_com_align_left_map . ' :call <SID>DoComment(1, 0, 1, 0, 0, 0, 0)<cr><ESC>'
execute 'vnoremap <silent>' . g:NERD_com_align_left_map . ' :call <SID>DoComment(1, 1, 1, 0, 0, 0, 0)<cr><ESC>'

" set up the mappings for right aligned comments 
execute 'nnoremap <silent>' . g:NERD_com_align_right_map . ' :call <SID>DoComment(1, 0, 0, 1, 0, 0, 0)<cr><ESC>'
execute 'vnoremap <silent>' . g:NERD_com_align_right_map . ' :call <SID>DoComment(1, 1, 0, 1, 0, 0, 0)<cr><ESC>'

" set up the mappings for left and right aligned comments 
execute 'nnoremap <silent>' . g:NERD_com_align_both_map . ' :call <SID>DoComment(1, 0, 1, 1, 0, 0, 0)<cr><ESC>'
execute 'vnoremap <silent>' . g:NERD_com_align_both_map . ' :call <SID>DoComment(1, 1, 1, 1, 0, 0, 0)<cr><ESC>'

" set up the mappings to do nested comments 
execute 'nnoremap <silent>' . g:NERD_com_line_nest_map . ' :call <SID>DoComment(1, 0, 0, 0, 0, 0, 0)<cr><ESC>'
execute 'vnoremap <silent>' . g:NERD_com_line_nest_map . ' :call <SID>DoComment(1, 1, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, 0, 0, 0)<cr><ESC>'

" set up the mapping to uncomment a line 
execute 'nnoremap <silent>' . g:NERD_uncom_line_map . ' :call <SID>UncommentLines(0)<cr><ESC>'
execute 'vnoremap <silent>' . g:NERD_uncom_line_map . ' :call <SID>UncommentLines(0)<cr> gv'

" set up the mapping to comment out to the end of the line
execute 'nnoremap <silent>' . g:NERD_com_to_end_of_line_map . ' :call <SID>SaveCursorPosition()<cr>:call <SID>CommentBlock(line("."), line("."), col("."), col("$")-1, 1)<cr>:call <SID>RestoreCursorPostion()<cr><ESC>'

" set up the mappings to append comments to the line
execute 'nmap <silent>' . g:NERD_append_com_map . ' :call <SID>AppendCommentToLine()<cr>'

" set up the mappings to append comments to the line
execute 'nmap <silent>' . g:NERD_prepend_com_map . ' :call <SID>PrependCommentToLine()<cr>'

" set up the mapping to insert comment delims at the cursor position in insert
" mode
execute 'inoremap <silent>' . g:NERD_com_in_insert_map . ' ' . '<SPACE><BS><ESC>:call <SID>PlaceDelimitersAndInsBetween()<CR>'

" Section: Menu item setup {{{1
" ===========================================================================
execute 'nmenu <silent> &Comment.Comment<TAB>' . escape(g:NERD_com_line_map, '\') . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 0, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, 0, g:NERD_use_toggle_coms_default, 0)<CR><ESC>'
execute 'vmenu <silent> &Comment.Comment<TAB>' . escape(g:NERD_com_line_map, '\') . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 1, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, &filetype =~ g:NERD_use_sexy_coms_default_regexp, g:NERD_use_toggle_coms_default, 0)<CR><ESC>'

execute 'nmenu <silent> &Comment.Comment\ Toggle<TAB>' . escape(g:NERD_com_line_toggle_map, '\') . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 0, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, 0, 1, 0)<CR><ESC>'
execute 'vmenu <silent> &Comment.Comment\ Toggle<TAB>' . escape(g:NERD_com_line_toggle_map, '\') . ' :call <SID>DoComment(g:NERD_use_nested_comments_default, 1, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, &filetype =~ g:NERD_use_sexy_coms_default_regexp, 1, 0)<CR><ESC>'

execute 'nmenu <silent> &Comment.Comment\ Nested<TAB>' . escape(g:NERD_com_line_nest_map, '\') . ' :call <SID>DoComment(1, 0, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, 0 ,0, 0)<CR><ESC>'
execute 'vmenu <silent> &Comment.Comment\ Nested<TAB>' . escape(g:NERD_com_line_nest_map, '\') . ' :call <SID>DoComment(1, 1, &filetype =~ g:NERD_left_align_regexp, &filetype =~ g:NERD_right_align_regexp, 0 ,0, 0)<CR><ESC>'

execute 'nmenu <silent> &Comment.Comment\ To\ EOL<TAB>' . escape(g:NERD_com_to_end_of_line_map, '\') . ' :call <SID>SaveCursorPosition()<cr>:call <SID>CommentBlock(line("."), line("."), col("."), col("$")-1, 1)<cr>:call <SID>RestoreCursorPostion()<cr><ESC>'

execute 'nmenu <silent> &Comment.Comment\ Invert<TAB>' . escape(g:NERD_com_line_invert_map, '\') . ' :call <SID>DoComment(0,0,0,0,0,0,1)<CR>'
execute 'vmenu <silent> &Comment.Comment\ Invert<TAB>' . escape(g:NERD_com_line_invert_map, '\') . ' :call <SID>DoComment(0,1,0,0,0,0,1)<CR>'

execute 'nmenu <silent> &Comment.Comment\ Sexily<TAB>' . escape(g:NERD_com_line_sexy_map, '\') . ' :call <SID>DoComment(0,0,0,0,1,0,0)<CR>'
execute 'vmenu <silent> &Comment.Comment\ Sexily<TAB>' . escape(g:NERD_com_line_sexy_map, '\') . ' :call <SID>DoComment(0,1,0,0,1,0,0)<CR>'

execute 'nmenu <silent> &Comment.Yank\ line(s)\ then\ comment<TAB>' . escape(g:NERD_com_line_yank_map, '\') . ' "0Y' . g:NERD_com_line_map 
execute 'vmenu <silent> &Comment.Yank\ line(s)\ then\ comment<TAB>' . escape(g:NERD_com_line_yank_map, '\') . ' "0ygv' . g:NERD_com_line_map

execute 'nmenu <silent> &Comment.Append\ Comment\ to\ Line<TAB>' . escape(g:NERD_append_com_map, '\') . ' :call <SID>AppendCommentToLine()<cr>'
execute 'nmenu <silent> &Comment.Prepend\ Comment\ to\ Line<TAB>' . escape(g:NERD_prepend_com_map, '\') . ' :call <SID>PrependCommentToLine()<cr>'

execute 'menu <silent> &Comment.-Sep-	:'

execute 'nmenu <silent> &Comment.Comment\ Align\ Left\ (nested)<TAB>' . escape(g:NERD_com_align_left_map, '\') . ' :call <SID>DoComment(1, 0, 1, 0, 0, 0, 0)<CR><ESC>'
execute 'vmenu <silent> &Comment.Comment\ Align\ Left\ (nested)<TAB>' . escape(g:NERD_com_align_left_map, '\') . ' :call <SID>DoComment(1, 1, 1, 0, 0, 0, 0)<CR><ESC>'

execute 'nmenu <silent> &Comment.Comment\ Align\ Right\ (nested)<TAB>' . escape(g:NERD_com_align_right_map, '\') . ' :call <SID>DoComment(1, 0, 0, 1, 0, 0, 0)<CR><ESC>'
execute 'vmenu <silent> &Comment.Comment\ Align\ Right\ (nested)<TAB>' . escape(g:NERD_com_align_right_map, '\') . ' :call <SID>DoComment(1, 1, 0, 1, 0, 0, 0)<CR><ESC>'

execute 'nmenu <silent> &Comment.Comment\ Align\ Both\ (nested)<TAB>' . escape(g:NERD_com_align_both_map, '\') . ' :call <SID>DoComment(1, 0, 1, 1, 0, 0, 0)<CR><ESC>'
execute 'vmenu <silent> &Comment.Comment\ Align\ Both\ (nested)<TAB>' . escape(g:NERD_com_align_both_map, '\') . ' :call <SID>DoComment(1, 1, 1, 1, 0, 0, 0)<CR><ESC>'

execute 'menu <silent> &Comment.-Sep2-	:'

execute 'menu <silent> &Comment.Uncomment<TAB>' . escape(g:NERD_uncom_line_map, '\') . ' :call <SID>UncommentLines(0)<CR>gv'

execute 'menu <silent> &Comment.-Sep3-	:'

execute 'nmenu <silent> &Comment.Use\ Alternative\ Delimiters<TAB>' . escape(g:NERD_alt_com_map, '\') . ' :call <SID>SwitchToAlternativeDelimiters(1)<CR>'


execute 'imenu <silent> &Comment.Insert\ Delims<TAB>' . escape(g:NERD_com_in_insert_map, '\') . ' <SPACE><BS><ESC>:call <SID>PlaceDelimitersAndInsBetween()<CR>'

execute 'menu &Comment.-Sep4-	:'

menu <silent> &Comment.Help<TAB>:help\ NERD_comments-contents :help NERD_comments-contents<CR>

" Section: Doc installation call {{{1
"Don't do your installation of the documentation.  I will put it where I want it thanks - tsnyder 06-Nov-05
"silent call s:InstallDocumentation(expand('<sfile>:p'), s:NERD_comments_version)

finish
"=============================================================================
" copied help file into doc/NERD_comments.txt
" Section: The help file {{{1 
" Title {{{2
" ============================================================================
=== START_DOC
*NERD_comments.txt*                                                  #version#


                        NERD_COMMENTS REFERENCE MANUAL~





==============================================================================
CONTENTS {{{2                                         *NERD_comments-contents* 

    1.Intro...................................|NERD_comments|
    2.Functionality provided..................|NERD_com-functionality|
        2.1 Functionality Summary.............|NERD_com-functionality-summary|
        2.2 Functionality Details.............|NERD_com-functionality-details|
            2.2.1 Comment map.................|NERD_com-comment|
            2.2.2 Nested comment map..........|NERD_com-nested-comment|
            2.2.3 Toggle comment map..........|NERD_com-toggle-comment| 
            2.2.4 Invert comment map..........|NERD_com-invert-comment|
            2.2.5 Sexy comment map............|NERD_com-sexy-comment|
            2.2.6 Yank comment map............|NERD_com-yank-comment|
            2.2.7 Comment to EOL map..........|NERD_com-EOL-comment|
            2.2.8 Append com to line map......|NERD_com-append-comment|
            2.2.9 Prepend com to line map.....|NERD_com-prepend-comment|
            2.2.10 Insert comment map.........|NERD_com-insert-comment|
            2.2.11 Use alternate delims map...|NERD_com-alt-delim|
            2.2.12 Comment aligned maps.......|NERD_com-aligned-comment|
            2.2.13 Uncomment line map.........|NERD_com-uncomment-line|
        2.3 Supported filetypes...............|NERD_com-filetypes|
        2.4 Sexy Comments.....................|NERD_com_sexy_comments|
    3.Customisation...........................|NERD_com-customisation|
        3.1 Customisation summary.............|NERD_com-cust-summary|
        3.2 Customisation details.............|NERD_com-cust-details|
        3.3 Default delimiter customisation...|NERD_com-cust-delims|
        3.4 Key mapping customisation.........|NERD_com-cust-keys|
        3.5 Sample regular expressions........|NERD_com-reg-exps|
    4.Issues with the script..................|NERD_com-issues|
        4.1 Delimiter detection heuristics....|NERD_com-heuristics|
        4.2 Nesting issues....................|NERD_com-nesting|
    5.TODO list...............................|NERD_com-todo|
    6.Credits.................................|NERD_com-credits|

==============================================================================
1. Intro {{{2                                                  *NERD_comments*

NERD_comments provides a set of handy key mappings for commenting code. These
mappings are consistent across all supported filetypes. 

When writing NERD_comments I have tried to give it as many features/options as
possible while keeping it so that the plugin can still be used with little or
no knowledge of these. The average user need only know about a few key
mappings to use NERD_comments while there are plenty of other features for the
l33t nerd take advantage of.

Enjoy :D

==============================================================================
2. Functionality provided {{{2                        *NERD_com-functionality*

------------------------------------------------------------------------------
2.1 Functionality summary {{{3                *NERD_com-functionality-summary*

The following key mappings are provided by default (there is also a menu
provided that contains menu items corresponding to all the below mappings):

Note: <leader> is a user defined key that is used to start keymappings and 
defaults to \. Check out |<leader>| for details.

Most of the following mappings are for normal/visual mode only. The
|NERD_com-insert-comment| mapping is for insert mode only.

<leader>cc |NERD_com-comment-map| 
Comments out the current line or text selected in visual mode.


<leader>cn |NERD_com-nested-comment| 
Same as |NERD_com-comment-map| but enforces nesting.


<leader>c<space> |NERD_com-toggle-comment| 
Toggles the comment state of the selected line(s). If the topmost selected
line is commented, all selected lines are uncommented and vice versa.


<leader>ci |NERD_com-invert-comment| 
Toggles the comment state of the selected line(s) individually. Each selected
line that is commented is uncommented and vice versa.


<leader>cs |NERD_com-sexy-comment| 
Comments out the selected lines ``sexually''


<leader>cy |NERD_com-yank-comment|
Same as |NERD_com-comment-map| except that the commented line(s) are yanked
before commenting.


<leader>c$ |NERD_com-EOL-comment| 
Comments the current line from the cursor to the end of line.


<leader>cA |NERD_com-append-comment| 
Adds comment delimiters to the end of line and goes into insert mode between
them.


<leader>cI |NERD_com-prepend-comment| 
Adds comment delimiters to the start of line and goes into insert mode between
them.


<C-c> |NERD_com-insert-comment| 
Adds comment delimiters at the current cursor position and inserts between.


<leader>ca |NERD_com-alt-delim| 
Switches to the alternative set of delimiters.


<leader>cl OR <leader>cr OR <leader>cb |NERD_com-aligned-comment| 
Same as |NERD_com-comment| except that the delimiters are aligned down the
left side (<leader>cl), the right side (<leader>cr) or both sides
(<leader>cb).


<leader>cu |NERD_com-uncomment-line| 
Uncomments the selected line(s).

------------------------------------------------------------------------------
2.2 Functionality details {{{3                *NERD_com-functionality-details*

------------------------------------------------------------------------------
2.2.1 Comment map                                         *NERD_com-comment*
<leader>cc
Comments out the current line. If multiple lines are selected in visual-line
mode, they are all commented out.  If some text is selected in visual or
visual-block mode then NERD_comments will try to comment out the exact text
that is selected using multi-part delimiters if they are available.

Works in normal, visual, visual-line and visual-block mode.  

Change the mapping with: |NERD_com_line_map|. 

Relevant options:
|NERD_allow_any_visual_delims_regexp|
|NERD_comment_whole_lines_in_v_mode|
|NERD_block_com_after_right|
|NERD_left_align_regexp|
|NERD_place_holder_regexp|
|NERD_right_align_regexp|
|NERD_space_delim_filetype_regexp|
|NERD_use_nested_comments_default|
|NERD_use_sexy_coms_default_regexp|
|NERD_use_toggle_coms_default|

------------------------------------------------------------------------------
2.2.2 Nested comment map                           *NERD_com-nested-comment*
<leader>cn
Performs nested commenting.  Works the same as <leader>cc except that if a
line is already commented then it will be commented again. 

If the filetype is covered by the |NERD_place_holder_regexp| option
then the previous comment delimiters will be replaced by place-holder
delimiters if needed.  Otherwise the nested comment will only be added if the
current commenting delimiters have no right delimiter (to avoid compiler
errors) 

Works in normal, visual, visual-line, visual-block modes.

Change the mapping with: |NERD_com_line_nest_map|.

Relevant options:
|NERD_allow_any_visual_delims_regexp|
|NERD_comment_whole_lines_in_v_mode|
|NERD_block_com_after_right|
|NERD_left_align_regexp|
|NERD_place_holder_regexp|
|NERD_right_align_regexp|
|NERD_space_delim_filetype_regexp|
|NERD_use_nested_comments_default|


------------------------------------------------------------------------------
2.2.3 Toggle comment map                           *NERD_com-toggle-comment* 
<leader>c<space> 
Toggles commenting of the lines selected. The behaviour of this mapping
depends on whether the first line selected is commented or not.  If so, all
selected lines are uncommented and vice versa. 

With this mapping, lines are only considered to be commented if a left comment
delimiter is the first non-space/tab char on the line. 

Works in normal, visual-line, modes.
Using this mapping in visual or visual-block modes will cause it to work like
|NERD_com-comment|

Change the mapping with: |NERD_com_line_toggle_map|.

Relevant options:
|NERD_left_align_regexp|
|NERD_right_align_regexp|
|NERD_space_delim_filetype_regexp|
|NERD_use_nested_comments_default|


------------------------------------------------------------------------------
2.2.4 Invert comment map                           *NERD_com-invert-comment*
<leader>ci 
Inverts the commented state of each selected line. If the a selected line is
commented then it is uncommented and vice versa. Each line is examined and
commented/uncommented individually. 

With this mapping, lines are only considered to be commented if a left comment
delimiter is the first non-space/tab char on the line. 

Works in normal, visual-line, modes.

Change the mapping with: |NERD_com_line_invert_map|.

Relevant options:


------------------------------------------------------------------------------
2.2.5 Sexy comment map                               *NERD_com-sexy-comment*
<leader>cs  
Comments the selected line(s) ``sexily''... see |NERD_com_sexy_commenting| for
a description of what sexy comments are. Can only be done on filetypes for
which there is at least one set of multipart comment delimiters specified. 

Sexy comments cannot be nested and lines inside a sexy comment cannot be
commented again.

Works in normal, visual-line.

Change the mapping with: |NERD_com_line_sexy_map|

Relevant options:
|NERD_use_compact_sexy_com_regexp|
|NERD_use_sexy_coms_default_regexp|


------------------------------------------------------------------------------
2.2.6 Yank comment map                               *NERD_com-yank-comment*
<leader>cy  
Same as <leader>cc except that it yanks the line(s) that are commented first. 

Works in normal, visual, visual-line, visual-block modes.

Change the mapping with: |NERD_com_line_yank_map|

Relevant options:


------------------------------------------------------------------------------
2.2.7 Comment to EOL map                              *NERD_com-EOL-comment*
<leader>c$ 
Comments the current line from the current cursor position up to the end of
the line. 

Works in normal mode.

Change the mapping with: |NERD_com_to_end_of_line_map| 

Relevant options:


------------------------------------------------------------------------------
2.2.8 Append com to line map                       *NERD_com-append-comment*
<leader>cA      
Appends comment delimiters to the end of the current line and goes
to insert mode between the new delimiters.  

Works in normal mode.

Change the mapping with: |NERD_append_com_map|. 

Relevant options:


------------------------------------------------------------------------------
2.2.9 Prepend com to line map                     *NERD_com-prepend-comment*
<leader>cI
Prepends comment delimiters to the start of the current line and goes to
insert mode between the new delimiters.  

Works in normal mode.

Change the mapping with: |NERD_prepend_com_map|.

Relevant options:


------------------------------------------------------------------------------
2.2.10 Insert comment map                          *NERD_com-insert-comment*
<C-c>
Adds comment delimiters at the current cursor position and inserts
between them. 

Works in insert mode.

Change the mapping with: |NERD_com_in_insert_map|. 

Relevant options:


------------------------------------------------------------------------------
2.2.11 Use alternate delims map                         *NERD_com-alt-delim*
<leader>ca
Changes to the alternative commenting style if one is available. For example,
if the user is editing a c++ file using // comments and they hit <leader>ca
then they will be switched over to /**/ comments.  
keys for this mappings can be overridden with the 

Works in normal mode.

Change the mapping with: |NERD_alt_com_map|

Relevant options:


------------------------------------------------------------------------------
2.2.12 Comment aligned maps                       *NERD_com-aligned-comment*
<leader>cl <leader>cr <leader>cb    
Same as <leader>cc except that the comment delimiters are aligned on the left
side, right side or both sides respectively. These comments are always nested
if the line(s) are already commented. 

Works in normal, visual-line.

Change the mappings with: |NERD_com_align_left_map|, |NERD_com_align_right_map|
and |NERD_com_align_both_map|.

Relevant options:
|NERD_left_align_regexp|
|NERD_right_align_regexp|


------------------------------------------------------------------------------
2.2.13 Uncomment line map                          *NERD_com-uncomment-line*
<leader>cu      
Uncomments the current line. If multiple lines are selected in
visual mode then they are all uncommented.

When uncommenting, if the line contains multiple sets of delimiters then the
``outtermost'' pair of delimiters will be removed.

The script uses a set of heurisics to distinguish ``real'' delimiters from
``fake'' ones when uncommenting. See |NERD_com-issues| for details.

Works in normal, visual, visual-line, visual-block.

Change the mapping with: |NERD_uncom_line_map|.

Relevant options:
|NERD_dont_remove_alt_coms|
|NERD_dont_remove_spaces_regexp|


------------------------------------------------------------------------------
2.3 Supported filetypes                                   *NERD_com-filetypes*

Files that can be commented by this plugin:
abaqus abc acedb ada ahdl amiga aml ampl ant apache apachestyle asm68k asm asm
asn aspvbs atlas automake ave awk basic b bc bdf bib bindzone btm caos catalog
c cfg cg ch cl clean clipper conf config cpp crontab cs csc csp css cterm cupl
cvs dcl def diff dns dosbatch dosini dot dracula dsl dtd dtml dylan ecd eiffel
elf elmfilt erlang eterm expect exports fgl focexec form fortran foxpro fvwm
fx gdb gdmo gnuplot gtkrc haskell hb h help hercules hog html htmlos ia64 icon
idlang idl indent inform inittab ishd iss ist jam java javascript jess jgraph
jproperties jproperties jsp kix kscript lace lex lftp lifelines lilo lisp lite
lotos lout lprolog lscript lss lua lynx m4 make maple masm master matlab mel
mf mib mma model moduala.  modula2 modula3 monk mush muttrc named nasm nastran
natural ncf nqc nsis ocaml omnimark openroad opl ora ox pascal pcap pccts perl
pfmain php phtml pic pike pilrc pine plm plsql po postscr pov povini ppd ppwiz
procmail progress prolog psf ptcap python python radiance ratpoison r rc
readline rebol registry remind rexx robots rpl ruby sa samba sas sather scheme
scilab screen scsh sdl sed sgml sgmldecl sgmllnx sicad simula sinda skill
slang sl slrnrc sm smil smith sml snnsnet snnspat snnsres snobol4 spec specman
spice sql sqlforms sqlj sqr squid st stp strace tads tags tak tasm tcl
terminfo tex texinfo texmf tf tidy tli trasys tsalt tsscl tssgm uc uil vb
verilog vgrindefs vhdl vim virata vrml vsejcl webmacro wget winbatch wml sh
wvdial xdefaults xf86conf xkb xmath xml xmodmap xpm2 xpm xslt yacc z8a

If a language is not in the list of hardcoded supported filetypes then the
&commentstring vim option is used.


------------------------------------------------------------------------------
2.4 Sexy Comments                                     *NERD_com_sexy_comments*
These are comments that use one set of multipart comment delimiters as well as
one other marker symbol. For example: >
    /*
     * This is a c style sexy comment
     * So there!
     */

    /* This is a c style sexy comment
     * So there! 
     * But this one is ``compact'' style */
<
Here the multipart delimiters are /* and */ and the marker is *. NERD_comments
is capable of adding and removing comments of this type.


==============================================================================
3. Customisation {{{2                                 *NERD_com-customisation*

------------------------------------------------------------------------------
3.1 Customisation summary                              *NERD_com-cust-summary*

|loaded_nerd_comments|                Turns off the script.
|NERD_allow_any_visual_delims_regexp| Allows multipart alternative delims to
                                      be used when commenting in 
                                      visual/visual-block mode.
|NERD_block_com_after_right|          Forces right delims to be placed when
                                      doing visual-block comments.
|NERD_comment_whole_lines_in_v_mode|  Changes behaviour of visual comments.
|NERD_dont_remove_alt_coms|           Causes alternative comments not to be
                                      removed when uncommenting.
|NERD_dont_remove_spaces_regexp|      Causes spaces not to be removed when
                                      uncommenting if the filetype doesnt
                                      match |NERD_space_delim_filetype_regexp|
|NERD_create_h_filetype|              Creates a new filetype for .h files.   
|NERD_lPlace|                         Specifies what to use as the left
                                      delimiter placeholder when nesting
                                      comments.
|NERD_rPlace|                         Specifies what to use as the right
                                      delimiter placeholder when nesting
                                      comments.
|NERD_left_align_regexp|              Specifies which filetypes to align left
                                      delimters for.
|NERD_place_holder_regexp|            Specifies which filetypes may use
                                      placeholders when nesting comments.
|NERD_right_align_regexp|             Specifies which filetypes to align right
                                      delimters for.
|NERD_shut_up|                        Stops all output from the script.
|NERD_space_delim_filetype_regexp|    Specifies which filetypes to add spaces
                                      around the delimiters for.
|NERD_use_compact_sexy_com_regexp|    Specifies which filetypes to use compact
                                      sexy comments for.
|NERD_use_nested_comments_default|    Tells the script to use nested comments
                                      by default.
|NERD_use_sexy_coms_default_regexp|   Specifies which filetypes to use sexy
                                      comments for by default.
|NERD_use_toggle_coms_default|        Specifies that toggle comments should be
                                      used by default.


-----------------------------------------------------------------------------
3.3 Customisation details                             *NERD_com-cust-details*

To enable any of the below options you should put the given line in your 
~/.vimrc

                                                       *loaded_nerd_comments*
If this script is driving you insane you can turn it off by setting this
option >
    let loaded_nerd_comments=1
<

-----------------------------------------------------------------------------
                                        *NERD_allow_any_visual_delims_regexp*
This option is set to a regular expression that is used to specify which
filetypes this option should be turned on for. See |NERD_place_holder_regexp|
and |NERD_use_sexy_coms_default_regexp|.  If this covers the current filetype
then, when NERD_comments is doing a visual or visual-block comment (but not a
visual-line comment) it will choose the right delimiters to use for the
comment. This normally means using the current delimiters if they are
multipart or using the alternative delimiters if THEY are multipart and the
current delims are not.  For example if we are editing the following java
code: >
    float foo = 1221;
    float bar = 324;
    System.out.println(foo * bar);
<
If we are using // comments and select the "foo" and "bar" in visual-block
mode, as shown left below (where '|'s are used to represent the visual-block
boundary), and comment it then it will use the alternative delims as shown on
the right: >
    float |foo| = 1221;                   float /*foo*/ = 1221;
    float |bar| = 324;                    float /*bar*/ = 324;
    System.out.println(foo * bar);        System.out.println(foo * bar);
<
By default this option is set to '.*' i.e is turned on for all filetypes.

-----------------------------------------------------------------------------
                                            *NERD_block_com_after_right*
This option affects commenting when it is done in visual-block mode. If this
option is turned on, lines that begin outside the right boundary of the
selection block will be commented. Enable this option with: >
    let NERD_block_com_after_right=1
<
For example, if you are commenting this chunk of c code in visual-block mode
(where the '|'s are used to represent the visual-block boundary) >
    #include <sys/types.h>
    #include <unistd.h>
    #include <stdio.h>
   |int| main(){
   |   | printf("SUCK THIS\n");
   |   | while(1){
   |   |     fork();
   |   | }
   |}  | 
<
If NERD_block_com_after_right=1 then this code will become: >
    #include <sys/types.h>
    #include <unistd.h>
    #include <stdio.h>
    /*int*/ main(){
    /*   */ printf("SUCK THIS\n");
    /*   */ while(1){
    /*   */     fork();
    /*   */ }
    /*}  */ 
<
Otherwise, the code block would become: >
    #include <sys/types.h>
    #include <unistd.h>
    #include <stdio.h>
    /*int*/ main(){
	printf("SUCK THIS\n");
	while(1){
	    fork();
	}
    /*}  */ 
<

-----------------------------------------------------------------------------
                                         *NERD_comment_whole_lines_in_v_mode*
This option can take 2 values. By default NERD_comments tries to comment out
exactly what is selected in visual mode (v). For example if you select and
comment the following c code (using | to represent the visual boundary): >
    in|t foo = 3;
    int bar =| 9;
    int baz = foo + bar;
<
This will result in: >
    in/*t foo = 3;*/
    /*int bar =*/ 9;
    int baz = foo + bar;
<
But some people prefer it if the whole lines are commented like: >
    /*int foo = 3;*/
    /*int bar = 9;*/
    int baz = foo + bar;
<
If you prefer the second option then stick this line in your .vimrc: >
    let NERD_comment_whole_lines_in_v_mode=1
<

If the filetype you are editing only has no multipart delimiters (for example
a shell script) and you hadnt set this option then the above would become >
    in#t foo = 3;
    #int bar = 9;
<
(where # is the comment delimiter) as this is the closest NERD_comments can
come to commenting out exactly what was selected. If you prefer for whole
lines to be commented out when there is no multipart delimiters but the EXACT
text that was selected to be commented out if there IS multipart delimiters
then stick the following line in your .vimrc: >
    let NERD_comment_whole_lines_in_v_mode=2
<

Note that this option does not affect the behaviour of visual-block mode ().

-----------------------------------------------------------------------------
                                                   *NERD_dont_remove_alt_coms*
When uncommenting a line when there is an alternative commenting style for the
current filetype, this option tells the script not to look for, and remove,
comments delimiters of the alternative style. >
    let NERD_dont_remove_alt_coms=1
<
For example, if you are editing a c++ file using // style comments and you go
<leader>cu on this line: >
    /* This is a c++ comment baby! */
<
It will not be uncommented if the NERD_dont_remove_alt_coms is set to 1.

-----------------------------------------------------------------------------
                                             *NERD_dont_remove_spaces_regexp*
By default, the NERD commenter will remove spaces around comment delimiters if
either:
1. The current filetype matches the |NERD_space_delim_filetype_regexp| option
   (which is a regular expression).
2. The current filtype doesnt match NERD_dont_remove_spaces_regexp option
   (which is also a reg exp)

This means that if we have the following lines in a c code file: >
    /* int foo = 5; */
    /* int bar = 10; */
    int baz = foo + bar
<
If either of the above conditions hold then if these lines are uncommented
they will become: >
    int foo = 5;
    int bar = 10;
    int baz = foo + bar
<
Otherwise they would become: >
     int foo = 5;
     int bar = 10;
    int baz = foo + bar
<
If you want the spaces to be removed only if the current filetype matches
|NERD_space_delim_filetype_regexp| then set the
NERD_dont_remove_spaces_regexp option in your vimrc so that it matches the
desired filetypes.

See |NERD_com-reg-exps| for example reg exps.

Defaults to "^python$"

-----------------------------------------------------------------------------
                                                      *NERD_create_h_filetype*
If this option is set then NERD_comments will create a seperate filetype for h
files. This could be needed because some versions of vim treat h files as cpp
files which can be dodgy for commenting because if you are using // to comment
cpp files then this is invalid when you are commenting h files for a c
project (unless you arent adhering to the ANSI standard... naughty naughty).
To enable this option, stick the following line in your .vimrc: >
    let NERD_create_h_filetype = 1
<

-----------------------------------------------------------------------------
                                                                 *NERD_lPlace*
								 *NERD_rPlace*
These options are used to control the strings used as place-holder delimiters.
Place holder delimiters are used when performing nested commenting when the
filetype supports commenting styles with both left and right delimiters.
To set these options use lines like: >
    let NERD_lPlace="FOO" 
    let NERD_rPlace="BAR" 
<
Following the above example, if we have line of c code: >
    /* int horse */
<
and we comment it with <leader>cn it will be changed to: >
    /*FOO int horse BAR*/
<
When we uncomment this line it will go back to what it was.
NERD_lPlace defaults to '[>', NERD_rPlace defaults to '<]'.

-----------------------------------------------------------------------------
                                                      *NERD_left_align_regexp*
This option is a regular expression which is used to specify which filetypes
should have their left delimiters aligned when commenting multiple lines. 

For example, consider this chunk of c code: >
    1 int foo = 3;
    2 int bar = 5;
    3 while(foo < 50){
    4	foo = foo + bar;
    5	printf("i am just making up this code\n");
    6	    printf("i have no idea what im writing\n");
    7 }
<
If the NERD_left_align_regexp regexp covers c files then if we select lines
3-7 in visual mode and hit <leader>cc the code will become: >
    1 int foo = 3;
    2 int bar = 5;
    3 /*while(foo < 50){*/
    4 /*  foo = foo + bar;*/
    5 /*  printf("i am just making up this code\n");*/
    6 /*      printf("i have no idea what im writing\n");*/
    7 /*}*/
<
If NERD_left_align_regexp doesnt cover c files then the code will become: >
    1 int foo = 3;
    2 int bar = 5;
    3 /* while(foo < 50){ */
    4	/* foo = foo + bar; */
    5   /* printf("i am just making up this code\n"); */
    6	    /* printf("i have no idea what im writing\n"); */
    7 /* } */
< 
NERD_left_align_regexp defaults to '^$' meaning no filetypes have their left
delims aligned.

See |NERD_com-reg-exps| for example reg exps.

-----------------------------------------------------------------------------
                                                    *NERD_place_holder_regexp*
This option is a regular expression which is used to specify which filetypes
place-holder delimiters should be used for when adding nested comments.

See |NERD_com-reg-exps| for example reg exps.

-----------------------------------------------------------------------------
                                                      *NERD_right_align_regexp*
This option is a regular expression which is used to specify which filetypes
should have their right delimiters aligned when commenting multiple lines. 

For example, consider this chunk of c code: >
    1 int foo = 3;
    2 int bar = 5;
    3 while(foo < 50){
    4	foo = foo + bar;
    5	printf("i am just making up this code\n");
    6	    printf("i have no idea what im writing\n");
    7 }
<
If the NERD_right_align_regexp regexp covers c files then if we select lines
3-7 in visual mode and hit <leader>cc the code will become: >
    1 int foo = 3;
    2 int bar = 5;
    3 /*while(foo < 50){                                 */
    4   /*foo = foo + bar;                               */
    5   /*printf("i am just making up this code\n");     */
    6       /*printf("i have no idea what im writing\n");*/
    7 /*}                                                */
<
If NERD_right_align_regexp doesnt cover c files then the code will become: >
    1 int foo = 3;
    2 int bar = 5;
    3 /* while(foo < 50){ */
    4	/* foo = foo + bar; */
    5   /* printf("i am just making up this code\n"); */
    6	    /* printf("i have no idea what im writing\n"); */
    7 /* } */
<
NERD_right_align_regexp defaults to '^$' meaning no filetypes have their right
delims aligned.

See |NERD_com-reg-exps| for example reg exps.

-----------------------------------------------------------------------------
                                                                *NERD_shut_up*
This option is used to prevent NERD_comments from echoing anything.
Stick this line in your .vimrc: >
    let NERD_shut_up=1
<

-----------------------------------------------------------------------------
                                            *NERD_space_delim_filetype_regexp*
Some people prefer a space after the left delimiter and before the right
delimiter like this: >
    /* int foo=2; */
<
as opposed to this: >
    /*int foo=2;*/
<
This option is a regular expression that is used to specify which filetypes
NERD_comments should use spaces for (as in the first eg above). 
NERD_space_delim_filetype_regexp defaults to '^$'.

See also |NERD_dont_remove_spaces_regexp|.
See |NERD_com-reg-exps| for example reg exps.

-----------------------------------------------------------------------------
                                            *NERD_use_compact_sexy_com_regexp*
Some people may want their sexy comments to be like this: >
    /* Hi There!
     * This is a sexy comment
     * in c */
<
As opposed to like this: >
    /* 
     * Hi There!
     * This is a sexy comment
     * in c 
     */
<
The option NERD_use_compact_sexy_com_regexp is a regular expression. If the
filetype that the user is commenting matches this regular expression then when
they do sexy comments they will look like the first comment above.

-----------------------------------------------------------------------------
                                            *NERD_use_nested_comments_default*
When this option is turned on comments are nested automatically. That is, if
you hit <leader>cc on a line that is already commented, or contains comments,
it will be commented again.  >
    let NERD_use_nested_comments_default=1
<

-----------------------------------------------------------------------------
                                          *NERD_use_sexy_coms_default_regexp*
This option is used to specify which filetypes use sexy commenting by default
when the <leader>cc mapping (or corresponding menu item) is used. The option
is a regular expression. This option will be turned on for any filetypes
matching this expression. 

See |NERD_com-reg-exps| for example reg exps.
-----------------------------------------------------------------------------
                                              *NERD_use_toggle_coms_default*
When this option is enabled the <leader>cc mapping is overriden to perform the
same function as the <leader>c<space> mapping. i.e toggle style comments are
performed by default. Stick the following line in your vimrc to use this
option: >
    let NERD_use_toggle_coms_default=1
<


-----------------------------------------------------------------------------
3.3 Default delimiter customisation                    *NERD_com-cust-delims*
These options are used to tell NERD_comments which delimiters to use for a
given filetype when it first loads up. To set one of these options just stick
the corresponding line in your .vimrc. For example: if i want to use /* */ to
delimit comments in java files instead of // (which is the default) then I
would stick this line in my .vimrc: >
    let NERD_use_c_style_java_comments=1
<

Note that if filetype has two commenting styles, which are both supported, you
can switch between them with <leader>ca. See |NERD_com-alt-delim|. These
options only change which style is used when the script is initialsed.

NERD_use_ada_with_spaces: use --<space> instead of -- for ada files.
NERD_use_c_style_acedb_comments: use /**/ instead of // for acedb files.
NERD_use_c_style_ch_comments: use /**/ instead of // for ch files.
NERD_use_c_style_clean_comments: use /**/ instead of // for clean files.
NERD_use_c_style_clipper_comments: use /**/ instead of // for clipper files.
NERD_use_c_style_cpp_comments: use /**/ instead of // for c++ files.
NERD_use_c_style_cs_comments: use /**/ instead of // for c# files.
NERD_use_c_style_dot_comments: use /**/ instead of // for dot files.
NERD_use_c_style_dylan_comments: use /**/ instead of // for dylan files.
NERD_use_c_style_h_comments: use /**/ instead of // for h files.
NERD_use_c_style_hercules_comments: use /**/ instead of // for hercules files.
NERD_use_c_style_idl_comments: use /**/ instead of // for idl files.
NERD_use_c_style_ishd_comments: use /**/ instead of // for ishd files.
NERD_use_c_style_java_comments: use /**/ instead of // for java files.
NERD_use_c_style_javascript_comments: use /**/ instead of // for javascript files.
NERD_use_c_style_kscript_comments: use /**/ instead of // for kscript files.
NERD_use_c_style_mel_comments: use /**/ instead of // for mel files.
NERD_use_c_style_named_comments: use /**/ instead of // for named files.
NERD_use_c_style_pccts_comments: use /**/ instead of // for pccts files.
NERD_use_c_style_php_comments: use /**/ instead of // for php files.
NERD_use_c_style_pike_comments: use /**/ instead of // for pike files.
NERD_use_c_style_pilrc_comments: use /**/ instead of // for pilrc files.
NERD_use_c_style_plm_comments: use /**/ instead of // for plm files.
NERD_use_c_style_pov_comments: use /**/ instead of // for pov files.
NERD_use_c_style_prolog_comments: use /**/ instead of % for prolog files.
NERD_use_c_style_rc_comments: use /**/ instead of // for rc files.
NERD_use_c_style_tads_comments: use /**/ instead of // for tads files.
NERD_use_c_style_tsalt_comments: use /**/ instead of // for tsalt files.
NERD_use_c_style_uc_comments: use /**/ instead of // for uc files.
NERD_use_c_style_verilog_comments: use /**/ instead of // for verilog files.
NERD_use_dash_dash_simula_comments: use -- instead of % for simula files.
NERD_use_dnl_style_automake_comments: use dnl instead of # for automake files.
NERD_use_long_haskell_comments: use {--} instead of -- for haskell files.
NERD_use_long_lisp_comments: use #||# instead of ; for lisp files.
NERD_use_long_lua_comments: use --[[]] instead of -- for lua files.
NERD_use_paren_star_pascal_comments: use (**) instead of {} for pascal files.
NERD_use_REM_basic_comments: use REM instead of ' for basic files.
NERD_use_single_part_c_comments: use // instead of /* */ for c files.


-----------------------------------------------------------------------------
3.4 Key mapping customisation                            *NERD_com-cust-keys*

These options are used to override the default keys that are used for the
commenting mappings. Their values must be set to strings. As an example: if
you wanted to use the mapping <leader>foo to uncomment lines of code then 
you would place this line in your vimrc >
    let NERD_uncom_line_map="<leader>foo"
<

Check out |NERD_com-functionality| for details about what the following 
mappings do.

				 *NERD_alt_com_map*
To override the <leader>ca mapping, set this option >
    let NERD_alt_com_map="<new mapping>"
<
				 *NERD_append_com_map*
To override the <leader>ce mapping, set this option >
    let NERD_append_com_map="<new mapping>"
<
				 *NERD_com_align_left_map*
To override the <leader>cl mapping, set this option >
    let NERD_com_align_left_map="<new mapping>"
<
				 *NERD_com_align_both_map*
To override the <leader>cb mapping, set this option >
    let NERD_com_align_both_map="<new mapping>"
<
				 *NERD_com_align_right_map*
To override the <leader>cr mapping, set this option >
    let NERD_com_align_right_map="<new mapping>"
<
				 *NERD_com_in_insert_map*
To override the <C-c> mapping, set this option >
    let NERD_com_in_insert_map="<new mapping>"
<
				 *NERD_com_line_invert_map* 
To override the <leader>ci mapping, set this option >
    let NERD_com_line_invert_map="<new mapping>"
<
				 *NERD_com_line_map* 
To override the <leader>cc mapping, set this option >
    let NERD_com_line_map="<new mapping>"
<
				 *NERD_com_line_nest_map*
To override the <leader>cn mapping, set this option >
    let NERD_com_line_nest_map="<new mapping>"
<
				 *NERD_com_line_sexy_map*
To override the <leader>cs mapping, set this option >
    let NERD_com_line_sexy_map="<new mapping>"
<
                                    *NERD_com_line_toggle_map*
To override the <leader>c<space> mapping, set this option >
    let NERD_com_line_toggle_map="<new mapping>"
<
				 *NERD_com_to_end_of_line_map*
To override the <leader>c$ mapping, set this option >
    let NERD_com_to_end_of_line_map="<new mapping>"
<
				 *NERD_com_line_yank_map*
To override the <leader>cy mapping, set this option >
    let NERD_com_line_yank_map="<new mapping>"
<
				 *NERD_uncom_line_map*
To override the <leader>cu mapping, set this option >
    let NERD_uncom_line_map="<new mapping>"
<

------------------------------------------------------------------------------
3.5 Sample regular expressions                             *NERD_com-reg-exps*

Many of the options in the NERD commenter must be set to regular
expressions... regular expressions can be a bit confusing so i have provided
some template ones here that you can start from:

Regexp1: '.*'
Matches any filetype. This is useful for turning an option on for all files.

Regexp2: '^$'
Matches no filetypes. This is useful for turning an option off for all files.

Regexp3: '^\(java\)$'
Matches only the java filetype.

Regexp4: '^\(c\|vim\)$'
Matches only c and vim filetypes.

Regexp5: '^\(c.*\|vim\)$'
Matches filetypes beginning with c (eg c, cpp, cs, etc) as well
as vim files.

Regexp6: '^\(c.*\|java\|tex\)$'
Matches filetypes beginning with c (eg c, cpp, cs, etc) as well as java and
tex filetypes.

Regexp7: '^\(python\)\@!'
Matches anything other than 'python'.

Regexp8: '^c\(s\)\@!$'
Matches 'c' followed by anything accept an 's'.

If anyone knows how to do a regular expression that says:
 ((NOT foo) AND (NOT bar) AND (NOT baz))
i would appreciate it if you emailed me how so i can add it to this list :) 

==============================================================================
4. Issues with the script{{{2                                *NERD_com-issues*


------------------------------------------------------------------------------
4.1 Delimiter detection heuristics                       *NERD_com-heuristics*

Heuristics are used to distinguish the real comment delimiters

Because we have comment mappings that place delimiters in the middle of lines,
removing comment delimiters is a bit tricky. This is because if comment
delimiters appear in a line doesnt mean they really ARE delimiters. For
example, Java uses // comments but the line >
    System.out.println("//");
<
clearly contains no real comment delimiters. 

To distinguish between ``real'' comment delimiters and ``fake'' ones we use a
set of heuristics. For example, one such heuristic states that any comment
delimiter that has an odd number of non-escaped " characters both preceding
and following it on the line is not a comment because it is probably part of a
string. These heuristics, while usually pretty accurate, will not work for all
cases.

------------------------------------------------------------------------------
4.2 Nesting issues                                          *NERD_com-nesting*

If we have some line of code like this: >
    /*int foo */ = /*5 + 9;*/
<
This will not be uncommented legally. The NERD commenter will remove the
"outter most" delimiters so the line will become: >
    int foo */ = /*5 + 9;
<
which almost certainly will not be what you want. Nested sets of comments will
uncomment fine though. Eg: >
    /*int/* foo =*/ 5 + 9;*/
<
will become: >
    int/* foo =*/ 5 + 9;
<
(Note that in the above examples I have deliberately not used place holders
for simplicity)

==============================================================================
5. TODO list {{{2                                              *NERD_com-todo*



==============================================================================
6. Credits {{{2                                             *NERD_com-credits*

Thanks and respect to the following people:

Thanks to Nick Brettell for his many ideas and criticisms. A bloody good
bastard.  
:normal :.-2s/good//

Thanks to Matthew Hawkins for his awesome refactoring!

Thanks to the authors of the vimspell whose documentation installation
function I stole :)

Thanks to Greg Searle for the idea of using place-holders for nested comments.

Thanks to Nguyen for the suggestions and pointing the h file highlighting bug!
Also, thanks for the idea of doing sexy comments as well as his suggestions
relating to it :P 

Thanks to Sam R for pointing out some filetypes that NERD_comments could support!

Cheers to Litchi for the idea of having a mapping that appends a comment to
the current line :)

Thanks to jorge scandaliaris and Shufeng Zheng for telling me about some
problems with commenting in visual mode. Thanks again to Jorge for his
continued suggestions on this matter :)

Thanks to Martin Stubenschrott for pointing out a bug with the <C-c> mapping
:) Ive gotta stop breaking this mapping!

Thanks to Markus Erlmann for pointing out a conflict that this script was
having with the taglist plugin.

Thanks to Brent Rice for alerting me about, and helping me track down, a bug
in the script when the "ignorecase" option in vim was set.

Thanks to Richard Willis for telling me about how line continuation was
causing problems on cygwin. Also, thanks pointing out a bug in the help file
and for suggesting // comments for c (its about time SOMEONE did :P). May ANSI
have mercy on your soul :)

Thanks to Igor Prischepoff for suggesting that i implement "toggle comments".
Also, thanks for his suggested improvements about toggle comments after i
implemented them.

Thanks to harry for telling me that i broke the <leader>cn mapping in 1.53 :)

Thanks to Martin (Krischikim?) for his patch that fixed a bug with the doc
install function and added support for ada comments with spaces as well as
making a couple of other small changes.

Thanks to David Bourgeois for pointing out a bug with when commenting c file
:)... ok i completely  misunderstood what David was talking about and ended up
fixing a completely different bug to what he was talking about :P

Thanks to David Bourgeois for pointing out a bug when changing buffers.


Cheers to myself for being the best looking man on Earth!

=== END_DOC

" vim: set foldmethod=marker :
