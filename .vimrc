" {{{ File Description (Remember, you can use za to toggle folds in vim)
" Filename: .vimrc
" Author: Jordan Schupbach
" Date: 12/13/2017
" Purpose: My .vimrc file. Includes all of the settings
"          I use (mostly from packages) for vim.
" Install: - First install vim-plug plugin by following instructions at:
"            https://github.com/junegunn/vim-plug
"          - Then, run the following command in vim to install the plugins
"            :PlugInstall
"          - Then, install all of the dependencies below
" Dependencies: - Vimplug
"               - TMUX
"               -  Taskwarrior
"               - moving a folder from vim-color-schemes repo:
"                 - look in .vim folder for this repo and copy
"                   colors folder into .vim/colors/
"               - lintr R package for syntax highlighting (follow instructions
"                 on lintr repo
" }}} File Description
" {{{ TODO
" - modify comfy IDE to be useful
" }}} TODO
" {{{ Load Vim-plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" }}} Load Vim-plug
" {{{ Basic Vim Settings
syntax on
filetype plugin indent on
set modeline
set number
set relativenumber
" hi CursorLine guifg=red guibg=blue

set splitbelow
set splitright
set encoding=utf-8

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" " Save with control-s
" nmap <c-s> :w<CR>
" vmap <c-s> <Esc><c-s>gv
" imap <c-s> <Esc><c-s>

" {{{ Save vim folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" }}} Save vim folds

let colorbg = "dark"
" }}} Basic Vim Settings
" {{{ Language specific settings
" python
autocmd BufNewFile,BufRead *.py set keywordprg=pydoc
" }}}
" {{{ User defined functions and  keybindings

" {{{ copy to clipboard with ctrl+c in vm
vnoremap <C-c> "+y
" }}} copy to clipboard with ctrl+c in vm
" {{{ Toggle relative numbers (does this function work to toggle off?)
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
" }}} Toggle relative numbers
" {{{ Highlight lines longer than 80
nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
  if !exists('w:longlinehl')
    let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
  echo "Long lines highlighted"
  else
    call matchdelete(w:longlinehl)
    unl w:longlinehl
    echo "Long lines unhighlighted"
  endif
endfunction
" }}} Highlight lines longer than 80

:command! Rtags :!Rscript -e 'rtags(path="./", recursive=TRUE, ofile="RTAGS")' -e 'library(nvimcom)' -e 'etags2ctags("RTAGS", "rtags")' -e 'unlink("RTAGS")'
set tags+=rtags
set tags+=RTAGS


:command! Rrender :!Rscript -e 'rmarkdown::render("'%'")'
noremap <leader>rj : Rrender <CR>

