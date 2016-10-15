@echo off
path=C:\D\ldc2-1.0.0-win32-msvc\bin;c:\windows\system32;
ldc2 -m32 -ofhello32.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello32.exe

path=C:\D\ldc2-1.0.0-win64-msvc\bin;c:\windows\system32;
ldc2 -m64 -ofhello64.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello64.exe

echo done...
pause
goto :eof

OVERVIEW: LDC - the LLVM D compiler

USAGE: ldc2 [options] files --run Runs the resulting program, passing the remaining arguments to it

OPTIONS:
  -D                                        - Generate documentation
  -Dd=<docdir>                              - Write documentation file to <docdir> directory
  -Df=<filename>                            - Write documentation file to <filename>
  -H                                        - Generate 'header' file
  -Hd=<hdrdir>                              - Write 'header' file to <hdrdir> directory
  -Hf=<filename>                            - Write 'header' file to <filename>
  -Hkeep-all-bodies                         - Keep all function bodies in .di files
  -I=<path>                                 - Where to look for imports
  -J=<path>                                 - Where to look for string imports
  -L=<linkerflag>                           - Pass <linkerflag> to the linker
  Setting the optimization level:
    -O                                      - Equivalent to -O3
    -O0                                     - No optimizations (default)
    -O1                                     - Simple optimizations
    -O2                                     - Good optimizations
    -O3                                     - Aggressive optimizations
    -O4                                     - Link-time optimization
    -O5                                     - Link-time optimization
    -Os                                     - Like -O2 with extra optimizations for size
    -Oz                                     - Like -Os but reduces code size further
  -X                                        - Generate JSON file
  -Xf=<filename>                            - Write JSON file to <filename>
  -allinst                                  - generate code for all template instantiations
  -boundscheck                              - Enable array bounds check
    =off                                    -   no array bounds checks
    =safeonly                               -   array bounds checks for safe functions only
    =on                                     -   array bounds checks for all functions
  -c                                        - Do not link
  -check-printf-calls                       - Validate printf call format strings against arguments
  -code-model                               - Code model
    =default                                -   Target default code model
    =small                                  -   Small code model
    =kernel                                 -   Kernel code model
    =medium                                 -   Medium code model
    =large                                  -   Large code model
  -conf=<filename>                          - Use configuration file <filename>
  -cov                                      - Compile-in code coverage analysis
                                              (use -cov=n for n% minimum required coverage)
  Allow deprecated code/language features:
    -de                                     - Do not allow deprecated features
    -d                                      - Silently allow deprecated features
    -dw                                     - Warn about the use of deprecated features
  -d-debug=<level/idents>                   - Compile in debug code >= <level> or identified by <idents>.
  -d-version=<level/idents>                 - Compile in version code >= <level> or identified by <idents>
  -debuglib=<lib1,lib2,...>                 - Debug versions of default libraries (overrides previous)
  -defaultlib=<lib1,lib2,...>               - Default libraries to link with (overrides previous)
  -deps=<filename>                          - Write module dependencies to filename
  -dip25                                    - implement http://wiki.dlang.org/DIP25 (experimental)
  -enable-asserts                           - (*) Enable assertions
    =enable-asserts                         -   (*) Enable assertions
  -enable-color                             - Force colored console output
    =enable-color                           -   Force colored console output
  -disable-d-passes                         - Disable all D-specific passes
  -disable-fp-elim                          - Disable frame pointer elimination optimization
  -disable-gc2stack                         - Disable promotion of GC allocations to stack memory
  -enable-inlining                          - Enable function inlining (default in -O2 and higher)
    =enable-inlining                        -   Enable function inlining (default in -O2 and higher)
  -enable-invariants                        - (*) Enable invariants
    =enable-invariants                      -   (*) Enable invariants
  -disable-linker-strip-dead                - Do not try to remove unused symbols during linking
  -disable-loop-unrolling                   - Disable loop unrolling in all relevant passes
  -disable-loop-vectorization               - Disable the loop vectorization pass
  -enable-preconditions                     - (*) Enable function preconditions
    =enable-preconditions                   -   (*) Enable function preconditions
  -disable-red-zone                         - Do not emit code that uses the red zone.
  -disable-simplify-drtcalls                - Disable simplification of druntime calls
  -disable-simplify-libcalls                - Disable simplification of well-known C runtime calls
  -disable-slp-vectorization                - Disable the slp vectorization pass
  -enable-contracts                         - (*) Enable function pre- and post-conditions
    =enable-contracts                       -   (*) Enable function pre- and post-conditions
  -enable-implicit-null-checks              - Fold null checks into faulting memory operations
  -enable-name-compression                  - Enable name string compression
  -enable-postconditions                    - (*) Enable function postconditions
    =enable-postconditions                  -   (*) Enable function postconditions
  -expensive-combines                       - Enable expensive instruction combines
  -filter-print-funcs=<function names>      - Only print IR for functions whose name match this for all print-[before|after][-all] options
  -float-abi                                - ABI/operations to use for floating-point types:
    =default                                -   Target default floating-point ABI
    =soft                                   -   Software floating-point ABI and operations
    =softfp                                 -   Soft-float ABI, but hardware floating-point instructions
    =hard                                   -   Hardware floating-point ABI and instructions
  -fthread-model                            - Thread model
    =global-dynamic                         -   Global dynamic TLS model (default)
    =local-dynamic                          -   Local dynamic TLS model
    =initial-exec                           -   Initial exec TLS model
    =local-exec                             -   Local exec TLS model
  Generating debug information:
    -g                                      - Generate debug information
    -gc                                     - Same as -g, but pretend to be C
  -group-functions-by-hotness               - Partition hot/cold functions by sections prefix
  -help                                     - Display available options (-help-hidden for more)
  -ignore                                   - Ignore unsupported pragmas
  -imp-null-check-page-size=<int>           - The page size of the target in bytes
  -lib                                      - Create static library
  -link-debuglib                            - Link with libraries specified in -debuglib, not -defaultlib
  -linkonce-templates                       - Use linkonce_odr linkage for template symbols instead of weak_odr
  -m32                                      - 32 bit target
  -m64                                      - 64 bit target
  -main                                     - Add empty main() (e.g. for unittesting)
  -march=<string>                           - Architecture to generate code for:
  -mattr=<a1,+a2,-a3,...>                   - Target specific attributes (-mattr=help for details)
  -mcpu=<cpu-name>                          - Target a specific cpu type (-mcpu=help for details)
  -mtriple=<string>                         - Override target triple
  -noasm                                    - Disallow use of inline assembler
  -nogc                                     - Do not allow code that generates implicit garbage collector calls
  -o-                                       - Do not write object file
  -od=<objdir>                              - Write object files to directory <objdir>
  -of=<filename>                            - Use <filename> as output file name
  -op                                       - Do not strip paths from source file
  -oq                                       - Write object files with fully qualified names
  -output-bc                                - Write LLVM bitcode
  -output-ll                                - Write LLVM IR
  -output-o                                 - Write native object
  -output-s                                 - Write native assembly
  -property                                 - Enforce property syntax
  -release                                  - Disables asserts, invariants, contracts and boundscheck
  -relocation-model                         - Relocation model
    =default                                -   Target default relocation model
    =static                                 -   Non-relocatable code
    =pic                                    -   Fully relocatable, position independent code
    =dynamic-no-pic                         -   Relocatable external references, non-relocatable code
  -run=<string>                             - Runs the resulting program, passing the remaining arguments to it
  -sample-profile-check-record-coverage=<N> - Emit a warning if less than N% of records in the input profile are matched to the IR.
  -sample-profile-check-sample-coverage=<N> - Emit a warning if less than N% of samples in the input profile are matched to the IR.
  -sample-profile-global-cold-threshold=<N> - Top-level functions that account for less than N% of all samples collected in the profile, will be marked as cold for the inliner to consider.
  -sample-profile-global-hot-threshold=<N>  - Top-level functions that account for more than N% of all samples collected in the profile, will be marked as hot for the inliner to consider.
  -sample-profile-inline-hot-threshold=<N>  - Inlined functions that account for more than N% of all samples collected in the parent function, will be inlined again.
  -sanitize                                 - Enable runtime instrumentation for bug detection
    =address                                -   memory errors
    =memory                                 -   memory errors
    =thread                                 -   race detection
  -shared                                   - Create shared library
  -singleobj                                - Create only a single output object file
  -static                                   - Create a statically linked binary, including all system dependencies
  -summary-file=<string>                    - The summary file to use for function importing.
  -template-depth=<uint>                    - (experimental) set maximum number of nested template instantiations
  -unittest                                 - Compile in unit tests
  -v                                        - Verbose
  -v-cg                                     - Verbose codegen
  -vcolumns                                 - print character (column) numbers in diagnostics
  -verify-scev-maps                         - Verify no dangling value in ScalarEvolution's ExprValueMap (slow)
  -verrors=<uint>                           - limit the number of error messages (0 means unlimited)
  -version                                  - Display the version of this program
  -vgc                                      - list all gc allocations including hidden ones
  -vv                                       - Print front-end/glue code debug log
  Warnings:
    -w                                      - Enable warnings
    -wi                                     - Enable informational warnings
  -x86-asm-syntax                           - Choose style of code to emit from X86 backend:
    =att                                    -   Emit AT&T-style assembly
    =intel                                  -   Emit Intel-style assembly

