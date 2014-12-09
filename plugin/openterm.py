import os
import platform
import tempfile
import subprocess

PY='python-32' if platform.system() == 'Darwin' else 'python'


def openterm_win(command):
    return 'start ' + command

def openterm_2topinka(command):
    return r"c:\Software\ConEmu\conemu64.exe /cmd " + command

def openterm_mac(command, cwd=None):
    cmdfile = tempfile.NamedTemporaryFile(prefix='tpycmd', delete=False)
    cmdfile.write('cd {0}\n'.format(cwd or os.getcwd()))
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
    # not waiting
    return subprocess.Popen(openterm(command), shell=True)

def py_execute(command, wait=False):
    p = execute('{PY} {cmd}'.format(PY=PY, cmd=command))
    if wait: p.wait()


def nosetests_cmd(params, dbg=False):
    'Returns the command required to run nosetests on any platform'
    if platform.system() == 'Windows':
        return '{winpdb} {cmd} {params}'.format(
            winpdb='start winpdb.bat' if dbg else '',
            cmd='nosetests-script.py' if dbg else 'nosetests',
            params=params)
    else:
        cmd = '{PY} {winpdb} {pyrun} {cmd} {params}'.format(
            PY=PY,
            pyrun='--pyrun=python-32' if dbg else '',
            winpdb='`which winpdb`' if dbg else '',
            cmd='`which nosetests`',
            params=params)

        if dbg:
            return openterm(cmd)
        else:
            return cmd



if __name__ == '__main__':
    print (nosetests_cmd('tests/misc.py'))
