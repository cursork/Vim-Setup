" First things first. UTF-8 me up wherever I am.
scriptencoding utf-8
set   encoding=utf-8

" I see no real reason for the default to be 2. 3 allows up to 4 bytes
" (including initial letter) to be shown combined; mirroring UTF-8 more
" closely.
set maxcombine=3

" Use bundle directory for plugins, filetypes, etc.
" Gracefully degrade on systems where this is not installed or that are simply
" too old to handle '#'s (i.e. version 6)
silent! call pathogen#infect()

" These must go before any changes to highlighting
syntax enable
filetype plugin indent on

" Give up syntax highlighting on lines > 5000 chars long (default 3000)
if has('+synmaxcol')
	set synmaxcol=5000
endif

" Allow either light or dark BG
if $COLORSCHEME =~'light' || has('gui_running')
	" Nicotine is excellent
	colorscheme nicotine

	" ...but needs some refinement
	highlight CursorLine ctermbg=lightgrey cterm=none gui=none guibg=#F0F0F0
	highlight ColorColumn guibg=#FCFCC0
	" CursorLine bg overrides Error bg, meaning we have light-on-light which is
	" horrible. Standout seems to have the desired effect: It reverses the
	" colours so red is the background and overrides the cursorline
	highlight Error gui=standout guifg=#FF0000 guibg=#FFFFFF
	highlight LineNr gui=italic guibg=#EEEEBB guifg=#000000
	" SignColumn should be the same as LineNr
	highlight SignColumn guibg=#EEEEBB
	" Slightly nicer Visual mode
	highlight Visual guibg=#CCEEFC
	" nicotine doesn't highlight identifiers by default
	highlight Identifier ctermfg=blue guifg=blue
	" Bold grey for hidden items
	highlight Ignore guifg=#999999 gui=bold
	" Comments are red, DiffText is set to red background... Not a good combo
	highlight DiffText term=reverse cterm=bold ctermbg=12 gui=bold guifg=white guibg=red
else
	" Elflord is nice on a terminal but absolutely vile in gVim
	colorscheme elflord
	highlight Constant    ctermfg=darkred
	highlight CursorLine  cterm=underline
	highlight ColorColumn ctermbg=darkgrey
	highlight SignColumn  ctermbg=black
endif

" Really want ALT to be used for Vim only on Windows. Whether or not the menu
" is displayed. N.B. doesn't stop Alt-F4
set winaltkeys=no

if has('gui_running')
	" Hide decorations by default
	" m = menubar, r = right scrollbar, L = left scrollbar (in vert split),
	" T = toolbar, e = plain Vim tabs
	set guioptions-=m
	set guioptions-=r
	set guioptions-=L
	set guioptions-=T
	set guioptions-=e
	" Use console instead of popup windows for confirmations
	set guioptions+=c

	" Toggle menubar/toolbar/scrollbar with F11
	function! ToggleGvimBits()
		if &go=~#'m'
			set go-=mrTLe
		else
			set go+=mrTLe
		endif
	endfunction
	nnoremap <F11> :call ToggleGvimBits()<CR>
	inoremap <F11> <C-c>:call ToggleGvimBits()<CR>a
	vnoremap <F11> <C-c>:call ToggleGvimBits()<CR>gv

	if has('gui_macvim')
		" Nice and decent Unicode support
		set guifont=Menlo:h11
		" Lion full-screen mode - don't maximise horizontally
		set fuoptions-=maxhorz
	elseif (has('win32') || has('win64'))
		" Consolas is great, but has bad character support. DejaVu Sans Mono is
		" better, so use it when we can.
		" We do this silent-if dance so that zoom.vim works correctly -
		" normally we could simply use comma-separated fonts.
		" TODO push a fix back to zoom.vim
		silent! set guifont=DejaVu\ Sans\ Mono:h8
		if &guifont != 'DejaVu Sans Mono:h8'
			set guifont=Consolas:h8
		endif
		" MingLi is horrid for A-z, but has good character support
		" so use it for double-width characters
		set guifontwide=MingLiU
		" Windows doesn't remember size, so set it manually
		if !exists("s:vimrc_loaded_before")
			set lines=30
			set columns=82
		endif
	else
		" Probably Linux - who knows what we've got font-wise, so just try
		" DejaVu Sans Mono
		silent! set guifont=DejaVu\ Sans\ Mono\ 9
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
set cpoptions+=W
if v:version >= 700
	set cpoptions+=Z
endif

" Persistent undo across edits of the same file
if exists('+undofile')
	set undofile
	if has('unix')
		set undodir=~/.vim/undo,/tmp
	else
		set undodir=$VIM\vimfiles\undo
	endif
