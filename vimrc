" First things first. UTF-8 me up wherever I am.
scriptencoding utf-8
set   encoding=utf-8

" Use bundle directory for plugins, filetypes, etc.
call pathogen#infect()

" These must go before any changes to highlighting
syntax enable
filetype plugin indent on

" Give up syntax highlighting on lines > 5000 chars long (default 3000)
set synmaxcol=5000

" Allow either light or dark BG
if $COLORSCHEME =~'light' || has('gui_running')
	" Nicotine is excellent
	colorscheme nicotine

	" ...but needs some refinement
	highlight CursorLine ctermbg=lightgrey cterm=none gui=none guibg=#F0F0F0
	highlight ColorColumn guibg=#fcfcc0
	highlight LineNr gui=italic guibg=#EEEEBB guifg=#000000
	" Slightly nicer Visual mode
	highlight Visual guibg=#cceefc
	" nicotine doesn't highlight identifiers by default
	highlight Identifier ctermfg=blue guifg=blue
	" Bold grey for hidden items
	highlight Ignore guifg=#999999 gui=bold
else
	" Elflord is nice on a terminal but absolutely vile in gVim
	colorscheme elflord
	highlight Constant ctermfg=darkred
	highlight CursorLine ctermbg=darkgrey cterm=none gui=none guibg=#000075
endif

" Really want ALT to be used for Vim only on Windows. Whether or not the menu
" is displayed. N.B. doesn't stop Alt-F4
set winaltkeys=no

if has('gui_running')
	" Hide decorations by default
	" m = menubar, r = right scrollbar, L = left scrollbar (in vert split),
	" T = toolbar
	set guioptions-=m
	set guioptions-=r
	set guioptions-=T
	set guioptions-=L
	" Use console instead of popup windows
	set guioptions+=c

	" Toggle menubar/toolbar/scrollbar with F11
	function! ToggleGvimBits()
		if &go=~#'m'
			set go-=mrTL
		else
			set go+=mrTL
		endif
	endfunction
	nnoremap <F11> :call ToggleGvimBits()<CR>
	inoremap <F11> <C-c>:call ToggleGvimBits()<CR>a
	vnoremap <F11> <C-c>:call ToggleGvimBits()<CR>gv

	" gvim (MacVim at least) beeps but doesn't work with visual bells, so to
	" make it silent this is here
	set novisualbell

	if has('gui_macvim')
		" Nice and decent Unicode support
		set guifont=Menlo
		" Lion full-screen mode - don't maximise horizontally
		set fuoptions-=maxhorz
	elseif (has('win32') || has('win64'))
		" Consolas is nice, but has bad character support. Courier New has
		" better, but is really not pretty, especially at smaller text sizes
		set guifont=Consolas:h8
		" MingLi is horrid for A-z, but has good character support
		" so use it for double-width characters
		set guifontwide=MingLiU
		" Windows doesn't remember size, so set it manually
		set lines=30
		set columns=82
	endif
endif

" No to vi-compatible. Not necessary, since a .vimrc exists
set nocompatible
" Edit buffers without saving to-be-hidden one. Effect is there is no prompt to
" save when using ':e'. Downside is that it disables a nice GVIM feature: If
" currently editing a file, a drag-and-dropped file splits the windows when
" nohidden is set.
set hidden

" W stops :w! overwriting a readonly file if possible (believe this applies
" only to filesystem read-only - not 'setlocal readonly').
" Z stops the readonly flag being removed if you do do a :w!
set cpoptions+=WZ

" Persistent undo across edits of the same file
if exists('+undofile')
	set undofile
	if has('unix')
		set undodir=~/.vim/undo,/tmp
	else
		set undodir=$VIM\vimfiles\undo
	endif
endif

" Write backup files to another directory - don't pollute current directory
" with rubbish
set backup
set writebackup
if has('unix')
	set backupdir=~/.vim/backup,/tmp
	set directory=~/.vim/backup,/tmp
