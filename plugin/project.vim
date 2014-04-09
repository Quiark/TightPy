" Common iPatrol settings to use Vim to develop Python projects based on
" cefpython and the key4two framework
"

if exists("g:tightpy_loaded") || &cp
	finish
endif


python << END
import os
import sys
sys.path.append(os.path.split(vim.eval("expand('<sfile>')"))[0])
END

function! TightPy_Init()
	" Basic required settings for git
	setglobal noet
	set noet
	setglobal nowrap
	setglobal ff=unix
	set completeopt=menu " disable the super-annoying preview window

	let g:pymode_trim_whitespaces = 0


	" instead of trying to capture the whole traceback into one error message, we
	" just capture the individual file locations so that we can go to each of them
	" easily
	set errorformat=\ \ File\ \"%f\"\\,\ line\ %l\\,\ %m
	

	" defaults
	let g:tightpy_editor='gvim'
	let g:tightpy_proj_log_file='app.log'
	let g:tightpy_run_prog='start'
	let g:tightpy_proj_mainscript=''
	let g:tightpy_proj_pythondirs=['.']

	" menu items
	menu &Plugin.QTPY.Run\ method			:QTPY method<CR>
	menu &Plugin.QTPY.Run\ class			:QTPY class<CR>
	menu &Plugin.QTPY.Run\ file				:QTPY file<CR>
	menu &Plugin.T&ightPy.Open\ &log		:call TightPy_OpenLog()<CR>
	menu &Plugin.T&ightPy.Load\ log			:call TightPy_GetLog()<CR>
	menu &Plugin.T&ightPy.Copy\ &Breakpoint :call TightPy_CopyBp()<CR>
	menu &Plugin.T&ightPy.Run				:call TightPy_RunApp()<CR>
	menu &Plugin.T&ightPy.Debug\ tests.Enable	:call TightPy_QTPY_EnableDebug(1)<CR>
	menu &Plugin.T&ightPy.Debug\ tests.Disable	:call TightPy_QTPY_EnableDebug(0)<CR>
	menu &Plugin.T&ightPy.&Generate\ tags		:call TightPy_MakeTags()<CR>

endfunction


function! TightPy_OpenLog()
	exec 'silent !'.g:tightpy_editor.' '.g:tightpy_proj_log_file
endfunction


function! TightPy_RomanWin_Cfg()
	" Custom settings for Roman's computer (Windows), all projects
	let g:tightpy_run_prog='c:\Software\ConEmu\conemu64.exe /cmd'
	let g:pymode_paths = g:tightpy_proj_pythondirs

	call TightPy_InitAck()

	map <F6> :QTPY method<CR>
endfunction

function! TightPy_RunApp()
	wa
	exec 'silent !'.g:tightpy_run_prog.' python '.g:tightpy_proj_mainscript
endfunction

function! TightPy_GetLog()
	let &makeprg='cat '.g:tightpy_proj_log_file
	make
endfunction

function! TightPy_QTPY_EnableDebug(val)
	if (a:val)
		let g:qtpy_debugger = 'winpdb'
		let g:qtpy_shell_command = 'nosetests-script.py'
	else
		let g:qtpy_debugger = ''
		let g:qtpy_shell_command = 'nosetests'
	endif
endfunction

function! TightPy_CopyBp()
	
python << END
import pyperclip
pyperclip.copy('bp {0}:{1}'.format(
	vim.eval('expand("%:p")'),
	vim.eval('line(".")')))
END
endfunction

function! TightPy_InitAck()
	let g:tightpy_proj_ackdirs = join(map(g:tightpy_proj_pythondirs, 'v:val'), ' ')
	let &grepprg='ack -n $* ' . g:tightpy_proj_ackdirs
endfunction

function! TightPy_MakeTags()
    exe 'silent !ctags ' . join(map(g:tightpy_proj_pythondirs, 'v:val . "/*"'), ' ')
endfunction

" TODO:
"	+ making tags
"	+ grepping (with ignore folders)
"	+ print curret file name and line to quickly make a breakpoint
"		bp key4two.py:123
"
"
" notes: to run tests
"	nosetests tests/file.py:ClassName -m test_name
"
" to run it under winpdb:
"   winpdb nosetests-script.py ...
let g:tightpy_loaded = 1
