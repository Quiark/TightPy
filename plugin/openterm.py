import os
import platform
import tempfile
import subprocess

PY='python-32' if platform.system() == 'Darwin' else 'python'


def openterm_win(command):
    return 'start ' + command

def openterm_2topinka(command):
    return r"c:\Software\ConEmu\conemu64.exe /cmd " + command

def openterm_mac(command):
    cmdfile = tempfile.NamedTemporaryFile(prefix='tpycmd', delete=False)
    cmdfile.write('cd {0}\n'.format(os.getcwd()))
    cmdfile.write(command)

    os.chmod(cmdfile.name, 0777)

    apscript = """tell application "Terminal" to do script "{0}" """.format(cmdfile.name)
    return """osascript -e '{0}'""".format(apscript)


def openterm(command):
    if platform.system() == 'Windows':
        if platform.node() == '2Topinka':
            return openterm_2topinka(command)
        else:
            return openterm_win(command)
    else:
        return openterm_mac(command)

def execute(command):
    p = subprocess.Popen(openterm(command), shell=True)
    # not waiting

def py_execute(command):
    return execute('{PY} {cmd}'.format(PY=PY, cmd=command))

if __name__ == '__main__':
    execute('python')
