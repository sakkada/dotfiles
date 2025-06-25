## Flex prompt setup

### Configure prompt with wizard

First step is configure flex-prompt with wizard:

```bash
$ flexprompt configure -> y12y11211111n -> y to save
```

**Note**: flexprompt wizard steps values for 0.18 version.

This will generate `flexprompt_autoconfig.lua` file.

### Configure prompt config file

After generating autoconfig file it is recommended to not edit
generated file, instead create `flexprompt_config.lua` to customize
setting to avoid loss configuration after next wizard run.

**Note**: config file contains 2 approaches to have 2-lines setup,
read more in related comments. Now selected 2nd one (top+left prompt,
no right, one line).

**Note**: env:var `VIRTUAL_ENV_PROMPT` is used instead of python's
virtual env native plugin which allow to customize color and text
of prefix.
