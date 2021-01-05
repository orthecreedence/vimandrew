" no backward compatibility w/ vi
set nocompatible

" fuck all other encoding
set encoding=utf-8

" make viminfo forget the last files edited
set viminfo='0,/0,:0,<0,@0,f0

" make vim act like any mswindows (or ANY) editor...lots of useful stuff, like 
" shift text selection, movement/deletion line wrapping and the like. lots of
" shorcuts to keep you from having to switch from insert to visual/command 
" mode incessantly. honestly, a lot more useful =]
"runtime behave/mswin.vim

" Make sre we only use UNIX newlines (\n). When reading files, the order below
" makes no difference, BUT since unix is first, that newline type will be used
" for all new files.
set fileformats=unix,dos

" Makes vim not overwrite permissions in cygwin files.
set backupcopy=yes

set noundofile

"set timeoutlen=500

" set up a comma leader
let mapleader = ","

" unicode
"if has("multi_byte")
"	if &termencoding == ""
"		let &termencoding = &encoding
"	endif
"	set encoding=utf-8
"	setglobal fileencoding=utf-8 bomb
"	set fileencodings=ucs-bom,utf-8,latin1
"endif

" disable appending newlines at end of file (apparently it's good form to
" leave it in, so let's leave it...)
"set noeol

" backspace can delete prev chars
set bs=2

" init pathogen, includes all the modules under the vimfiles/bundle/
" NOTE: this needs to run *before* the `filetype [indent|plugin] on` stuff
call pathogen#runtime_append_all_bundles()

" indenting based on filetype
" NOTE: this needs to run *after* pathogen loads!
filetype indent on
filetype plugin on

" always show status line
"set laststatus=2

" set file encoding UTF8
"setlocal fileencoding=utf-8

" set up our intelligent indenting
set autoindent		" enable autoindenting
set smartindent		" derr
set shiftwidth=4	" how much indent to do when autoindenting
" use 4-space tabs (still tabs tho, not spaces)
set tabstop=4
" ...but 2 spaces for lisp
autocmd BufNewFile,BufRead *.asd set filetype=lisp
autocmd FileType lisp setlocal expandtab
autocmd FileType lisp setlocal tabstop=2
autocmd FileType lisp setlocal shiftwidth=2
autocmd FileType lisp setlocal softtabstop=2

"autocmd FileType javascript.jsx setlocal expandtab
"autocmd FileType javascript.jsx setlocal tabstop=2
"autocmd FileType javascript.jsx setlocal shiftwidth=2
"autocmd FileType javascript.jsx setlocal softtabstop=2
"let g:jsx_ext_required = 1

autocmd FileType hcl setlocal expandtab
autocmd FileType hcl setlocal tabstop=2
autocmd FileType hcl setlocal shiftwidth=2
autocmd FileType hcl setlocal softtabstop=2
autocmd BufNewFile,BufRead *.nomad set filetype=hcl
autocmd BufNewFile,BufRead *.hcl set filetype=hcl

autocmd BufRead,BufNewFile *.md set ft=markdown
autocmd FileType markdown setlocal expandtab
autocmd FileType liquid setlocal expandtab

autocmd BufRead,BufNewFile *.toml set ft=toml

autocmd BufRead,BufNewFile *.svelte set ft=svelte

autocmd FileType json setlocal expandtab
autocmd FileType json setlocal tabstop=2
autocmd FileType yml setlocal expandtab
autocmd FileType yml setlocal tabstop=2
autocmd FileType yml setlocal shiftwidth=2
autocmd FileType yaml setlocal expandtab
autocmd FileType yaml setlocal tabstop=2
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType ansible setlocal expandtab
autocmd FileType ansible setlocal tabstop=2

augroup pencil
	autocmd!
	autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
	let g:pencil#conceallevel = 0
augroup END

" makes cursor go to beinning of tab in normal mode instead of end of tab
"set list lcs=tab:\ \ 

" don't change cursor column when switching between buffers
set nostartofline

" lol isnt middle-mouse paste annoying? let's disable it.
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" better searching (disregard case unless explicitely given caps)
set incsearch
set ignorecase
set smartcase

" syntax coloring
syntax on
set t_Co=256

" obviously, the only real choice...the universally renowned void colorscheme
"colorscheme void
" psyche. let's do modified jellybean
colorscheme void

" highlight matching brackets/braces/etc, only highlight for 1/10th of a
" second after a mtch is made
set showmatch
set matchtime=1

set nohlsearch

" turn off wordwrap
set nowrap

" how many lines of buffer around cursor when scrolling
set scrolloff=1

" localvimrc
let g:localvimrc_sandbox = 0

