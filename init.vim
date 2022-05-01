" plugin section
call plug#begin('~/AppData/Local/nvim/plugged') 
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'mbbill/undotree'
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch':'release'}
  Plug 'w0rp/ale'
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'prettier/vim-prettier'
  Plug 'airblade/vim-gitgutter'
call plug#end()
" everything after this line will be the config section
set number
if (has("termguicolors"))
 set termguicolors
endif
colorscheme palenight 
set undodir=~/.config/nvim/undodir " set undotree file directory
set undofile " set undotree to save to file
" " map show undo tree
nnoremap <leader>u :undotreetoggle<cr>
" make search case insensitive by default
set ignorecase
"update gitgutter more often
set updatetime=100


nnoremap <c-]> <c-w><c-]><c-w>t
" nerdtree
let g:nerdtreeshowhidden = 1 
let g:nerdtreeminimalui = 1 " hide helper
let g:nerdtreeignore = ['^node_modules$'] " ignore node_modules to increase load speed 
let g:nerdtreestatusline = '' " set to empty to use lightline
" " toggle
noremap <silent> <c-b> :nerdtreetoggle<cr>
" " close window if nerdtree is the last one
autocmd bufenter * if (winnr("$") == 1 && exists("b:nerdtree") && b:nerdtree.istabtree()) | q | endif
" " map to open current file in nerdtree and set size
nnoremap <leader>pv :nerdtreefind<bar> :vertical resize 35<cr>

" nerdtree syntax highlight
" " enables folder icon highlighting using exact match
let g:nerdtreehighlightfolders = 1 
" " highlights the folder name
let g:nerdtreehighlightfoldersfullname = 1 
" " color customization
let s:brown = "905532"
let s:aqua =  "3affdb"
let s:blue = "689fb6"
let s:darkblue = "44788e"
let s:purple = "834f79"
let s:lightpurple = "834f79"
let s:red = "ae403f"
let s:beige = "f5c06f"
let s:yellow = "f09f17"
let s:orange = "d4843e"
let s:darkorange = "f16529"
let s:pink = "cb6f6f"
let s:salmon = "ee6e73"
let s:green = "8faa54"
let s:lightgreen = "31b53e"
let s:white = "ffffff"
let s:rspec_red = 'fe405f'
let s:git_orange = 'f54d27'
" " this line is needed to avoid error
let g:nerdtreeextensionhighlightcolor = {} 
" " sets the color of css files to blue
let g:nerdtreeextensionhighlightcolor['css'] = s:blue 
" " this line is needed to avoid error
let g:nerdtreeexactmatchhighlightcolor = {} 
" " sets the color for .gitignore files
let g:nerdtreeexactmatchhighlightcolor['.gitignore'] = s:git_orange 
" " this line is needed to avoid error
let g:nerdtreepatternmatchhighlightcolor = {} 
" " sets the color for files ending with _spec.rb
let g:nerdtreepatternmatchhighlightcolor['.*_spec\.rb$'] = s:rspec_red 
" " sets the color for folders that did not match any rule
let g:webdeviconsdefaultfoldersymbolcolor = s:beige 
" " sets the color for files that did not match any rule
let g:webdeviconsdefaultfilesymbolcolor = s:blue 

" nerdtree git plugin
let g:nerdtreegitstatusindicatormapcustom = {
    \ "modified"  : "✹",
    \ "staged"    : "✚",
    \ "untracked" : "✭",
    \ "renamed"   : "➜",
    \ "unmerged"  : "═",
    \ "deleted"   : "✖",
    \ "dirty"     : "✗",
    \ "clean"     : "✔︎",
    \ 'ignored'   : '☒',
    \ "unknown"   : "?"
    \ }
"file search
nnoremap <c-p> :files<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" ale (asynchronous lint engine)
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
" coc
" " coc extension
let g:coc_user_config = {}
let g:coc_global_extensions = [
      \ 'coc-emmet', 
      \ 'coc-css', 
      \ 'coc-html', 
      \ 'coc-json', 
      \ 'coc-prettier', 
      \ 'coc-tsserver', 
      \ 'coc-snippets', 
      \ 'coc-eslint']
" " to go back to previous state use ctrl+o
nmap <silent><leader>gd <plug>(coc-definition)
nmap <silent><leader>gy <plug>(coc-type-definition)
nmap <silent><leader>gi <plug>(coc-implementation)
nmap <silent><leader>gr <plug>(coc-references)

inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<c-n>" :
      \ <sid>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " " recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" " use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh() 

" " use <cr> to confirm completion, `<c-g>u` means break undo chain at current
" " position. coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <cr>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<c-y>" : "\<c-g>u\<cr>"
else
  inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
endif

" " highlight the symbol and its references when holding the cursor.
autocmd cursorhold * silent call CocActionAsync('highlight')

" " symbol renaming.
nmap <leader>rn <plug>(coc-rename)

" " formatting selected code.
xmap <leader>f  <plug>(coc-format-selected)
nmap <leader>f  <plug>(coc-format-selected

augroup mygroup
  autocmd!
  " " setup formatexpr specified filetype(s).
  autocmd filetype typescript,json setl formatexpr=CocAction('formatselected')
  " " update signature help on jump placeholder.
  autocmd user cocjumpplaceholder call CocActionAsync('showsignaturehelp')
augroup end

" " applying codeaction to the selected region.
" " example: `<leader>aap` for current paragraph
xmap <leader>a  <plug>(coc-codeaction-selected)
nmap <leader>a  <plug>(coc-codeaction-selected)

" " remap keys for applying codeaction to the current buffer.
nmap <leader>ac  <plug>(coc-codeaction)
" " apply autofix to problem on the current line.
nmap <leader>qf  <plug>(coc-fix-current)

" " add `:format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " add `:fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " add `:or` command for organize imports of the current buffer.
command! -nargs=0 Or   :call     CocAction('runcommand', 'editor.action.organizeimport')

" " add (neo)vim's native statusline support.
" " note: please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
function! Gitbranch()
  return system("git rev-parse --abbrev-ref head 2>/dev/null | tr -d '\n'")
endfunction

function! Statuslinegit()
  let l:branchname = Gitbranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#pmenusel#
set statusline+=%{Statuslinegit()}
set statusline+=%#linenr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#cursorcolumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\
