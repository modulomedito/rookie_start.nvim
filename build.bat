@echo off
setlocal
cd /d "%~dp0"
python "%~dp0expand_plugins.py" %*
endlocal
