" Vim Compiler File
" Compiler:     Perl syntax checks (perl -wc) instead of distributed -W
" Maintainer:   Tim Snyder <Tim.Snyder@amd.com>
" Last Change:  tsnyder 16-Aug-05 18:35 

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

if getline(1) =~# '-[^ ]*T'
	CompilerSet makeprg=perl\ -wTc\ %
else
	CompilerSet makeprg=perl\ -wc\ %
endif

