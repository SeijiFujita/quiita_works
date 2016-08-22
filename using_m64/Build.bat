@echo off
rem ---- DMD path
path=C:\D\dmd.2.071.1\windows\bin;

dmd -m32 -ofhello32.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello32.exe

dmd -m32mscoff -ofhello32mscoff.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello32mscoff.exe

dmd -m64 -ofhello64.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello64.exe

@if ERRORLEVEL 1 goto :eof
del *.obj

echo done...

pause 
goto :eof
-----------------------------------
C:\D\rakugaki\quiita_works\using_m64>dmd -v 
DMD32 D Compiler v2.071.1
Copyright (c) 1999-2015 by Digital Mars written by Walter Bright

Documentation: http://dlang.org/
Config file: C:\D\dmd.2.071.1\windows\bin\sc.ini
Usage:
  dmd files.d ... { -switch }

  files.d        D source files
  @cmdfile       read arguments from cmdfile
  -allinst       generate code for all template instantiations
  -betterC       omit generating some runtime information and helper functions
  -boundscheck=[on|safeonly|off]   bounds checks on, in @safe only, or off
  -c             do not link
  -color[=on|off]   force colored console output on or off
  -conf=path     use config file at path
  -cov           do code coverage analysis
  -cov=nnn       require at least nnn% code coverage
  -D             generate documentation
  -Dddocdir      write documentation file to docdir directory
  -Dffilename    write documentation file to filename
  -d             silently allow deprecated features
  -dw            show use of deprecated features as warnings (default)
  -de            show use of deprecated features as errors (halt compilation)
  -debug         compile in debug code
  -debug=level   compile in debug code <= level
  -debug=ident   compile in debug code identified by ident
  -debuglib=name    set symbolic debug library to name
  -defaultlib=name  set default library to name
  -deps          print module dependencies (imports/file/version/debug/lib)
  -deps=filename write module dependencies to filename (only imports)
  -dip25         implement http://wiki.dlang.org/DIP25 (experimental)
  -g             add symbolic debug info
  -gc            add symbolic debug info, optimize for non D debuggers
  -gs            always emit stack frame
  -gx            add stack stomp code
  -H             generate 'header' file
  -Hddirectory   write 'header' file to directory
  -Hffilename    write 'header' file to filename
  --help         print help and exit
  -Ipath         where to look for imports
  -ignore        ignore unsupported pragmas
  -inline        do function inlining
  -Jpath         where to look for string imports
  -Llinkerflag   pass linkerflag to link
  -lib           generate library rather than object files
  -m32           generate 32 bit code
  -m32mscoff     generate 32 bit code and write MS-COFF object files
  -m64           generate 64 bit code
  -main          add default main() (e.g. for unittesting)
  -man           open web browser on manual page
  -map           generate linker .map file
  -noboundscheck no array bounds checking (deprecated, use -boundscheck=off)
  -O             optimize
  -o-            do not write object file
  -odobjdir      write object & library files to directory objdir
  -offilename    name output file to filename
  -op            preserve source path for output files
  -profile       profile runtime performance of generated code
  -profile=gc    profile runtime allocations
  -release       compile release version
  -run srcfile args...   run resulting program, passing args
  -shared        generate shared library (DLL)
  -transition=id help with language change identified by 'id'
  -transition=?  list all language changes
  -unittest      compile in unit tests
  -v             verbose
  -vcolumns      print character (column) numbers in diagnostics
  -verrors=num   limit the number of error messages (0 means unlimited)
  -vgc           list all gc allocations including hidden ones
  -vtls          list all variables going into thread local storage
  --version      print compiler version and exit
  -version=level compile in version code >= level
  -version=ident compile in version code identified by ident
  -w             warnings as errors (compilation will halt)
  -wi            warnings as messages (compilation will continue)
  -X             generate JSON file
  -Xffilename    write JSON file to filename