" enable code folding, but essentially always open folds and let ME control when to close folds
set foldlevel=999			" all folds automatically open
set foldmethod=syntax
" PHP folding
let php_folding = 3			" fold functions (no classes, no {} blocks)
let g:DisableAutoPHPFolding = 1
map <Leader>f <Esc>:EnableFastPHPFolds<Cr>

" show current command keys in lower right
set sc

" show ruler line, col
set ruler

" disable mouse hide when typing
set nomh

" buffers can be hidden, meaning they don't need an open window for each open
" buffer. 
set hidden

" show line numbers
set nu

" makes focus follow mouse cursor
"set mousefocus

" -----------------------------------------
" --------- general key bindings ----------
" -----------------------------------------
" <Leader>h will turn ON search highlighting. C-c will temporarily disable it
" for a specific search.
nmap <Leader>h :set hls!<CR>
" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>
" allow typing kj quickly to map to Esc 
inoremap kj <Esc>
inoremap <C-c> <Esc>
map ; :
" enable shift+insert and ctrl+v to paste from clipboard
map <S-Insert> <C-R>+
map! <S-Insert> <C-R>+
noremap <S-Insert>	"+P
vnoremap <S-Insert>	"+P
inoremap <S-Insert>	<C-R>+
"map <C-S-v> <C-R>+
"map! <C-S-v> <C-R>+
"noremap <C-S-v>	"+P
"vnoremap <C-S-v>	"+P
"inoremap <C-S-v>	<C-R>+

" allow ctrl+c to copy into clipboard in visual mode
vnoremap <C-S-c>  "+y

" ,y / ,p / ,P copies/pastes to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" toggle between relative and absolute line numbering with <Leader>n
nnoremap <Leader>n :set rnu!<CR>
" save a keystroke when saving
nmap <Leader>w :w<CR>
" make <Leader>x close the current buffer (without closing the window)
nmap <Leader>x <Plug>BufKillBw

nnoremap <Leader>l :set cursorline!<CR>

" -----------------------------------------
" --------- window split bullshit ---------
" -----------------------------------------
set splitright
set splitbelow

" -----------------------------------------
" --------- some shell remappings ---------
" -----------------------------------------

nmap <Leader>u :UndotreeToggle<CR>

" make ctrl+pageup/down control our buffer selection
map <C-PageUp> :tabp <CR>
map <C-PageDown> :tabn <CR>

" Ctrl+backspace deletes previous word
imap <C-BS> <C-W>

" tab/shift+tab on selected text indents
" NOTE: disabled because, like, use visual block mode?
"vmap <Tab> >gv
"vmap <S-Tab> <gv

" make arrow keys work in visual mode - NOTE - disabled because it interferes
" with windows mode
"vnoremap <Left> h
"vnoremap <Right> l
"vnoremap <Up> k
"vnoremap <Down> j

" FUF mappings
"map <F3> :FufDir <CR>
"map <F4> :FufCoverageFile <CR>
"map <Leader>b :FufBuffer <CR>
"let g:fuf_enumeratingLimit = 100

" CtrlP mappings
map <F4> :CtrlP<CR>
map <Leader>o :CtrlP<CR>
map <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_max_height=15
let g:ctrlp_working_path_mode=''
let g:ctrlp_jump_to_buffer=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_match_window_reversed=1
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](tmp|node_modules|bower_components|\.(git|hg|svn))$',
	\ 'file': '\v\.(exe|so|dll|zip)$',
	\ }
if has("win32") || has("win16")
	set wildignore+=*\\tmp\\*.*.zip,*.exe,*\\.git\\*,*\\node_modules\\*,*\\bower_components\\*
