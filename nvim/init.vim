set termguicolors
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does
                            " right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line
                            " just typed
set number                  " add line numbers
set cc=80                   " set an 80 column border for good coding style
set colorcolumn=0           " remove column border color
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set splitright
" set wrap!

call plug#begin()

    Plug 'williamboman/mason.nvim',
    Plug 'williamboman/mason-lspconfig.nvim',
    Plug 'neovim/nvim-lspconfig',
    Plug 'folke/trouble.nvim',
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'folke/tokyonight.nvim',
    Plug 'nvim-lua/plenary.nvim',
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
    Plug 'BurntSushi/ripgrep',
    Plug 'sharkdp/fd',
    Plug 'nvim-telescope/telescope-file-browser.nvim',
    Plug 'nvim-tree/nvim-web-devicons',
    Plug 'ecthelionvi/NeoColumn.nvim',
    Plug 'utilyre/barbecue.nvim',
    Plug 'SmiteshP/nvim-navic',
    Plug 'lewis6991/gitsigns.nvim',
    Plug 'romgrk/barbar.nvim',
    Plug 'nvim-lualine/lualine.nvim',
    Plug 'windwp/nvim-autopairs',
    Plug 'terrortylor/nvim-comment',
    Plug 'mhartington/formatter.nvim',
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'mfussenegger/nvim-dap',
    Plug 'mfussenegger/nvim-dap-python',
    Plug 'klen/nvim-test',
    Plug 'norcalli/nvim-colorizer.lua',
    Plug 'folke/todo-comments.nvim',
    Plug 'rcarriga/nvim-dap-ui',
    Plug 'alexghergh/nvim-tmux-navigation',
    Plug 'kkoomen/vim-doge',

    if has('nvim')
      function! UpdateRemotePlugins(...)
        " Needed to refresh runtime files
        let &rtp=&rtp
        UpdateRemotePlugins
      endfunction
      Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
    else
      Plug 'gelguy/wilder.nvim'
    endif

call plug#end()

lua require('init')

colorscheme tokyonight

" #0c0b17 inactive bg
" #101024 active bg
" #0f0f1f terminal color
:hi BufferTabpageFill guibg=#0b0b17

:hi BufferCurrent guibg=#101024
:hi BufferCurrentMod guibg=#101024
:hi BufferCurrentIndex guibg=#101024
:hi BufferCurrentSign guibg=#0b0b17 guifg=#101024
:hi BufferCurrentSignRight guibg=#0b0b17 guifg=#101024

:hi BufferAlternate guibg=#101024
:hi BufferAlternateSign guifg=#101024 guibg=#0b0b17
:hi BufferAlternateSignRight guifg=#101024 guibg=#0b0b17
:hi BufferAlternateMod guibg=#101024
:hi BufferAlternateIndex guibg=#101024

:hi BufferInactive guibg=#0b0b17
:hi BufferInactiveSign guifg=#0b0b17 guibg=#0b0b17
:hi BufferInactiveSignRight guifg=#0b0b17 guibg=#0b0b17
:hi BufferInactiveMod guibg=#0b0b17

:hi BufferVisible guibg=#0b0b17
:hi BufferVisibleSign guifg=#0b0b17 guibg=#0b0b17
:hi BufferVisibleSignRight guifg=#0b0b17 guibg=#0b0b17
:hi BufferVisibleMod guibg=#0b0b17
