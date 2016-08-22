@echo off
set LDC_VSDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\
rem set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\


setlocal
path=C:\D\ldc2-1.0.0-win32-msvc\bin;%VCINSTALLDIR%\bin;c:\windows\system32;
call msvcEnv.bat x86

ldc2 -m32 -ofhello32.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello32.exe
endlocal


setlocal
path=C:\D\ldc2-1.0.0-win64-msvc\bin;%VCINSTALLDIR%\bin;c:\windows\system32;
call msvcEnv.bat amd64

ldc2 -m64 -ofhello64.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello64.exe
endlocal



