set nocompatible      " We're running Vim, not Vi!
"set enc=utf-8         " set encoding to utf-8
filetype on           " Enable fieltype detection
filetype indent off    " Disable filetype-specific indenting (I HATE IT!)
filetype plugin indent off "more no indent magicalness
"filetype plugin on    " Enable filetype-specific plugins

set mouse=v           "disable goofy mousing
"set noswf             "disable swapfile

" change location of .viminfo and swp files
" make the ~/.vim/tmp/ directory manually
set viminfo='20,<50,s10,h,n~/.vim/.viminfo
set dir=~/.vim/tmp//   "set swp dir. trailing slashes avoid collisions
                          "by replacing path with %
"set viminfo=""         "turn off viminfo

" scroll by 3 line at window buffer edge instead of just 1 (shows more context)
set scrolloff=3

"searching related"
set ignorecase        "Ignore case in searches --opposite is: set noic
set noincsearch       "disable incremental word highlight search thing
set nohls             "does not highlight searches
set smartcase         "unless they contain upper-case letters

"indexting related"
set expandtab         "replace tabs with spaces
set ts=4              "tab stop
set softtabstop=4     "use the same value as shiftwidth
set shiftwidth=4      "use 4 spaces when using autoindent/cindent
set smarttab          "smart tabs??
set autoindent        "Autoindentation
set smartindent       "smart indenting is smart
set wrap              "wrap
set ww=<,>,[,]        "allows left at start of line to go to end of prev line 

"display"
"set title             "Put title in title bar
syntax on             "Enable syntax highlighting
set showmatch         "show matching parenthesis,brackets,etc
set showcmd           "show current uncompleted command
set ttyfast           "Smoother changes

"misc"
"set noerrorbells      "no beeps
set visualbell        "visual bell instead of beeping
set nobackup          "no backup copies..
"set nowritebackup     "don't keep a backup file while the file is being edited
set nomodeline        "don't have files trying to override this .vimrc
set nostartofline     "don't jump cursor around, stay in current column
"set backspace=2       " Allow backspace to back over lines
set backspace=indent,eol,start "allow backspace over everything w\insert mode
set shell=bash
"set number           "show line numbers
set ruler             "show file location at the bottom right
set hidden            "current buffer can be backgrounded without having to
                      "write something out. remembers marks and history.

"Set some colors"
set background=dark
colorscheme desert

"highlight LineNr  term=NONE
"hi Normal          ctermfg=black       ctermbg=white
"hi Comment         ctermfg=lightgreen
"hi Function        ctermfg=lightred
"hi Statement       ctermfg=lightblue
"hi Include         ctermfg=lightblue
"hi htmlSpecialChar ctermfg=yellow
"hi Define          ctermfg=lightblue
"hi Constant        ctermfg=magenta
"hi Special         ctermfg=white
"hi Type            ctermfg=lightblue

hi Pmenu            cterm=NONE  ctermfg=lightblue   ctermbg=lightgrey
hi PmenuSel         cterm=BOLD  ctermfg=yellow      ctermbg=darkgrey
hi PmenuSbar        cterm=BOLD  ctermfg=lightblue   ctermbg=lightgrey
hi PmenuThumb       cterm=BOLD  ctermfg=cyan        ctermbg=darkgrey

" function to strip trailing whitespace
function! StripWhitespace()
    normal m`
    %s/\s\+$//e
    normal ``
endfunction

"maps and ignore maps
"dont auto unindent # comments
inoremap # X<BS>#
set pastetoggle=<F11>

"set completeopt=menu

""""""
"""""" FileType support and file detection autocommands 
""""""
"The following removes extra space at ends of lines, for certain file types
"autocmd BufWritePre *.py normal m`:%s/\s\+$//e `` 
"autocmd BufWritePre *.py call StripWhitespace()
" highlight trailing whitespace 
autocmd BufRead,BufNewFile *.py match Error /\s\+$/

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" disable expandtab in makefile
autocmd FileType make set noet

" no clue what this does anymore...but umm... it looks neat. Wild!
set wildchar=<tab>
set wildmenu
set wildmode=longest:full,full

" GPG Stuff
let g:GPGUseAgent = 1

" explore
let g:netrw_altv = 1
let g:netrw_alto = 1

" ramaps
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

if has('gui_running')
    set gfn:Monaco:h11
    set noantialias
    set columns=80
    set lines=30
    set guioptions-=T
    set mouse=a "enable visual mouse mode in gvim/macvim
endif
