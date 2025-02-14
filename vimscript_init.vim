function! CheckNextChar()
    let next_char = strpart(getline('.'), col('.')-1)
    return next_char =~# '[)\]"\x27]'
endfunction

func! ProgrammingSettings() abort
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set encoding=utf-8
    set fileformat=unix
    set number
    set relativenumber
    set foldlevel=0
    set autoindent
	set updatetime=1000
	match BadWhitespace /\s\+$/
    "let g:coq_settings = { 'keymap.pre_select': v:true }
    syntax enable
endfunc

" Vimscript

func! Vimscript() abort
	call ProgrammingSettings()
    set foldmethod=indent
endfunc
au FileType vim call Vimscript()

" Bash

func! Bash() abort
    call ProgrammingSettings()
    "let g:ale_linters = {
                "\'sh': ['language_server'],
                "\ }
endfunc
au FileType sh call Bash()

" C Based

func! C_Folds() abort
	call ProgrammingSettings()
    "inoremap {<CR> <CR>{<CR>}<C-o>O
    inoremap {<CR> {<CR>}<C-o>O
endfunc
au FileType c call C_Folds()
au FileType cc call C_Folds()
au FileType objc call C_Folds()
au FileType objcpp call C_Folds()

" C++

func! CPP() abort
	call C_Folds()

    function! NvimGdbNoTKeymaps()
      tnoremap <silent> <buffer> <esc> <c-\><c-n>
    endfunction

    let g:nvimgdb_config_override = {
      \ 'key_next': 'n',
      \ 'key_step': 's',
      \ 'key_finish': 'f',
      \ 'key_continue': 'c',
      \ 'key_until': 'u',
      \ 'key_breakpoint': 'b',
      \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
      \ }

    let g:ale_fixers = { 'cpp': ['astyle']}
endfunc

au FileType cpp call CPP()
au FileType c++ call CPP()

" C#

func! Csharp() abort
	call C_Folds()
	let g:OmniSharp_popup_options = {
		\ 'winblend': 30,
		\ 'winhl': 'Normal:Normal,FloatBorder:ModeMsg',
		\ 'border': 'rounded'
		\}
    let g:OmniSharp_server_use_mono = 1
	let g:ale_linters = { 'cs': ['OmniSharp'] }

	nnoremap <buffer> <F1> :OmniSharpDocumentation<CR>
	nnoremap <buffer> <F2> :OmniSharpPreviewImplementation<CR>
	nnoremap <buffer> <space> :OmniSharpCodeFormat<CR>
endfunc
au FileType cs call Csharp()

" Gd script

func! GodotSettings() abort
	call ProgrammingSettings()
	setlocal foldmethod=expr
    " set textwidth=79
	nnoremap <buffer> <F4> :GodotRunLast<CR>
	nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    call ale#linter#Define('gdscript', {
    \   'name': 'godot',
    \   'lsp': 'socket',
    \   'address': '127.0.0.1:6005',
    \   'project_root': 'project.godot',
    \})
	nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc

au FileType gdscript call GodotSettings()

" Python *********************************************

func! PythonSettings() abort
    call ProgrammingSettings()
    set foldmethod=indent
    " set textwidth=79
    let g:ale_fixers = { 'python': ['black']}
    let g:ale_linters = { 'python': ['flake8', 'mypy', 'pyflakes', 'pylint', 'pyright']}
	nnoremap <buffer> <space> :ALEFix<CR>
endfunc

autocmd FileType python call PythonSettings()

" CSS HTML JS

au FileType css call ProgrammingSettings()
au FileType html call ProgrammingSettings()
au FileType javascript call ProgrammingSettings()
au FileType json call ProgrammingSettings()
au FileType jsonc call ProgrammingSettings()

" WGSL (WebGPU Shader Language)
au BufNewFile,BufRead *.wgsl set filetype=wgsl
au FileType wgsl call ProgrammingSettings()

" Rust
func! RustSettings() abort
    call C_Folds()
    let g:ale_fixers = { 'rust': ['rustfmt']}
	set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
	nnoremap <buffer> <space> :ALEFix<CR>
    set foldmethod
endfunc
au FileType rust call RustSettings()

" Java
func! JavaSettings() abort
    call C_Folds()
    abbr ptl System.out.println
endfunc
au FileType java call JavaSettings()

" Quail
func! QuailSettings() abort
	call C_Folds()
    abbr int i32
endfunc
au BufNewFile,BufRead *.qui set filetype=quail
au FileType quail call QuailSettings()

" All **************************************************
set spelllang=en_us
set spell
set hlsearch
set incsearch
set wildmenu
set undodir=~/.config/nvim/undo-dir
set undofile
set history=100
set cursorline

"set clipboard=unnamedplus
"set mouse= 

set background=dark
set termguicolors

ino <silent><expr> <C-Y> pumvisible() ? (complete_info().selected == -1 ? "\<C-N><C-Y>" : "\<C-Y>") : "\<C-Y>"

"let g:gruvbox_material_background = 'hard'
"let g:gruvbox_material_better_performance = 1
"colorscheme gruvbox-material

" Input *********************************************

" Bar Bar Keys

" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>

" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Restore buffer
nnoremap <silent>    <A-s-c> <Cmd>BufferRestore<CR>

