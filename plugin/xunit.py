import os
import sys
import vim
import xml.etree.ElementTree as ET

def convert_xunit_xml(fname):
	tree = ET.parse(fname)
	root = tree.getroot()

	for tcase in root.findall('testcase'):
		for err in tcase.findall('error') + tcase.findall('failure'):
			yield 'ERROR: {}'.format(err.attrib['type'])
			if 'message' in err.attrib:
				yield str(err.attrib['message'])
			yield '\n---\n'
			yield str(err.text)


def copen_xunit_xml(fname):
	vim.vars['xunit_xml_result'] = '\n'.join(convert_xunit_xml(fname))
	vim.command('cexpr "nosetests.xml output"')
	vim.command('caddexpr g:xunit_xml_result')

#print '\n'.join(copen_xunit_xml(r'C:\My Dropbox\key4twoshare\Roman\nosetests.xml'))
