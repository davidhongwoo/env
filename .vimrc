runtime! debian.vim 

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Bundle 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'basic-colors'
Bundle 'vim_colors'
"Bundle 'cscope.vim'
"Bundle 'cscope_plus.vim'
"Bundle 'cscope-wrapper'
Bundle 'autoload_cscope.vim'
"Bundle 'cscope_macros.vim'
Bundle 'vimgdb'
Bundle 'c.vim'
Bundle 'fugitive.vim'
Bundle 'xml.vim'
Bundle 'surround.vim'
Bundle 'matchit.zip'
"Bundle 'clang-complete'
Bundle 'vcscommand.vim'
Bundle 'The-NERD-Commenter'
"Bundle 'aurum'
Bundle 'pythoncomplete'
"Bundle 'Powerline'
Bundle 'Python-mode-klen'
Bundle 'vimpluginloader'
"Bundle 'VimPdb'
"Bundle 'vim-clang'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
filetype on
filetype plugin on 

"set nocp 

set showcmd
set showmatch
set smartcase
set incsearch

"set number
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
"set autoindent
set visualbell
set smartindent
set cindent
set hlsearch
set ruler

set modeline 

"	inoremap <ESC> <ESC>:set imdisable<CR>
"	nnoremap i :set noimd<CR>i
"	nnoremap I :set noimd<CR>I
"	nnoremap a :set noimd<CR>a
"	nnoremap A :set noimd<CR>A
"	nnoremap o :set noimd<CR>o
"	nnoremap O :set noimd<CR>O    

"color molokai 
colorscheme elflord

run macros/gdb_mappings.vim
"set asm=0
"set gdbprg="gdb"

set fencs=utf-8,euc-kr,cp949,cp932,euc-jp,shift-jis,big5,latin1,ucs-2le
"set fencs=cp949,utf-8,euc-kr


if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif 

if version >= 500
func! Sts()
	let st = expand("<cword>")
	exe "sts ".st
endfunc
nmap ,st :call Sts( )<cr> 

func! Tj( )
	let st = expand("<cword>")
	exe "tj ".st
endfunc
nmap ,tj :call Tj( )<cr>
endif

set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb

if filereadable("./cscope.out")
	cs add cscope.out
else 
"	cs add /usr/src/linux-2.4/cscope.out
endif
set csverb 

" find this symbol 
func! Css( )
	let css = expand("<cword>")
	new
	exe "cs find s ".css
	if getline(1) == " " 
		exe "q!"
	endif
endfunc
nmap ,css :call Css( )<cr>

" find functions calling this function
func! Csc( )
	let csc = expand("<cword>")
	new
	exe "cs find c ".csc
	if getline(1) == " " 
		exe "q!"
	endif
endfunc
nmap ,csc :call Csc( )<cr>

" find functions called by this function
func! Csd( )
	let csd = expand("<cword>")
	new
	exe "cs find d ".csd
	if getline(1) == " " 
		exe "q!"
	endif
endfunc
nmap ,csd :call Csd( )<cr>

" find this definition
func! Csg( )
	let csg = expand("<cword>")
	new
	exe "cs find g ".csg
	if getline(1) == " " 
		exe "q!"
	endif
endfunc
nmap ,csg :call Csg( )<cr>

" folding 
nmap ,zf v]}zf	
" unfolding 
nmap ,zo zo 

" xml format 
nmap ,xml :%!xmllint --format %
map @@x !%xmllint --format --recover -
nmap ,xmd :%!xmllint --c14n %

" surround.vim 
vmap ,c <esc>a--><esc>'<i<!--<esc>'>$

" python
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" taglist 
"let Tlist_Ctags_Cmd='/usr/bin/ctags'
"map T :TaskList<CR>
"map P :TlistToggle<CR>

" Find definition of current symbol using Gtags
"map <C-]> <esc>:Gtags <CR>
"map <C-\> <esc>:Gtags -r <CR>

" Find references to current symbol using Gtags
"map <C-F> <esc>:Gtags <CR>

" Go to previous file
"map <C-p> <esc>:bp<CR>
" gtags 
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
"nmap <C-\><C-]> :GtagsCursor<CR>

" VimPDB
autocmd FileType python setlocal ts=4 et sw=4 sts=4 omnifunc=pythoncomplete#Complete  


"nnoremap <silent> <F7> :TlistUpdate<CR>
"nnoremap <silent> <F8> :Tlist<CR>
"nnoremap <silent> <F9> :TlistSync<CR> 

filetype on
filetype indent plugin on

"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

" let Vundle manage Vundle
" required! 
"Bundle 'gmarik/vundle'

" My bundles here:
"
"Bundle 'vcscommand.vim'
"Bundle 'vcslogdiff'
"Bundle 'gtags.vim'
"Bundle 'OmniCppComplete'
"Bundle 'cpp.vim'
"Bundle 'frawor'
"Bundle 'ctrlp.vim'

"filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

map ,diff :VCSVimDiff<CR>
map ,anno :vsp<CR>:VCSAnnotate<CR>
map ,log :vsp<CR>:VCSLog<CR>

let mapleader=","
map cc <leader>c<space>

" last edit position 
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "norm g`\"" |
\ endif

"set asm=0

" Toggling syntax highlighting 
function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off 
    else
        syntax enable
    endif
endfunction
nmap <silent> ;s :call ToggleSyntax()<CR>

" make it simple call make
function! MakeProject()
    make!
endfunction
nmap <silent> ;m :call MakeProject()<CR>

" pymode 
let g:pymode_lint_ignore = "E501,W"
set foldlevelstart=10

" YouCompleteMe Setup {{{
set ttimeoutlen=50 " for faster InsertLeave triggering
set completeopt-=preview " I really don't want preview window for this fork
let g:ycm_confirm_extra_conf = 0
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py" 
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_error_symbol = ">>"
let g:ycm_warning_symbol = "WW"
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,vim,ruby,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
nnoremap <leader>h :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>i :YcmCompleter GoToDefinition<CR>
" " }}}

" -----------------------------------
" powerline
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
"" Always show statusline
"set laststatus=2
"" Use 256 colours (Use this setting only if your terminal supports 256 colours)
"set t_Co=256
" -----------------------------------

"set mouse=a

" Escape/unescape & < > HTML entities in range (default current line).
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0  " must convert &amp; last
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&amp;/&/eg'
  else              " must convert & first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/>/&gt;/eg'
  endif
  nohl
  let @/ = search
endfunction
command! -range -nargs=1 XmlEscape call HtmlEntities(<line1>, <line2>, <args>)
" xml escape : select => back slash + e
" xml unescape : select => back slash + h
noremap <silent> \h :XmlEscape 0<CR>
noremap <silent> \e :XmlEscape 1<CR>

"let g:ConqueTerm_FastMode = 1
"let g:ConqueGdb_Disable = 1