else
	set backupdir=$VIM\vimfiles\backup
	set directory=$VIM\vimfiles\backup
endif

" Most Recently Used plugin stores recent files separate from command history
if v:version >= 700
	let MRU_Max_Entries        = 1000
	let MRU_Exclude_Files      = "\\Temp\\|/tmp/"
	let MRU_Window_Height      = 5
	let MRU_Use_Current_Window = 0
	let MRU_Auto_Close         = 1
	let MRU_Max_Menu_Entries   = 50
	" Alias :mru to :Mru - can't be a proper command as user-defined commands
	" are expected to start with a capital letter
	nnoremap :mru :Mru
	nnoremap  <F12> :Mru<CR>
	inoremap  <F12> <Esc>:Mru<CR>a
	vnoremap  <F12> <Esc>:Mru<CR>gv
endif

" Search options
set ignorecase
set smartcase
set incsearch
" More often than not I don't want highlighting. But I want it readily
" available nonetheless.
set nohlsearch
nnoremap <F9> :set hlsearch!<CR>:set hlsearch?<CR>
" Trial this: Automatically put me in Perl-like 'very magic' mode for searches
nnoremap / /\v

" Cursor line only shows in active window.
if exists('&cursorline')
	autocmd BufWinEnter * setlocal cursorline
	autocmd WinEnter    * setlocal cursorline
	autocmd WinLeave    * setlocal nocursorline
endif
" Current directory is wherever this file is.
if exists('+autochdir')
	set autochdir
else
	autocmd BufWinEnter  * lcd %:p:h
	autocmd BufWritePost * lcd %:p:h
	autocmd WinEnter     * lcd %:p:h
endif

" Don't understand why anyone uses spaces to indent
set noexpandtab
" ... but we must have a more reasonable tabstop
set tabstop=4
" ... and the shiftwidth to go with it
set shiftwidth=4
" Ignoring the above; if someone is enough of a *&^% to indent with spaces, I
" should try to be consistent. N.B. requires autoindent or smartindent on.
set copyindent

" Can backspace around end of lines, etc
set backspace=indent,eol,start 
" Only allow backspace and space to wrap around lines in normal mode
set whichwrap=b,s

" Default TODO highlighting is too distracting. Just make it red bold text.
" N.B. Must happen after a colorscheme call.
highlight Todo cterm=bold ctermfg=red ctermbg=none gui=bold guifg=red guibg=NONE

" Spell-checking! Should happen in code comments. As it is slightly
" distracting, make it toggle-able on F8. Keys are z= for suggestions, zg to
" add to dictionary and zug to undo an add.
if has('spell')
	highlight SpellBad   ctermfg=none ctermbg=none cterm=underline gui=italic,undercurl guisp=Red
	highlight SpellCap   ctermfg=none ctermbg=none cterm=underline gui=italic,undercurl guisp=Blue
	highlight SpellLocal ctermfg=none ctermbg=none cterm=underline gui=italic
	highlight SpellRare  ctermfg=none ctermbg=none cterm=underline gui=italic,undercurl guisp=Magenta

	" NB overloaded F8 key-mapping below for opening in new buffer as well as
	" spelling...
	set spelllang=en_gb
	set nospell
	nnoremap <F8> :set spell!<CR>:set spell?<CR>
	inoremap <F8> <C-c>:set spell!<CR>:set spell?<CR>a
endif

" Open selection in new buffer (TODO function-ise)
vnoremap <F8> <Esc><CR>:let b:nk_old_a_register=@a<CR>gvy:new<CR>pggdd<C-w>p:let @a=b:nk_old_a_register<CR><C-w>p:let &filetype=input('Filetype? ')<CR>

nnoremap <F11> :syntax sync fromstart<CR>
inoremap <F11> <Esc>:syntax sync fromstart<CR>a

