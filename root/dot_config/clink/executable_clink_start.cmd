@echo off

echo Clink startup "clink_start.cmd" script.
echo Script location: "%~dp0clink_start.cmd".

echo.
echo -----------------------------------
echo Execute environment variables updates.

set PATH_PREFIX=
set PATH_POSTFIX=^
c:/system/software/githubbin;^
c:/system/software/portable/bridge;^
%USERPROFILE%/scoop/apps/gimp/current/bin

if not "%CLINK_NO_INIT_INFO%" == "" (goto no_info_path_variable)
printf "\nPath original:\n"
echo %PATH% | sed -e %s/;/\n/g
printf "\nPath prefix:\n"
echo %PATH_PREFIX% | sed -e %s/;/\n/g
printf "\nPath postfix:\n"
echo %PATH_POSTFIX% | sed -e %s/;/\n/g
:no_info_path_variable

@echo on
set RIPGREP_CONFIG_PATH=%USERPROFILE%/.config/ripgrep/ripgreprc
set VIFM=%USERPROFILE%/.config/vifm
set DOCKER_HOST=npipe:////./pipe/docker_engine
set EDITOR=nvim
@echo off
set PATH=%PATH_PREFIX%;%PATH%;%PATH_POSTFIX%

echo -----------------------------------
echo Execute doskey aliases configuration:

:: lesss => less -S -R -i -m, lesso => less -S -R -i -m -F
@echo on
doskey j=just $*
doskey lesss=less --chop-long-lines --RAW-CONTROL-CHARS --ignore-case --long-prompt $*
doskey lesso=less --chop-long-lines --RAW-CONTROL-CHARS --ignore-case --long-prompt --quit-if-one-screen $*
doskey lz=eza $*
doskey ll=eza --long --almost-all --git --icons --time-style="+%%Y-%%m-%%d %%H:%%M:%%S" --header --group-directories-first --level=10 --color=always $* ^| less -S -r -F
doskey llt=eza --long --almost-all --git --icons --time-style="+%%Y-%%m-%%d %%H:%%M:%%S" --header --group-directories-first --level=10 --color=always --tree $* ^| less -S -r
doskey lld=eza --long --almost-all --git --icons --time-style="+%%Y-%%m-%%d %%H:%%M:%%S" --header --group-directories-first --level=10 --color=always --tree --only-dirs $* ^| less -S -r
@echo off

echo -----------------------------------

if not "%CLINK_NO_INIT_INFO%" == "" (goto no_info_fastfetch)
fastfetch.exe
set CLINK_NO_INIT_INFO=1
:no_info_fastfetch