" # Function to permanently delete views created by 'mkview'
function! MyDeleteView()
    let path = fnamemodify(bufname('%'),':p')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
    if empty($HOME)
    else
        let path = substitute(path, '^'.$HOME, '\~', '')
    endif
    let path = substitute(path, '/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    call delete(path)
    echo "Deleted: ".path
endfunction

" # Command Delview (and it's abbreviation 'delview')
" command Delview call MyDeleteView()


" }}} User defined functions and  keybindingds
" {{{ Plugins I try to use

" {{{ Vim-plug Examples (Maybe delete this?)
" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
"
" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" }}} Vim-plug Examples
" {{{ vim plug functions
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
" }}} vim plug functions
" {{{ Plugins
Plug 'airblade/vim-gitgutter' " Show git info in airline
Plug 'beloglazov/vim-online-thesaurus' " thesaurus from thesaurus.com
Plug 'benmills/vimux' " VimuxRunCommand; VimuxRunLastCommand ; tmux interface
Plug 'blindFS/vim-taskwarrior'
Plug 'drgarcia1986/python-compilers.vim' " python compilers
Plug 'easymotion/vim-easymotion' "<leader> f, s, L, and w easily jump
Plug 'edkolev/promptline.vim' " Can't seem to get working (though vimux works fine)
Plug 'ervandew/supertab' " Use tab to autocomplete
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'flazz/vim-colorschemes', { 'do': 'cp -r ~/.vim/plugged/vim-colorschemes/colors ~/.vim/colors' } " Nice large library of colorschemes
" Plug 'garbas/vim-snipmate' " needed for snippets (saved in .vim/plugged/vim-snippets/snippets)
Plug 'godlygeek/tabular'
Plug 'haya14busa/incsearch.vim' " Highlight all instances of word in inc search
Plug 'honza/vim-snippets' " Save snippets of code for quick
Plug 'jalvesaq/Nvim-R' " Interface with R
Plug 'janKo-m/vim-test' " Testing framework for vim
" Plug 'JCLiang/vim-cscope-utils' " cscope (need to figure out how to use
Plug 'jceb/vim-orgmode' " org mode for vim
Plug 'jeetsukumaran/vim-markology' " Interface with R
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Interface with R
Plug 'junegunn/goyo.vim' " Focus on current vim window
Plug 'junegunn/gv.vim' " A git commit browser
Plug 'junegunn/vim-github-dashboard' " Focus on current vim window
Plug 'jsfaint/gen_tags.vim' " async ctags
Plug 'jpalardy/vim-slime'  " slime (emacs)
Plug 'kana/vim-smartword'  " Smarter word movement (for coding and hrefs)
Plug 'kien/ctrlp.vim' " Do I actually want this?
Plug 'ludovicchabant/vim-gutentags' " tags management
Plug 'majutsushi/tagbar'
Plug 'manasthakur/vim-asyncmake' " Asynchronous commandline
Plug 'maxbrunsfeld/vim-yankstack' " Access old yanks w/ meta p and P
Plug 'mbbill/undotree'  " Visualize undo tree with UndoTreeShow
Plug 'michaeljsmith/vim-indent-object' " indent with <count> ai ii aI iI
Plug 'nathanaelkane/vim-indent-guides' " Indent guides
Plug 'mhinz/vim-startify'
Plug 'nvie/vim-flake8' " Flake8
Plug 'rafaqz/ranger.vim' " use ranger
Plug 'reedes/vim-wordy' " Word suggestions for prose with :Wordy <tab> and :NoWordy
Plug 'reedes/vim-lexical' " Dictionairy and thesaurus
Plug 'reedes/vim-textobj-sentence' " Dictionairy and thesaurus
Plug 'ryanoasis/vim-devicons' " Used for
Plug 'scrooloose/nerdcommenter' "comment with <leader> cc
Plug 'scrooloose/nerdtree' " Nice filebrowser
Plug 'SirVer/ultisnips' " Snippet manater
Plug 'skywind3000/asyncrun.vim' " Asynchronous run cmd
Plug 'szw/vim-tags'
Plug 'terryma/vim-expand-region' " Easily select chunks of code w/ + in nm mode
Plug 'tbabej/taskwiki' " TaskWarrior plus vimwiki
Plug 'tpope/vim-fugitive' " Awesome git plugin (:Gdiff :Gstatus :Gcommit :Git)
Plug 'tpope/vim-dispatch' " Asynchronous jobs
Plug 'tpope/vim-surround' " Tim Popes easy surround with quotes
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }" Completion engine
Plug 'vimwiki/vimwiki', { 'branch': 'dev' } " Vim Wiki project management
Plug 'vim-airline/vim-airline' " Customize vim statusline
Plug 'vim-airline/vim-airline-themes' " Use airline theme
Plug 'vim-scripts/bufexplorer.zip' " Do I actually want this?
" Plug 'vim-scripts/csv.vim' " Do I actually want this? (I usually use libreoffice for someone else's xls)
Plug 'vim-scripts/DeleteTrailingWhitespace' " :DeleteTrailingWhitespace
Plug 'vim-scripts/diffchar.vim' " Highlight exact word differences in vimdiff
Plug 'vim-scripts/pydoc.vim' " Python Documentation
Plug 'vim-scripts/python_fold' " Python folds
Plug 'vim-scripts/taglist.vim' " Open up list of tags for a (project?)
Plug 'vim-scripts/SearchComplete' " tab completion in / search
Plug 'vim-scripts/ZoomWin' " zoom in and out of windows with <c-w>o
Plug 'wellle/tmux-complete.vim' " autocomplete from tmux pane
Plug 'w0rp/ale' " Syntax checking - See lintr package for R
Plug 'yegappan/mru' "Most recently used :MRU

" }}} Plugins

" }}} Plugins I try to use
" {{{ Plugin settings

" {{{ ale
let g:ale_linters = {
      \   'c': ['gcc'],
      \   'cpp': ['gcc'],
      \   'html': ['tidy'],
      \   'lua': ['luacheck'],
      \   'py': ['flake8'],
      \   'r': ['lintr'],
      \   'rmd': ['lintr'],
      \   'rnoweb': ['lintr'],
      \   'rnw': ['lintr'],
      \   'tex': ['chktex'],
      \   'vim': ['vint'],
      \}
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" asyncrun
" let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" }}} ale
" {{{ FZF

