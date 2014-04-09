" Vim syntax file
" file type: key4two log files
" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
finish
endif

" Utilities
set autoread
set guioptions+=b


" Syntax
syn match fatal ".* FATAL .*" contains=actual_message,function
syn match error ".* ERROR .*" contains=actual_message,function
syn match warn ".* WARNING .*" contains=actual_message,function
syn match info ".* INFO .*" contains=actual_message,function
syn match debug ".* DEBUG .*" contains=actual_message,function

syn match error "^*Exception.*"
syn match error "^*Error.*"

syn match function "\w\+()"

syn match actual_message "| .*$"


syn match Ignore '\x1b\[\d\+m'

" Highlight colors for log levels.
hi fatal guibg=#F5AD8E guifg=red
hi error guibg=#F4C3AD guifg=black
hi warn guibg=#FFF47E
hi info guibg=#7EFF9E 
hi debug guibg=#E6FFF9

hi actual_message guifg=black
hi function gui=italic

let b:current_syntax = "logk4t"

nmap <Space> :e<CR>

" vim: ts=2 sw=2 
