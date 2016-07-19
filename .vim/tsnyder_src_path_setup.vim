" Vim Starup Script That will configure 'runtimepath' to use my config directory
" Modeline: vim:fdc=2:fml=1:fdm=marker:fcs=fold\:\ 
" Last Modified: tsnyder 13-Dec-05 13:35 
" Note: If you are totally lost with folding turned on, type 'zi' in Normal mode
"	or do Tools->Folding->Enable/Disable Folding in GUI menus
set runtimepath=$VIMRUNTIME

set runtimepath^=$VIM/vimfiles
set runtimepath+=$VIM/vimfiles/after

set runtimepath^=/home/tsnyder/src/vim
set runtimepath+=/home/tsnyder/src/vim/after

set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after
