rem
rem

git clone https://github.com/Pure-D/workspace-d.git
git clone https://github.com/Hackerpilot/DCD.git
git clone https://github.com/Hackerpilot/dfmt.git
git clone --recursive https://github.com/Hackerpilot/Dscanner.git

@rem git clone --recursive https://github.com/Pure-D/workspace-d.git
@rem git clone --recursive https://github.com/Hackerpilot/DCD.git
@rem git clone --recursive https://github.com/Hackerpilot/dfmt.git
@rem git clone --recursive https://github.com/Hackerpilot/Dscanner.git

if not exist bin mkdir Bin

pushd workspace-d
dub build --compiler=ldc2 --arch=x86_64 --combined --build=release
@rem dub build --compiler=dmd  --arch=x86_64 --combined --build=release
@rem dub build --compiler=dmd  --arch=x86_64 --build=release
if ERRORLEVEL 1 goto :eof
copy workspace-d.exe ..\bin
popd

rem goto :eof

pushd DCD
dub build --compiler=dmd --combined --arch=x86_64 --build=release --config=client
if ERRORLEVEL 1 goto :eof
dub build --compiler=dmd --combined --arch=x86_64 --build=release --config=server
if ERRORLEVEL 1 goto :eof
copy dcd-client.exe ..\bin
copy dcd-server.exe ..\bin
popd

rem goto :eof

pushd dfmt
dub build --compiler=dmd  --arch=x86_64 --combined --build=release
if ERRORLEVEL 1 goto :eof
copy dfmt.exe ..\bin
@rem call build.bat
popd

pushd Dscanner
@rem dub build --compiler=dmd  --arch=x86_64 --combined --build=release
call build.bat
if ERRORLEVEL 1 goto :eof
copy dscanner.exe ..\bin
@rem call build.bat
@rem dub.json -> "libdparse": "0.7.0-beta.1",
popd


pause
goto :eof
--------------------------------------------------
>dub build --help 
USAGE: dub build [<package>] [<options...>]

Builds a package (uses the main package in the current working directory by
default)


Command specific options
========================

      --rdmd            Use rdmd instead of directly invoking the compiler
  -f  --force           Forces a recompilation even if the target is up to
                        date
  -b  --build=VALUE     Specifies the type of build to perform. Note that
                        setting the DFLAGS environment variable will override
                        the build type with custom flags.
                        Possible names:
                          debug (default), plain, release, release-debug,
                          release-nobounds, unittest, profile, profile-gc,
                          docs, ddox, cov, unittest-cov and custom types
  -c  --config=VALUE    Builds the specified configuration. Configurations can
                        be defined in dub.json
      --compiler=VALUE  Specifies the compiler binary to use (can be a path).
                        Arbitrary pre- and suffixes to the identifiers below
                        are recognized (e.g. ldc2 or dmd-2.063) and matched to
                        the proper compiler type:
                          dmd, gdc, ldc, gdmd, ldmd
  -a  --arch=VALUE      Force a different architecture (e.g. x86 or x86_64)
  -d  --debug=VALUE     Define the specified debug version identifier when
                        building - can be used multiple times
      --nodeps          Do not check/update dependencies before building
      --force-remove    Force deletion of fetched packages with untracked files
                        when upgrading
      --build-mode=VALUE
                        Specifies the way the compiler and linker are invoked.
                        Valid values:
                          separate (default), allAtOnce, singleFile
      --single          Treats the package name as a filename. The file must
                        contain a package recipe comment.
      --combined        Tries to build the whole project in a single compiler
                        run.
      --print-builds    Prints the list of available build types
      --print-configs   Prints the list of available configurations
      --print-platform  Prints the identifiers for the current build platform
                        as used for the build fields in dub.json
      --parallel        Runs multiple compiler instances in parallel, if
                        possible.


Common options
==============

  -h  --help            Display general or command specific help
      --root=VALUE      Path to operate in instead of the current working dir
      --registry=VALUE  Search the given DUB registry URL first when resolving
                        dependencies. Can be specified multiple times.
      --skip-registry=VALUE
                        Skips searching certain package registries for
                        dependencies:
                          none: Search all configured registries (default)
                          standard: Don't search on http://code.dlang.org/
                          all: Search none of the configured registries
      --annotate        Do not perform any action, just print what would be
                        done
      --bare            Read only packages contained in the current directory
  -v  --verbose         Print diagnostic output
      --vverbose        Print debug output
  -q  --quiet           Only print warnings and errors
      --vquiet          Print no messages
      --cache=VALUE     Puts any fetched packages in the specified location
                        [local|system|user].

DUB version 1.0.0, built on Aug  2 2016