else
	set wildignore+=*/tmp/*.*.zip,*.exe,*/.git/*,*/node_modules/*,*/bower_components/*
endif


" F9 toggles NERDTree
map <F9> :NERDTreeToggle <CR>

if has("win32") || has("win16")
	nmap <Leader>sh :ConqueTermSplit c:\cygwin\cygwin.bat<CR>
else
	nmap <Leader>sh :ConqueTermSplit bash<CR>
endif

" -----------------------------------------
" ------------- Plugin config -------------
" -----------------------------------------

let g:BufKillActionWhenBufferDisplayedInAnotherWindow = 'kill'

" ------------ MiniBufExplorer ------------
" F8 toggles MiniBufExplorer
"map <F8> :TMiniBufExplorer <CR>

" switches tabs with single click
let g:miniBufExplUseSingleClick = 1

" number of spaces between tabs
let g:miniBufExplNumSpaces = 1

" show tabs only if there are more than two buffers
let g:miniBufExplorerMoreThanOne=2

" reload MinBufExpl on buffer changes
"autocmd BufRead,BufNew,BufWritePost :call UMiniBufExplorer
" ------------ vim notes ------------------

" init vimnotes
"g:notes_directory = "~/.vimandrew/notes"

" <TAB> behaves like bash, not DOS
set wildmode=longest:full
set wildmenu

" keep swap/backup files from writing
set nobackup
set noswapfile

" ------------ Lisp/slimv shit ------------
let g:swank_log = 0
let g:slimv_leader = '\'
let g:slimv_balloon = 0		" fucking hate the balloons and all they do is crash
let g:slimv_repl_max_len = 200
let g:slimv_force_repl_scroll = 1
let g:slimv_updatetime = 500
let g:slimv_timeout = 3000
let g:paredit_mode = 0
if has('win32')
	let g:slimv_lisp = 'c:/dev/ccl/wx86cl.exe'
	"let g:slimv_lisp = 'd:/lisp/sbcl/sbcl.exe'
else
	let g:slimv_lisp = '/usr/local/ccl/lx86cl64'
endif

" ------------ Lisp/vlime shit ------------
"function! VlimeBuildServerCommandFor_mylisp(vlime_loader, vlime_eval)
	"return ['cl', a:vlime_loader, '-e' a:vlime_eval]
"endfunction
"let g:vlime_cl_impl = 'mylisp'


" ------------ PHP shit -------------
" syntax crap
let php_sql_query = 0
let php_strict_blocks = 0					" set to 0 if editing slows down
let php_htmlInStrings = 0
let php_smart_members = 0					" turn off if highlighting is slow
let php_alt_properties = 0					" requires php_smart_members
let php_highlight_quotes = 1				" count quotes as part of string when highlighting
let php_show_semicolon = 0					" this makes code look weird
" indentation
let PHP_default_indenting = 0				" add a default of one tab after opening <?
let PHP_autoformatcomment = 1				" correct commenting for PHP
let PHP_outdentphpescape = 0				" <? and ?> are indented at the code level
let PHP_vintage_case_default_indent = 0		" case ...: gets an extra indent (if set to 1)

" add PHP syntax checking
"if !exists("autocommands_loaded")
	"let autocommands_loaded = 1
	"autocmd BufRead *.php set makeprg=c:\cygwin\usr\local\bin\phplint.exe\ --no-print-notices\ --no-print-warnings\ %
	"autocmd BufRead *.php set errorformat=%f:%l:\ %m
"endif
"map <F6> :silent lmake<cr>:lwindow <cr>:redraw!<cr>

" ------------c/c++ shit ---------------
let c_no_if0_fold = 1
let c_no_comment_fold = 1
set foldnestmax=1

" ------------ HTML generation -----------
" for :TOhtml
let html_use_css = 1
let use_xhtml = 1

" save window position when switching buffers
"if v:version >= 700
"	au BufLeave * let b:winview = winsaveview()
"	au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
"endif

" ------------ Remote editing -------------
" don't make a bunch of annoying windows and prompts pop up for each remote
" edit
let g:netrw_silent=1

if has("win32") || has("win16")
	let g:netrw_cygwin = 0
	let g:netrw_scp_cmd = "c:\\tools\\putty\\pscp.exe"
endif

" set up GUI-specific config
if has("gui_running")
	" turn off annoying bells when hitting escape too many times n shit
	set noerrorbells visualbell t_vb=
	if has('autocmd')
		autocmd GUIEnter * set visualbell t_vb=
	endif

	" set up a good GUI colorschema
	let g:jellybeans_background_color = "151515"
	autocmd GUIEnter * colorscheme jellymod

	" remove horrible toolbar
	" NOTE: putting this as its own command (without GUIEnter) hangs on
	" startup =[
	autocmd GUIEnter * set guioptions-=T

	if has("win32")
		set guifont=courier_new_cyr:h10
		autocmd GUIEnter * simalt ~X
	else
		"set guifont=Deja\ Vu\ Sans\ Mono\ 11
		set guifont=Roboto\ Mono\ 11
		"set guifont=Hack\ 11
		" how to show the toolbar
		set toolbar=
		set lsp=2

		" Remove menu bar, graphical tabs (text tabs take up less spaceeeee)
		set guioptions-=m
		set guioptions-=e
		nmap <Leader>menu :set guioptions+=m<CR>

		" Remove scroll bars
		set guioptions+=LlRrb
		set guioptions-=LlRrb
		nmap <Leader>scroll :set guioptions+=Lr<CR>

		set lines=999 columns=999
		set toolbar=
	endif

	" highlight current line
	"set cursorline
else
	set mouse=
endif

