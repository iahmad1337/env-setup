" Enable Mouse
set mouse=a

let s:size=12

function! s:IncFont()
    let s:size = s:size + 2
    call GuiFont('Fira Code:h' . s:size)
endfunction

function! s:DecFont()
    let s:size = s:size - 2
    call GuiFont('Fira Code:h' . s:size)
endfunction

noremap <c--> :call <SID>DecFont()<CR>
noremap <c-=> :call <SID>IncFont()<CR>

if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Fira Code:h12
endif


" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

"this is beautiful...
set clipboard=unnamedplus
"set termguicolors
set t_Co=16

" Hand-made export of gnome terminal tango theme
let g:terminal_color_0 ='#2E3436'
let g:terminal_color_1 ='#CC0000'
let g:terminal_color_2 ='#4E9A06'
let g:terminal_color_3 ='#C4A000'
let g:terminal_color_4 ='#3465A4'
let g:terminal_color_5 ='#75507B'
let g:terminal_color_6 ='#06989A'
let g:terminal_color_7 ='#D3D7CF'
let g:terminal_color_8 ='#555753'
let g:terminal_color_9 ='#EF2929'
let g:terminal_color_10='#8AE234'
let g:terminal_color_11='#FCE94F'
let g:terminal_color_12='#729FCF'
let g:terminal_color_13='#AD7FA8'
let g:terminal_color_14='#34E2E2'
let g:terminal_color_15='#EEEEEC'

""*.color0:     #1C1C1C
""*.color8:     #444444
""*.color1:     #AF5F5F
""*.color9:     #FF8700
""*.color2:     #5F875F
""*.color10:    #87AF87
""*.color3:     #87875F
""*.color11:    #FFFFAF
""*.color4:     #5F87AF
""*.color12:    #87AFD7
""*.color5:     #5F5F87
""*.color13:    #8787AF
""*.color6:     #5F8787
""*.color14:    #5FAFAF
""*.color7:     #6C6C6C
""*.color15:    #FFFFFF

"202733
"d7005f
"5f875f
"E98C6E
"82AAFF
"8B008B
"00758f
"bfc7d5
"676E95
"EF586C
"B4E47D
"FFC142
"9DC4FF
"d7afff
"89DDFF
"e4e4e4
"

" Hand-made export of gnome terminal tango theme
"2E3436
"CC0000
"4E9A06
"C4A000
"3465A4
"75507B
"06989A
"D3D7CF
"555753
"EF2929
"8AE234
"FCE94F
"729FCF
"AD7FA8
"34E2E2
"EEEEEC

