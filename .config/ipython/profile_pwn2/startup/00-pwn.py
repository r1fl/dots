from pwn import *

formatter = get_ipython().display_formatter.formatters['text/plain']
formatter.for_type(int, lambda n, p, cycle: p.text("%#x" % n))