endif

" Show undo diff preview below main window and close when reverting
let g:gundo_preview_bottom=1
let g:gundo_close_on_revert=1
let g:gundo_help=0

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

" Cursor line only shows in active window.
if exists('&cursorline') && has('autocmd')
	autocmd BufWinEnter * setlocal cursorline
	autocmd WinEnter    * setlocal cursorline
	autocmd WinLeave    * setlocal nocursorline
endif
" Current directory is wherever this file is.
if exists('+autochdir')
	set autochdir
elseif has('autocmd')
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
" should try to be consistent. N.B. requires autoindent or smartindent on
" rather than indentexpr or cindent (which often isn't true in source code!)
set copyindent
set preserveindent

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

if has("perl")
	perl <<EOF
	use strict;
	use Encode;
	use File::Temp ();
	use IO::Socket::INET;
	use Time::HiRes 'usleep';

	# Use perl to find the current proc.
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
				perl => qr{^\s*sub\s+(\S+).*\{},
				# "function foo {..." and # foo [:=] function (... )...
				javascript => qr{
						(?:^\s*function\s+(\S+)\s*\()|
						(?:(?:\s|^)([A-z]+)\s*[=:]\s*function\s*\()
					}x,
			}->{$ftype};
		if (!defined $expression) {
			VIM::DoCommand "let procName=''";
			return;
		}

		my $proc_name = '';
		LINE: for my $i (reverse(1 .. $line_number)) {
			my $line = $curbuf->Get($i);
			if (my @matches = $line =~ $expression) {
				foreach (@matches) {
					if ($_) {
						$proc_name = ": $_";
						last LINE;
					}
				}
			}
		}
		VIM::DoCommand "let procName='$proc_name'";
	}

	my $file_defs = {
		'perl' => ['pl', <<'PERL'],
use v5.012;
use warnings FATAL => 'all';
use utf8;
use autodie  ':all';

use Data::Dumper;


PERL
		'xml' => ['xml', ""],
		'html' => ['html', <<'HTML'],
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<title></title>
</head>
<body>
	
</body>
</html>
HTML
	};
	sub new_temp_file {
		my ($type) = @_;
		my ($suffix, $content) = @{$file_defs->{$type}};

		my ($fh, $fname) = File::Temp::tempfile(SUFFIX => '.' . $suffix);
		print $fh $content;
		close $fh;

		VIM::DoCommand "edit $fname";
		VIM::DoCommand "normal G";
	}

	sub _apply_to_cur_line {
		my ($func, %opts) = @_;

		my ($line_number) = $main::curwin->Cursor;

		my $cur_line = $main::curbuf->Get($line_number);
		if ($opts{'encode_decode'}) {
			$cur_line = Encode::decode('UTF-8', $cur_line);
		}
		my $new_line = $func->($cur_line);
		if ($opts{'encode_decode'}) {
			$new_line = Encode::encode('UTF-8', $new_line);
		}

		$main::curbuf->Set($line_number, $new_line);
	}

	sub decompose {
		require Unicode::Normalize;
		_apply_to_cur_line(\&Unicode::Normalize::NFD, encode_decode => 1);
	}

	sub compose {
		require Unicode::Normalize;
		_apply_to_cur_line(\&Unicode::Normalize::NFC, encode_decode => 1);
	}

	sub fix_double_encoded_utf8 {
		_apply_to_cur_line(sub {
			my $line = Encode::decode('UTF-8', $_[0]);
			my $new  = '';
			foreach (split qr//, $line) {
				my $ord = sprintf '\x%x', ord($_);
				$new .= eval "\"$ord\"";
			}
			return $new;
		});
	}

	# Send whatever is selected to the socket (I use it to send things to iTerm
	# running a REPL)
	sub send_to_socket {
		my ($start, $end) = @_;
		my $sock = IO::Socket::INET->new(PeerAddr => 'localhost', PeerPort => 10001);
		foreach ($main::curbuf->Get($start .. $end)) {
			$sock->print($_ . "\n");
			# Seen issues blindly pumping data into a REPL (defining things
			# when the dependencies aren't there yet, etc.)
			# So slow it down: 1/100th of a second seems a good compromise
			usleep 10_000;
		}
	}
EOF

	function! NKTPerlFile()
		perl new_temp_file('perl')
	endfunction
	com! -nargs=0 NKTPerlFile call NKTPerlFile()
	function! NKTHTMLFile()
		perl new_temp_file('html')
	endfunction
	com! -nargs=0 NKTHTMLFile call NKTHTMLFile()
	function! NKTXMLFile()
		perl new_temp_file('xml')
	endfunction
	com! -nargs=0 NKTXMLFile call NKTXMLFile()
	function! NKDecompose()
		perl decompose()
	endfunction
	com! -nargs=0 NKDecompose call NKDecompose()
	function! NKCompose()
		perl compose()
	endfunction
	com! -nargs=0 NKCompose call NKCompose()
	function! NKFixDoubleUTF8()
		perl fix_double_encoded_utf8()
	endfunction
	com! -nargs=0 NKFixDoubleUTF8 call NKFixDoubleUTF8()
	function! NKSendToSocket(start, end)
		execute 'perl send_to_socket(' . a:start . ', ' . a:end . ')'
	endfunction
	com! -nargs=0 -range NKSendToSocket call NKSendToSocket(<line1>, <line2>)
	nmap <Leader>ee :NKSendToSocket<CR>:echo 'Sent'<CR>
	vmap <Leader>ee :NKSendToSocket<CR>:echo 'Sent'<CR>
endif
function! NKCurrentProc()
	if has("perl")
		perl current_proc()
		return procName
	else
		return ''
	endif
endfunction

" Use the current perlbrew'ed perl if we can
if has('unix') && has("gui_running") && filereadable($HOME . "/perl5/perlbrew/etc/bashrc")
  let $PATH=system("source " . $HOME . "/perl5/perlbrew/etc/bashrc; echo -n $PATH")
endif

" Perl after file will set this to <Leader>ef (execute file)
function! NKRunPerlInNewWindow()
	" Must write first!
	write
	" Remove the last one, create a new output window and configure it to
	" remove itself as soon as possible, with no warnings.
	silent! bdelete __PerlOutput__
	rightbelow new __PerlOutput__
	setlocal buftype=nofile
	setlocal bufhidden=delete
	setlocal noswapfile
	" Run the last buffer through perl and paste the output at the top, before
	" going back to the above window.
	execute "0r!perl #"
	wincmd k
endfunction

" 'LABEL:' shunting to the left is really not useful in most places. If I end
" up writing any amount of C, then I shall just have to remember to re-indent
" these lines or conditionally turn off this option.
set cinkeys-=:

" I really do often want to be able to write 'delete' in Java code, without it
" being an angry red.
let java_allow_cpp_keywords=1

" When scrolling sideways, move only 1 column at a time and keep 1 character
" of context. Not going to be great on slow terminals...
set sidescroll=1
set sidescrolloff=1
set scrolloff=10     " Keep 10 context lines at top/bottom of screen
set lazyredraw       " Redraw lazily... (e.g. not during macro invocation)
set shortmess=aTItoO " Make Vim less wordy (e.g. [RO] instead of readonly...)
set noconfirm        " Error without asking to save edited buffers when quitting
" Make Vim really really quiet
set noerrorbells     " Quiet for most common errors...
set visualbell       " ...catch odd cases (esc in normal mode) with vbells...
set t_vb=            " ...but stop vbells actually doing anything
" gVim resets t_vb, so set up a hook to activate after the GUI is initialised
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

" HTML with {{templates}} is error-rific, but everything else can and should be
" actively syntax-checked.
if v:version >= 700
	let g:syntastic_mode_map = {}
	let g:syntastic_mode_map['mode'] = 'active'
	let g:syntastic_mode_map['passive_filetypes'] = ['html']
endif

" Status line is filename[RO] [filetype] [git info]: line, column current-proc <gap> char/hex char syntastic-error
set statusline=\ %t%r%m\ %y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}:\ %-4.l,\ %-3.v\ %{NKCurrentProc()}\ %=0x%B\ %{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}
set laststatus=2

