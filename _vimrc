set hidden

"maximize window
if has("win32") || has("win16")
	au GUIEnter * simalt ~x
endif

"pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"general plugins
filetype plugin on
"Undo properly mapped

nmap <c-z> :undo<CR>
imap <c-z> <Esc>:undo<CR>

"EDIT settings
set exrc
set secure
set tabstop=4	
set softtabstop=4
set shiftwidth=4
set noexpandtab
highlight ColorColumn ctermbg=darkgray

"switch between split windows easily
imap <silent> <A-Up> :wincmd k<CR>
imap <silent> <A-Down> :wincmd j<CR>
imap <silent> <A-Left> :wincmd h<CR>
imap <silent> <A-Right> :wincmd l<CR>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

"something
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"buffer manipulation

nmap <C-w> :Bclose<CR>
imap <F2> :bprev<CR>
imap <F3> :bnext<CR>
nmap <F2> :bprev<CR>
nmap <F3> :bnext<CR>

nmap <c-w> :bd<CR>
nmap <c-w> :bd<CR>

"color schemes
syntax enable

"fonts
set guifont=droid_sans_mono:h10

"hide gvim toolbar
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

"highlight searched string
set hlsearch

"unhighlight searched string
nnoremap <silent> <C-l> :nohl<CR><C-l>

"vim airline -> an integrateable status bar
set laststatus=2

"line numbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

filetype detect
if &ft == 'cpp' || &ft == 'c'
	"colorscheme skittles_dark
	colorscheme molokai
	
	"compile
	map <F10> <cr> :!mingw32-gcc.exe -pedantic-errors -pedantic -Wall -O1 -Wall -Wuninitialized -Winit-self -Wno-unused-result -Wfloat-equal -Wno-sign-compare -Werror=implicit-function-declaration -Werror=vla -pedantic -lm -pass-exit-codes  -c "%:p" -o "%:p:r.o" & mingw32-g++.exe  -o "%:p:r.exe" "%:p:r.o" <cr>
	
	"compile and run
	map <F9> <cr> :Start mingw32-gcc.exe -pedantic-errors -pedantic -Wall -O1 -Wall -Wuninitialized -Winit-self -Wno-unused-result -Wfloat-equal -Wno-sign-compare -Werror=implicit-function-declaration -Werror=vla -pedantic -lm -pass-exit-codes  -c "%:p" -o "%:p:r.o" & mingw32-g++.exe  -o "%:p:r.exe" "%:p:r.o" & "%:p:r.exe" <cr>

	"""noremap <F10> <cr> :!mingw32-g++.exe  -o "%:p:r.exe" "%:p:r.o" <cr>
	
	set statusline+=%#warningmsg#
	set statusline+=%*

elseif &ft == 'python'
	colorscheme molokai
else
	colorscheme wir_black
endif

"something
set diffexpr=MyDiff()

function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

