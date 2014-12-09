TightPy
=======

Tight Python project integration for Vim


Installation
============

Please use Vundle or other Vim package manager of your choice. Also recommended are the following dependencies:

* `Quiark/qtpy-vim` 
* Exuberant Ctags 
* Ack 2.0

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

Then, to open your project in Vim, tell Vim to load your settings.vim:

```
gvim -S settings.vim
```

It's best to create a desktop shortcut or something. The working directory must be the project directory!
