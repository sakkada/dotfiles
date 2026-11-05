# How to install with additional libs via uv:
# Windows:
# > uv tool install pypyp
# > FOR /F "tokens=*" %i IN ('pyp sys.executable') DO SET PYP_PYTHON_PATH=%i
# > uv pip install pipetools --python=%PYP_PYTHON_PATH%
# > uv pip install rich --python=%PYP_PYTHON_PATH%
#
# See more at:
# - https://github.com/hauntsaninja/pyp
# - https://0101.github.io/pipetools/doc/index.html
#
# Cheatsheet, see more in `pyp --help` output:
# - Use `x`, `l` or `line` for a line in the input. Use `i`, `idx` or `index` for the index
# - Use `lines` to get a list of rstripped lines
# - Use `stdin` to get sys.stdin
# - Use print explicitly if you don't like when or how or what pyp's printing
# - If the magic is ever too mysterious, use --explain

import numpy as np
import pipetools
import rich

j = json.loads(stdin.read())
jl = json.loads(l)

f  = x.split()
ff = defaultdict(lambda: None, dict(enumerate(x.split())))

ddc = defaultdict
ddl = defaultdict(list)
ddi = defaultdict(int)
dds = defaultdict(str)

ll = lines
ln = int(l)
lf = float(l)

si = sys.stdin.read()
sil = sys.stdin.readlines()

rp = rich.print
pr = print
pe = lambda *args, end='', **kwargs: print(*args, end=end, **kwargs)
ppe = pipetools.pipe | pe

# pipetools
# ---------
# Usage
# -----
# f = pipe | a | b | c                        ->  def f(x):
#                                                     return c(b(a(x)))
# some_input > pipe | foo | bar | boo         -> (pipe | foo | bar | boo)(some_input)
#
# X objets
# --------
# X.some_attr.some_func(1, 2, 3).whatever     -> lambda x: x.some_attr.some_func(1, 2, 3).whatever
# X > 5                                       -> lambda x: x > 5
# X._in_(container)                           -> X in container
#
# Pipetools
# seq 30 | pyp "ll>pp | (map, int) | where_not(X%2) | list | X[::2] | (map, lambda x: x**2)"

KEY                     = pipetools.KEY
VALUE                   = pipetools.VALUE
X                       = pipetools.X
as_args                 = pipetools.as_args
as_kwargs               = pipetools.as_kwargs
count                   = pipetools.count
debug_print             = pipetools.debug_print
drop_first              = pipetools.drop_first
first_of                = pipetools.first_of
flatten                 = pipetools.flatten
foreach                 = pipetools.foreach
foreach_do              = pipetools.foreach_do
group_by                = pipetools.group_by
maybe                   = pipetools.maybe
pipe                    = pipetools.pipe
select_first            = pipetools.select_first
sort                    = pipetools.sort
sort_by                 = pipetools.sort_by
take_first              = pipetools.take_first
take_until              = pipetools.take_until
take_until_including    = pipetools.take_until_including
tee                     = pipetools.tee
unless                  = pipetools.unless
where                   = pipetools.where
where_not               = pipetools.where_not
xpartial                = pipetools.xpartial

pp                      = pipetools.pipe
fore                    = pipetools.foreach
foredo                  = pipetools.foreach_do

# Utils
def readme():
    with open(os.environ.get('PYP_CONFIG_PATH', '~/.config/pypyp/init.py')) as e:
        rp(e.read())
