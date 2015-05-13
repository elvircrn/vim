"let fts = ['c', 'cpp']
"if index(fts, &filetype) == -1

	"maximize window
	if has("win32") || has("win16")
		au GUIEnter * simalt ~x
	endif

	"pathogen
	runtime bundle/vim-pathogen/autoload/pathogen.vim
	execute pathogen#infect()

	"general plugins
	filetype plugin on

	"SCCompile, g++ selected as default compiler
	
	map<F9> :!g++ %:p -std=c++11 <cr>
	"call SingleCompile#ChooseCompiler('cpp', 'g++')
	"map <F9> :SCCompile -std=c++11 <cr>
	"map <F10> :!a <cr>
	"map <F10> :SCCompileRun -std=c++11 <cr>
	
	map <c-F9> :SCCompile -std=c++11 /EHsc <cr>
	map <c-F10> :SCCompileRun -std=c++11 /EHsc <cr>
	
	
	"save propelry mapped
	nmap <c-s> :w<CR>
	imap <c-s> <Esc>:w<CR>

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

	"key maps, switch between buffers
	imap <F2> :bprev<CR>
	imap <F3> :bnext<CR>
	nmap <F2> :bprev<CR>
	nmap <F3> :bnext<CR>

	"color schemes
	syntax enable
	colorscheme skittles_dark

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

	"clang++
	"let g:clang_c_options = '-std=gnu11'
	"let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'

	"syntastic -> syntax checker
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	"optimizations
	let g:syntastic_enable_signs=0

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0

	let g:syntastic_cpp_compiler = 'g++'
	let g:syntastic_cpp_compiler_options = ' -std=c++11 '

"endif










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

