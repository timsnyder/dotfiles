" Vim filetype plugin after file containing Tim Snyder's Perl filetype settings that he doesn't
" think the non-AMD world would care about.
" Language:	Perl
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 19-Feb-09 11:49 
" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\ 

" Insert Code for Psr			{{{2
iabbr Psr  lib qw(/home/tsnyder/src/perl/k7debug);<CR>use Psr;<CR>new Psr(root =>$HASHREF_HERE)->show;<Esc>?HASHREF_HERE<CR>cw
" Insert Code for Data::Dumper			{{{2
iabbr Dumper  Dumper qw(DumperX);<CR>$Data::Dumper::Terse = 1;<CR>$Data::Dumper::Indent = 1;<CR>print DumperX 