" Use perl to find the current proc.
if has("perl")
	perl <<EOF
	use strict;
	use File::Temp ();

	sub current_proc {
		my $curwin = $main::curwin;
		my $curbuf = $main::curbuf;

		my ($line_number) = $curwin->Cursor;

		# Determine regular expression to use based on extension.
		my $ftype = VIM::Eval('&filetype');
		my $expression = {
				tcl  => qr/^\s*proc\s+(\S+)\s/,
				sql  => qr/^\s*create\s+(?:table|procedure)\s+(\S+)\b/i,
				java => qr{^\s*(?:public|private|protected)\s*(?:static)?\s+\S+\s+(\S+)\s*\(},
				perl => qr{^\s*sub\s+(\S+)\s*\{},
			}->{$ftype};
		if (!defined $expression) {
			VIM::DoCommand "let procName=''";
			return;
		}

		my $proc_name = '';
		for my $i (reverse(1 .. $line_number)) {
			my $line = $curbuf->Get($i);
			if ($line =~ $expression) {
				$proc_name = ": $1";
				last;
			}
		}
		VIM::DoCommand "let procName='$proc_name'";
	}

	sub new_temp_perl_file {
		my ($fh, $fname) = File::Temp::tempfile(SUFFIX => '.pl');
		print $fh "use v5.012;\nuse warnings;\n\n\n";
		close $fh;
		VIM::DoCommand "edit $fname";
		VIM::DoCommand "normal G";
	}
EOF

function! NKTempPerlFile()
	perl new_temp_perl_file()
endfunction
com! -nargs=0 NKTempPerlFile call NKTempPerlFile()
endif
function! NKCurrentProc()
	if has("perl")
		perl current_proc()
		return procName
	endif
endfunction

" 'LABEL:' shunting to the left is really not useful in most places. If I end
" up writing any amount of C, then I shall just have to remember to re-indent
" these lines or conditionally turn off this option.
set cinkeys-=:

" I really do often want to be able to write 'delete' in Java code, without it
" being an angry red.
let java_allow_cpp_keywords=1

set sidescroll=10    " When scrolling sideways, jump 10 columns at a time
set scrolloff=10     " Keep 10 context lines at top/bottom of screen
set noerrorbells     " Quiet
set lazyredraw       " Redraw lazily... (e.g. not during macro invocation)
set shortmess=aTItoO " Make Vim less wordy (e.g. [RO] instead of readonly...)

" Dummy this function if it doesn't exist, as it is used by the status line
if !exists('*SyntasticStatuslineFlag')
	function SyntasticStatuslineFlag()
		return ''
	endfunction
endif
" HTML with {{templates}} is error-rific - don't pro-actively syntax check
let g:syntastic_mode_map = {}
let g:syntastic_mode_map['passive_filetypes'] = ['html']

" Status line is filename[RO] [filetype] : line, column current-proc <gap> char/hex char syntastic-error
set statusline=\ %t%r%m\ %y\ :\ %-4.l,\ %-3.c\ %{NKCurrentProc()}\ %=%b/0x%B\ %{SyntasticStatuslineFlag()}
set laststatus=2

" Default history of 20 lines is not so good
set history=10000

" Allow manual hard wrapping with gq at 79 chars, formatoptions - t stops it
" autowrapping. Colorcolumn adds a nice line to the right hand side.
set textwidth=79
set formatoptions-=t
if exists('+colorcolumn')
	set colorcolumn=+1
endif
" When joining sentence lines with 'J' (lines ending with '.'/'?'/'!'), use one
" space instead of two.
set nojoinspaces

" Don't softwrap by default... But if we do turn it on, we will indicate
" softwraps with a curled arrow or a tilde - done in >=7.2 stuff below.
" - If you want proper *word* wrapping, the following is all required:
"   set wrap; set nolist; set linebreak
set nowrap

" 7.2 can definitely cope with nicer characters, except when running under a
" cmd.exe-like environment (pcterm)
if v:version >= 702 && &term != 'pcterm'
	set listchars=tab:»\ 
	set listchars+=trail:·
	if has('unix') && has('gui_running')
		" So far only Menlo seems to have this - don't have Linux around to
		" test what turns up though - so give it a go
		set showbreak=↪···
		set listchars+=extends:→
	else
		" Can't get curly right arrow to work in Windows :(
		set showbreak=~\ \ \ 
		" ... or find a nice font with arrows
		set listchars+=extends:>
	endif
else
	set listchars=tab:>\ 
	set listchars+=trail:_
	set listchars+=extends:>
	set showbreak=~\ \ \ 
endif

" Show above defined list characters
set list

" Show nice list of ctrl-n-completes
set wildmenu
set wildmode=list:longest

" Autocompletion only completes to longest common substring
if exists('&completeopt')
	set completeopt=longest,menu,preview
endif

" Folding config - no folding to begin with, fold based on indent. Allows
" arbitrary 'za' usage to hide similarly indented blocks.
set foldlevelstart=99
set foldmethod=indent

" Use mouse for normal mode and visual selection. Allow normal terminal
" selection when in insert mode... allows logical selection of big chunks via
" normal visual mode (esp. for splits, etc.) but also allows quick select,
" middle-click combos while actively editing.
set mouse=nv

" Stops SQL filetype plugin remapping left and right in insert mode...
let g:omni_sql_no_default_maps=1
" Default to MySQL filetype
let g:sql_type_default='mysql'
" VCS plugin should default to vertical splits
let VCSCommandSplit='vertical'
" Clojure Rainbow parentheses
let g:vimclojure#ParenRainbow=1

" Use ack ( betterthangrep.com ) instead. Filters out hidden files. Also
" don't restrict by filetype (-a) in order to be a bit more grep-like.
set grepprg=ack\ -G\ '^[^\\.]'\ -a

" Get help files sorted
if has('unix')
	let s:helptagsdir='~/.vim/doc'
else
	" Assume Windows
	let s:helptagsdir='$VIM/vimfiles/doc'
endif
if isdirectory(s:helptagsdir)
	helptags s:helptagsdir
endif

" Too slow...
nnoremap :WQ :wq
nnoremap :Q  :q
nnoremap :W  :w
nnoremap :S  :s
nnoremap :Bd :bd
nnoremap :BD :bd
nnoremap :E  :e
" Tab goes through windows in normal mode
nnoremap <Tab> <C-w><C-w>

" Numberwidth is how much space line numbers take up on the left-hand side.
" Doesn't have an effect until :set number is used (mapped to F10 below).
if exists('&numberwidth')
	set numberwidth=6
endif

" Show/hide line numbers or relative numbers.
" No line numbers -> line numbers -> relative line numbers
"       ^---------------------------------------ˇ
function! NKLineNumberSwitch()
	if &relativenumber
		set norelativenumber
		set number?
	elseif &number
		set relativenumber
		set relativenumber?
	else
		set number
		set number?
	endif
endfunction
nnoremap <F10> :call NKLineNumberSwitch()<CR>
inoremap <F10> <Esc>:call NKLineNumberSwitch()<CR>a
vnoremap <F10> <Esc>:call NKLineNumberSwitch()<CR>gv

" Open new window split in direction of cursor-key pressed
nnoremap <Leader><left>  :leftabove  vnew 
nnoremap <Leader><right> :rightbelow vnew 
nnoremap <Leader><up>    :leftabove  new 
nnoremap <Leader><down>  :rightbelow new 

" Ctrl-X Ctrl-O can be pretty annoying if it's being used a lot
inoremap <C-]> <C-x><C-o>
" Carry out line-by-line undo in insert
inoremap <CR> <C-G>u<CR>
" By default 'Y' yanks the whole line (to be vi-compatible); replace it with
" yank to end of line for consistency with 'D'elete and 'C'hange.
nnoremap Y y$

if (has('win32') || has('win64'))
	" Convenience method for yanking to the system clipboard in Windows Nicer
	" than 'set clipboard=unnamed' as it forces a choice - e.g. deleted lines
	" don't just get sent to the system clipboard
	vnoremap <M-y>   "*y
	nnoremap <M-y>   "*y
	nnoremap <M-S-y> "*y$

	" Override default Windows behaviour of minimizing by spawning a new
	" console. N.B. this can also be useful on systems where Vim isn't
	" backgrounding properly.
	nnoremap <C-z> :sh<CR>
	vnoremap <C-z> <Esc>:sh<CR>
endif

" Plugin-changing stuff...

" Zencoding plug-in's Ctrl-y based commands are a bit unpleasant as they break
" using C-y to scroll the window up.
" N.B. zencoding can be used for more than HTML. Effectively it also gives us
" snippets in other languages... See :help zencoding-define-tags-behavior
let g:user_zen_leader_key = '<C-\>'

" A large file is > 50MB. See LargeFile plugin. Undo with :Unlarge
let g:LargeFile = 50

" XML syntax folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" Syntastic should use signs to show compile errors
let g:syntastic_enable_signs=1

" Document reading mode, provides elinks-like insert/delete scrolling
" N.B. insert / delete are mapped for ALL buffers
nnoremap <Help> <Ins>
function! NKDocumentRead()
	if !exists('b:nk_document_read')
		let b:nk_document_read = 0
	endif

	if b:nk_document_read == 0
		nnoremap <Ins>  <C-y>
		nnoremap <Del>  <C-e>
		setlocal readonly
		setlocal nomodifiable
		let b:nk_document_read = 1
		echo "Readonly Mode, Insert/Delete Mapped"
	else
		unmap <Ins>
		unmap <Del>
		setlocal noreadonly
		setlocal modifiable
		let b:nk_document_read = 0
		echo "Editing Mode, Insert/Delete UNmapped"
	endif
endfunction
nnoremap <F3> :call NKDocumentRead()<CR>

" Reformat line
nnoremap <F4> :execute 'normal gww'<CR>
inoremap <F4> <Esc>:execute 'normal gww'<CR>a
" Reformat paragraph
nnoremap <S-F4> :execute 'normal gwap'<CR>
inoremap <S-F4> <Esc>:execute 'normal gwap'<CR>a
" Reformat selection
vnoremap <F4> gw

" Toggle automatic formatting of text files
function! NKToggleFormatting()
	if &formatoptions=~'t'
		set formatoptions-=t
	else
		set formatoptions+=t
	endif
	echo 'formatoptions =' &formatoptions
endfunction
nnoremap  <M-F4> :call NKToggleFormatting()<CR>
inoremap  <M-F4> <Esc>:call NKToggleFormatting()<CR>a
vnoremap  <M-F4> <Esc>:call NKToggleFormatting()<CR>gv

" Useful toggles
nnoremap <F5>   :set ignorecase!<CR>:set ignorecase?<CR>
nnoremap <F6>   :set paste!<CR>:set paste?<CR>
nnoremap <M-F6> :set expandtab!<CR>:set expandtab?<CR>
nnoremap <F7>   :TagbarToggle<CR>
nnoremap <M-F7> :NERDTreeToggle<CR>

" Tagbar opens on lef
let g:tagbar_left = 1

" Show all alphabetic registers
com! -nargs=0 NKNamedRegisters registers abcdefghijklmnopqrstuvwxyz

" Show what F-keys do
function! NKKeys()
	echo " F3  - Map insert/delete to scroll  |"
	echo " F4  - Format paragraph             | Alt-F4   - Toggle formatting"
	echo " F5  - Toggle case-sensitive search |"
	echo " F6  - Toggle paste                 | Alt-F6   - Toggle expand tabs"
	echo " F7  - Toggle Tagbar                | Alt-F7   - Toggle NERD Tree"
	echo " F8  - (Normal/Insert) Spell-check  | (Visual) - Open selection in new window"
	echo " F9  - Highlight search terms       |"
	echo " F10 - Line numbers                 |"
	echo " F11 - Sync syntax                  |"
	echo " F12 - Most recently used files     |"
endfunction
com! -nargs=0 NKKeys call NKKeys()
nnoremap <F2> :call NKKeys()<CR>

" Fin