if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

nnoremap <C-t> :tabnew<cr>
nnoremap <C-w> :tabclose<cr>
nnoremap <C-<tab>> :tabnext<cr>
nnoremap g1 :1tabn<cr>
nnoremap g2 :2tabn<cr>
nnoremap g3 :3tabn<cr>
nnoremap g4 :4tabn<cr>
nnoremap g5 :5tabn<cr>
nnoremap g6 :6tabn<cr>
nnoremap g7 :7tabn<cr>
nnoremap g8 :8tabn<cr>
nnoremap g9 :9tabn<cr>


inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

" }}}
" {{{ Markdown-composer
" g:markdown_composer_browser='chromium-browser'
" }}} Markdown-composer
" {{{ NERDcommenter (Not sure about these settings)
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" }}} NERDcommenter
" {{{ Nvim-R
let R_in_buffer = 0
let R_term="urxvt"
let R_assign = 2
" let R_rconsole_width = 0
" }}} Nvim-R
" {{{ Ranger.vim
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
map <leader>rR :set operatorfunc=RangerBrowseEdit<cr>g@
map <leader>rT :set operatorfunc=RangerBrowseTab<cr>g@
map <leader>rS :set operatorfunc=RangerBrowseSplit<cr>g@
map <leader>rV :set operatorfunc=RangerBrowseVSplit<cr>g@
" }}} Ranger.vim
" {{{ ropevim (not active)
" let ropevim_vim_completion=1
" }}} ropevim
" {{{ Syntastic and lintr (not active in favor of ale)
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']
let g:syntastic_rmd_checkers = ['lintr']
let g:syntastic_rnw_checkers = ['lintr']
let g:syntastic_rnoweb_checkers = ['lintr']
let g:syntastic_check_on_open = 1
" let g:syntastic_r_lintr_linters = "with_defaults(line_length_linter(120),todo_comment_linter)"
" Include this for undesirable function lintr
" , undesirable_function_linter(fun = default_undesirable_functions)
" }}} Syntastic and lintr
" {{{ tagbar
nmap <F8> :TagbarToggle<CR>
" }}} tagbar
" {{{ vimwiki
let g:vimwiki_folding='list'
" }}} vimwiki
" {{{ vim-airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline#extensions#whitespace#checks = ['trailing']
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

"   if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
"   endif


" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'

" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
"
" " old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'
"
" }}} vim-airline
" {{{ vim-colorscheme
colorscheme onedark  " Need to copy colors folder before works

function! ToggleColorscheme()
  if colorbg == "dark"
    colorscheme 0x7A69_dark
    let colorbg = "light"
  else
    colorscheme onedark
    let colorbg = "dark"
  endif
endfunction

command! ToggleColorscheme call ToggleColorscheme()


