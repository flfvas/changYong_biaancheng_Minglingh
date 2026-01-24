@echo off
setlocal enabledelayedexpansion

:: 获取当前 bat 所在目录（不带引号）
set "curdir=%~dp0"

echo 当前目录为: %curdir%
echo.

:: 检查 PATH 是否已包含当前目录
echo %PATH% | findstr /I "%curdir%" >nul
if %errorlevel%==0 (
    echo PATH 已包含该目录，无需重复添加。
    goto end
)

echo 正在将当前目录添加到系统 PATH...
setx PATH "%curdir%;%PATH%" /M

echo.
echo 添加完成，请重新打开 CMD 以生效。
echo.

:end
pause