" Default history of 20 lines is not so good
set history=10000

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
		set showbreak=↪·
		set listchars+=extends:→
	else
		" Can't get curly right arrow to work in Windows :(
		set showbreak=~\ 
		" ... or find a nice font with arrows
		set listchars+=extends:>
	endif
else
	set listchars=tab:>\ 
	set listchars+=trail:_
	set listchars+=extends:>
	set showbreak=~\ 
endif

" Show above defined list characters
set list

" Gets us line wrapping at any character found in &breakat. End-result is line
" breaks at the word level. Useful when reading/writing large text files in
" Vim.
function! NKLineBreaks()
	if &list
		setlocal nolist
		setlocal linebreak
		setlocal wrap
	else
		setlocal list
		setlocal nolinebreak
	endif
endfunction
com! -nargs=0 NKLineBreaks call NKLineBreaks()

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

" Numberwidth is how much space line numbers take up on the left-hand side.
" Doesn't have an effect until :set number is used (mapped to F10 below).
if exists('&numberwidth')
	set numberwidth=6
endif

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
let g:VCSCommandSplit='vertical'
let g:VCSCommandDisableMappings=1
"
" Clojure Magic - rainbow parens, highlighting :used bits, nailgun evaluation
" of clojure files / help / etc.
" To setup Nailgun for a Clojure Project:
"     $ lein plugin install org.clojars.ibdknox/lein-nailgun 1.1.1
"     $ hg clone https://bitbucket.org/kotarak/vimclojure
"     # get into the client directory and make it
"     $ mv ng ~/.bin/ng  # or equivalent personal bin
"     $ lein nailgun     # to start the server
" For some reason as yet undetermined trying to set the path explicitly with
" g:vimclojure#NailgunClient doesn't work. Neither did lein-tarsier make lein
" nailgunning any easier.
" TODO - Put this information somewhere handier!!!
if v:version >= 700
	let g:vimclojure#WantNailgun=0
	let g:vimclojure#DynamicHighlighting=1
	let g:vimclojure#ParenRainbow=1
