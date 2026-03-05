"""
How to install with additional libs via uv:
> uv tool install pypyp
> pyp "import sys; sys.executable" > python_path
> uv pip install pipetools --python={python_path}
> uv pip install rich --python={python_path}

See more at:
- https://github.com/hauntsaninja/pyp
- https://0101.github.io/pipetools/doc/index.html
"""

import numpy as np
import pipetools
import rich

j = json.loads(stdin.read())
jl = json.loads(l)

ln = int(l)
lf = float(l)

f  = x.split()
ff = defaultdict(lambda: None, dict(enumerate(x.split())))

ddc = defaultdict
ddl = defaultdict(list)
ddi = defaultdict(int)
dds = defaultdict(str)

ll = lines

rp = rich.print
pr = print
pe = lambda *args, end='', **kwargs: print(*args, end=end, **kwargs)
ppe = pipetools.pipe | pe

# pipetools
KEY                   = pipetools.KEY
VALUE                 = pipetools.VALUE
X                     = pipetools.X
as_args               = pipetools.as_args
as_kwargs             = pipetools.as_kwargs
count                 = pipetools.count
debug_print           = pipetools.debug_print
drop_first            = pipetools.drop_first
first_of              = pipetools.first_of
flatten               = pipetools.flatten
foreach               = pipetools.foreach
foreach_do            = pipetools.foreach_do
group_by              = pipetools.group_by
maybe                 = pipetools.maybe
pipe                  = pipetools.pipe
select_first          = pipetools.select_first
sort                  = pipetools.sort
sort_by               = pipetools.sort_by
take_first            = pipetools.take_first
take_until            = pipetools.take_until
take_until_including  = pipetools.take_until_including
tee                   = pipetools.tee
unless                = pipetools.unless
where                 = pipetools.where
where_not             = pipetools.where_not
xpartial              = pipetools.xpartial
