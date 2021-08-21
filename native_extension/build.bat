@echo off

:: set environment
if not "%~1"=="" set FLEX_HOME=%~1

:: build
echo build with %FLEX_HOME%
"C:\Users\User\source\SDK\apache-ant-1.9.16\bin\ant.bat"