endif

" Perldoc Path is where the Perldoc plugin will store its generated files.
if has('unix')
	let g:Perldoc_path='/tmp/'
else
	let g:Perldoc_path=$TEMP
endif

" Use ack ( betterthangrep.com ) instead. Filters out hidden files. Also
" don't restrict by filetype (-a) in order to be a bit more grep-like.
if (has('win32') || has('win64'))
	" And Windows doesn't like single quotes...
	set grepprg=ack\ -G\ "^[^\\.]"\ -a
else
	set grepprg=ack\ -G\ '^[^\\.]'\ -a
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
" Hopefully this won't upset me using 'gv' too much
nnoremap gvf :vertical wincmd f<CR>

" Show/hide line numbers or relative numbers.
" No line numbers -> line numbers -> relative line numbers
"       ^---------------------------------------ˇ
function! NKLineNumberSwitch()
	if exists('&relativenumber')
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
	else
		set number!
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
let g:user_zen_leader_key = '\'

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

" Join all paragraphs / selected text
function! NKJoinParagraphs()
	'<,'>s/.\zs\n\ze./ /
endfunction
vnoremap <S-F4> <Esc>:call NKJoinParagraphs()<CR>

" Useful toggles
nnoremap <F5>   :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap <M-F5> :set ignorecase!<CR>:set ignorecase?<CR>
nnoremap <F6>   :set paste!<CR>:set paste?<CR>
nnoremap <M-F6> :setlocal expandtab!<CR>:setlocal expandtab?<CR>
nnoremap <M-F7> :TagbarToggle<CR>
nnoremap <F7>   :NERDTreeTabsToggle<CR>

" Tagbar opens on left, and is much narrower
let g:tagbar_left=1
let g:tagbar_width=25

" NERDTree should not interfere with netrw
" a) I don't have a problem with netrw
" b) NERDTree doesn't know what to do with URLs
let g:NERDTreeHijackNetrw=0

" Show all alphabetic registers
com! -nargs=0 NKNamedRegisters registers abcdefghijklmnopqrstuvwxyz

" Custom Digraphs
" Square and cube superscripts
digraphs ^2 178
digraphs ^3 179
" Unicode completion plugin can show me the digraph for arbitrary characters
let g:showDigraphCode=1

" Some keyboards make it too easy to hit F1 when one means escape
noremap  <F1> <C-[>
vnoremap <F1> <C-[>
lnoremap <F1> <C-[>
cnoremap <F1> <C-[>

" And some keyboard mappings give me a broken pipe!
inoremap ¦ \|

" Show what F-keys do
function! NKKeys()
	echo " F3   - Toggle \"true\" read-only mode  |"
	echo " F4   -                               |                             "
	echo " S-F4 -                               | (Visual) - Join paragraphs"
	echo " F5   - Toggle case-sensitive search  |"
	echo " F6   - Toggle paste                  | M-F6     - Toggle expand tabs"
	echo " F7   - Toggle Tagbar                 | M-F7     - Toggle NERD Tree"
	echo " F8   - (Normal/Insert) Spell-check   | (Visual) - Open selection in new window"
	echo " F9   - Highlight search terms        |"
	echo " F10  - Line numbers                  |"
	echo " F11  - Toggle gVim decorations       |"
	echo " F12  - Most recently used files      |"
endfunction
com! -nargs=0 NKKeys call NKKeys()
nnoremap <F2> :call NKKeys()<CR>

" Set a variable so some things aren't repeated on further sourcing of .vimrc
" e.g. only resize the Window on launch of Vim
let s:vimrc_loaded_before = 1

" Load any machine specific customisations if they exist
runtime machine_specific.vim

" Fin
