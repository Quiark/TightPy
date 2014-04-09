TightPy
=======

Tight Python project integration for Vim


Installation
============

Please use Vundle or other Vim package manager of your choice.

Usage
=====

Create a settings.vim file in your project and initialize TightPy by setting variables and calling functions:


```
call TightPy_Init()

let g:tightpy_proj_log_file='c:\Users\Roman\AppData\Local\Temp\project\logfile.txt'
let g:tightpy_editor='gvim'
let g:tightpy_proj_mainscript='mainfile.py'
let g:tightpy_proj_pythondirs=['.', 'tests', 'storage']


```
