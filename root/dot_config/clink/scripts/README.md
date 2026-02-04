# Clink script

Clink scripts directories is added by `clink installscripts {path}`.

Currently there are 3 installedscripts directories:

- sakkada - current config scripts files
- gizmos - a collection of Lua scripts from author of clink (https://github.com/chrisant996/clink-gizmos)
- zoxide - zoxide support for clink (https://github.com/shunsambongi/clink-zoxide)

To isntall each of them run the following in clink session:

```
cd %CLINK_PROFILE%
if not exist "scripts\" mkdir "scripts"

cd scripts\
if not exist "sakkada\" mkdir "sakkada"
if not exist "gizmos\" mkdir "gizmos"
if not exist "zoxide\" mkdir "zoxide"

:: clone github repositories into according directories
git clone https://github.com/chrisant996/clink-gizmos gizmos
git clone https://github.com/shunsambongi/clink-zoxide zoxide
```

## Win registry path to InstalledScripts

```reg
HKEY_CURRENT_USER\SOFTWARE\Clink\InstalledScripts
```

## Install/Reorder installscripts list

To backup installscripts values, run in clink session:

```sh
clink installscripts --list > installscripts.tmp
```

To install/reorder installscripts list, run in clink session:

```sh
set SCOOP_APPS_DIR="%USERPROFILE%\scoop\apps"
set CLINK_FLEX_PROMPT_VERSION=0.18

clink uninstallscripts "%CLINK_PROFILE%\scripts\sakkada"
clink uninstallscripts "%CLINK_PROFILE%\scripts\gizmos"
clink uninstallscripts "%CLINK_PROFILE%\scripts\zoxide"
clink uninstallscripts "%SCOOP_APPS_DIR%\clink-flex-prompt\%CLINK_FLEX_PROMPT_VERSION%"
clink uninstallscripts "%SCOOP_APPS_DIR%\clink-completions\current"

clink installscripts "%CLINK_PROFILE%\scripts\sakkada"
clink installscripts "%CLINK_PROFILE%\scripts\gizmos"
clink installscripts "%CLINK_PROFILE%\scripts\zoxide"
clink installscripts "%SCOOP_APPS_DIR%\clink-flex-prompt\%CLINK_FLEX_PROMPT_VERSION%"
clink installscripts "%SCOOP_APPS_DIR%\clink-completions\current"

:: check all is correct:
clink installscripts --list
```

Note: do not forget set %CLINK_FLEX_PROMPT_VERSION% to current clink-flex-prompt version value.
