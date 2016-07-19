" Vim syntax after file
" Language:	Perl POD format
" Maintainer:	Tim Snyder <Tim.Snyder@amd.com>
" Last Change:	tsnyder 22-Sep-05 11:59 


" =headn commands aren't really limited to just 1 or 2, make them get highlighted for any n

" POD commands
syn match podCommand	"^=head\d\+"	nextgroup=podCmdText
