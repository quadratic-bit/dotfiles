set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set hidden
set inccommand=split
set mouse=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

set expandtab
set shiftwidth=4
set tabstop=4

filetype plugin indent on
syntax on

set t_Co=256
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'elvessousa/sobrio'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'

    " Completion / linters / formatters
    Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}
    Plug 'plasticboy/vim-markdown'
    Plug 'mattn/emmet-vim'

    " Git
    Plug 'airblade/vim-gitgutter'
call plug#end()

colorscheme sobrio

let g:airline_theme = 'sobrio'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:user_emmet_settings = {'typescriptreact' : {'extends' : 'html', 'filters' : 'xml'}}

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

nnoremap <F4> :bd<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <F5> :NERDTreeFocus<CR>
nnoremap <F6> :sp<CR>:terminal<CR>
nnoremap <F7> :tabnew<CR>:terminal<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-Down> :hide<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <C-w> :tabclose<CR>