" }}} vim-colorscheme
" {{{ vim-easymotion <leader> f, s, L, and w
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" }}} vim-easymotion
" {{{ vim-github-dashboard
" Default configuration for public GitHub
let g:github_dashboard = {
\ 'username': 'jordans1882'
\ }
" }}} vim-github-dashboard
" {{{ vim-slime
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
" }}} vim-slime
" {{{ vim-startify

let g:startify_custom_header          = [
\'                               _______                                                            ',
\' ___.--------._____________,------- ------------_                                                 ',
\' \                           `  -  .  _         /\                                                ',
\'  `.__________                           `  -  |  |                 __,---"-._                    ',
\'              `-----------.______             ,/_/  ________,------/___________`----.___________  ',
\'                                 `-----.____,/      |===========================================/ ',
\'                                       |   :|        >--------------.----------.---------------/  ',
\'                                       /   :|   _,--/          ,--/  \--.__.--/                   ',
\'                                      /   : |--/______________/_                                  ',
\'                                ,---,/    :  \__________________`--.                              ',
\'                               `__________                        |/|                             ',
\'                                          `------._               |\|                             ',
\'                                                    `--._________,-/                              ',
\' Live long and prosper                                                                            ',
\ ]
" }} vim-startify
" {{{ vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

let test#python#runner = 'pytest'
let g:test#preserve_screen = 1


" }}} vim-test
" {{{ Yankstack settings
let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
" }}}
" {{{ Vim Indent Guides
" assuming you want to use snipmate snippet engine
" ActivateAddons vim-snippets snipmate

let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=black ctermbg=black
set ts=2 sw=2 et

" }}} Vim Indent Guides
" {{{ Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}} Ultisnips

" }}} Plugin settings
" {{{ vim-taskwarrior
" default task report type
let g:task_report_name     = 'next'
" custom reports have to be listed explicitly to make them available
let g:task_report_command  = []
" whether the field under the cursor is highlighted
let g:task_highlight_field = 1
" can not make change to task data when set to 1
let g:task_readonly        = 0
" vim built-in term for task undo in gvim
let g:task_gui_term        = 1
" allows user to override task configurations. Seperated by space. Defaults to ''
let g:task_rc_override     = 'rc.defaultwidth=999'
" default fields to ask when adding a new task
let g:task_default_prompt  = ['due', 'description']
" whether the info window is splited vertically
let g:task_info_vsplit     = 0
" info window size
let g:task_info_size       = 15
" info window position
let g:task_info_position   = 'belowright'
" directory to store log files defaults to taskwarrior data.location
let g:task_log_directory   = '~/.task'
" max number of historical entries
let g:task_log_max         = '20'
" forward arrow shown on statusline
let g:task_left_arrow      = ' <<'
" backward arrow ...
let g:task_left_arrow      = '>> '
" }}} vim-taskwarrior





" TODO: Figure our why this has to go after plugin settings
" i.e. which plugin is setting these.. probably color plugin?
set cursorline
hi CursorLine cterm=underline gui=underline ctermbg=238

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgray ctermbg=237

augroup python
    au!
    autocmd FileType python compiler flake8
    autocmd BufWrite *.py :Dispatch
augroup END
" }}}
" {{{ Initialize Vim-plug plugin system (must be at the end)
call plug#end()
" }}} Initialize Vim-plug plugin system
" {{{ Syntax fix functions

" R functions
command! ReplacePlus %s/\s\@<!+\+\s\@!/ \0 /g


" }}} Syntax fix functions
" {{{ AUTOCMD
autocmd BufWritePre * :DeleteTrailingWhitespace
" }}} AUTOCMD
" {{{ toward non-marker style folds
function! MarkdownFolds()
  let l:thisline = getline(v:lnum)
  if match(l:thisline, '^##') >= 0
    return '>2'
    if match(l:thisline, '^#') >= 0
      return '>1'
    else
      return '='
    endif
  endif
endfunction
" }}} toward non-marker style folds
" {{{ vim modelines
" vim: set foldmethod=marker:
" }}} vim modelines
