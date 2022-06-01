set nocompatible
set hlsearch
set incsearch

set tabstop=4	   "Tabs take 4 columns
set softtabstop=4  "Multiple spaces seen as tab stops
set expandtab	   "Tabs -> Spaces

set shiftwidth=4   "Auto-ident shift width (languages can override)
set autoindent

set number	"Line numbering

filetype plugin indent on "Let languages override our shift width

syntax on 

set clipboard=unnamedplus "Use system clipboard

set cursorline	"Highlight current line
set noswapfile  "Don't use vim swap files
set nobackup    "Don't use backup files (use git)

if (has("termguicolors"))
	set termguicolors
endif
syntax enable


call plug#begin("~/.vim/plugged")
	Plug 'mhartington/oceanic-next'
call plug#end()

colorscheme OceanicNext

inoremap jj <ESC>
