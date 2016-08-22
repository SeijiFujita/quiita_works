
## D言語 dmd/ldc のインストールメモ(Windows 64bitアプリケーション編)

Windows 10 にアップデートしたことを機会に dmd/ldc のインストール環境をまとめました。

## Windows 64bit な.EXEを作るには
dmd は -m64 オプションにより 64bitのObjectファイルを出力することができますが
付属の link.exe(optlink) は 16/32bit用なので Windows 64bitのリンクができません
そこで、Microsoft Visual C++ の link.exe/Runtime を利用し Windows 64bit .EXE を作ります。
また、ldc も link.exe/Runtime が付属していないので同様の方法で対応します。 



## 一般的なインストール方法(dmd)
おおまかなインストール手順は以下です。

1. Visual C++ をインストール
1. dmd Windows版でインストール
1. 設定が有効であるか確認



### Visual C++ をインストール
Visual C++ は Visual Studio Community 2005 をインストールしました
なお Visual C++ はオプションで指定しないとインストールされないので注意が必要です

![VisualStadioComm2015_setup.png](https://https://github.com/SeijiFujita/quiita_work/blob/master/using_m64/VisualStadioComm2015_setup.png)

以下にダウンロードのリンクや解説サイトのリンク
- Community 2015 JPN Direct download link https://www.visualstudio.com/post-download-vs?sku=community&clcid=0x411
- Visual Studio Community 2015 Page https://www.visualstudio.com/ja-jp/downloads/download-visual-studio-vs.aspx
- Visual Studio 2015の解説 http://www.atmarkit.co.jp/ait/articles/1508/07/news031.html


### dmd Windows版でインストール
dmd Windows版インストーラを使い dmd本体および Visual D のインストールを行います。
注意点は Visual D(Visual Studio D extension)をチェックしインストールしてください
Visual D のインストーラは Visual C++ が設定した環境変数 VCINSTALLDIR を見て dmd2/windows/bin/sc.ini 設定します。

![VisualStadioComm2015_setup.png](https://https://github.com/SeijiFujita/quiita_work/blob/master/using_m64/VisualStadioComm2015_setup.png)


- dmd download Page (Windows exe) https://dlang.org/download.html
- dmd Release Archive http://downloads.dlang.org/releases/


### 設定が有効であるか確認しましょう
インストールが終わったら以下のソースコードをコンパイル

*テスト用ソースコード

```d:hello.d
// Written in the D programming language.
// dmd 2.071.1
/*
dmd option
  -m32           generate 32 bit code
  -m32mscoff     generate 32 bit code and write MS-COFF object files
  -m64           generate 64 bit code
*/

import std.stdio;

int main()
{
	version(Win32)
	{
		writeln("Win32");
	}
	else version(Win64)
	{
		writeln("Win64");
	}
	else
	{
		writeln("Win??");
	}
	
	version(CRuntime_DigitalMars)
	{
		writeln("CRuntime_DigitalMars");
	}
	version(CRuntime_Microsoft)
	{
		writeln("CRuntime_Microsoft");
	}
	writeln("hello! done...");
	
	return 0;
}
```


*Build.bat ファイル
```bat:Build.bat
@echo off
rem ---- DMD
path=C:\D\dmd.2.071.0\windows\bin;

@echo on

dmd -wi -m32 -ofhello32.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello32.exe

dmd -wi -m32mscoff -ofhello32mscoff.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello32mscoff.exe

dmd -wi -m64 -ofhello64.exe hello.d
@if ERRORLEVEL 1 goto :eof
hello64.exe

echo done...

```


*以下のような表示されいればＯＫ

```d
Win32
CRuntime_DigitalMars
##------------------
Win32
CRuntime_Microsoft
##------------------
Win64
CRuntime_Microsoft
##------------------
done...

```



## LDCのインストール
LDC はコンパイル済みのアーカイブを展開しインストールします。
すでに、Visual C++ をインストールされている場合は再びインストール必要はありません!!
おおかまな手順を以下に示します。


1. Visual C++ をインストール
1. ldcdmd Windows版でインストール
1. 設定が有効であるか確認


##

- LDC v1.0.0 release https://github.com/ldc-developers/ldc/releases/tag/v1.0.0
- LDC win32-msvc Direct download link https://github.com/ldc-developers/ldc/releases/download/v1.0.0/ldc2-1.0.0-win32-msvc.zip
- LDC win64-msvc Direct download link https://github.com/ldc-developers/ldc/releases/download/v1.0.0/ldc2-1.0.0-win64-msvc.zip





## dmdを.7zを展開して使っている人向け解説です。

## .dmdのsc.iniの書き換え


## .設定が有効であるか確認







C:\D\dmd.2.071.0\windows\bin\sc.ini

VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\
WindowsSdkDir=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\




![helloworld.png](https://.png)





tag: dlang
filename: using_m64.md
last update: 2016/05/1



[Version]
version=7.51 Build 020


; environment for both 32/64 bit
[Environment]
DFLAGS="-I%@P%\..\..\src\phobos" "-I%@P%\..\..\src\druntime\import"

; optlink only reads from the Environment section so we need this redundancy
; from the Environment32 section (bugzilla 11302)
LIB="%@P%\..\lib"


[Environment32]
LIB="%@P%\..\lib"
LINKCMD=%@P%\link.exe


[Environment64]
LIB="%@P%\..\lib64"

; needed to avoid COMDAT folding (bugzilla 10664)
DFLAGS=%DFLAGS% -L/OPT:NOICF

; default to 32-bit linker (can generate 64-bit code) that has a common path
; for VS2008, VS2010, VS2012, and VS2013. This will be overridden below if the
; installer detects VS.
LINKCMD=%VCINSTALLDIR%\bin\link.exe


; -----------------------------------------------------------------------------
; This enclosed section is specially crafted to be activated by the Windows
; installer when it detects the actual paths to VC and SDK installations so
; modify this in the default sc.ini within the dmd git repo with care.
;
; End users: You can fill in the path to VC and Windows SDK and uncomment out
; the appropriate LINKCMD to manually enable support yourself.
;
; Users using Visual Studio 2010 Express with SDK 7.0A: The installer cannot
; determine the path to the 64-bit compiler included with SDK 7.0A. It's
; recommended to install the Windows SDK 7.1A. Alternatively you can set
; LINKCMD as the path to link.exe SDK 7.0A installs. It would typically be:
;   C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\bin\amd64\link.exe


; Windows installer replaces the following lines with the actual paths
VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\
WindowsSdkDir=C:\Program Files (x86)\Windows Kits\8.1\
UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
UCRTVersion=10.0.10240.0

; Windows installer uncomments the version detected
LINKCMD=%VCINSTALLDIR%\bin\x86_amd64\link.exe
;VC2013 LINKCMD=%VCINSTALLDIR%\bin\x86_amd64\link.exe
;VC2012 LINKCMD=%VCINSTALLDIR%\bin\x86_amd64\link.exe
;VC2010 LINKCMD=%VCINSTALLDIR%\bin\amd64\link.exe
;VC2008 LINKCMD=%VCINSTALLDIR%\bin\amd64\link.exe

; needed with /DEBUG to find mspdb*.dll (only for VS2012 or VS2013)
PATH=%PATH%;%VCINSTALLDIR%\bin\x86_amd64;%VCINSTALLDIR%\bin
;VC2013 PATH=%PATH%;%VCINSTALLDIR%\bin\x86_amd64;%VCINSTALLDIR%\..\Common7\IDE;%VCINSTALLDIR%\bin
;VC2012 PATH=%PATH%;%VCINSTALLDIR%\bin\x86_amd64;%VCINSTALLDIR%\..\Common7\IDE

; ----------------------------------------------------------------------------


; Add the library subdirectories of all VC and Windows SDK versions so things
; just work for users using dmd from the VS 64-bit Command Prompt

; C Runtime libraries
LIB=%LIB%;"%VCINSTALLDIR%\lib\amd64"

; Platform/UCRT libraries (Windows SDK 10.0)
LIB=%LIB%;"%UniversalCRTSdkDir%\Lib\%UCRTVersion%\um\x64"
LIB=%LIB%;"%UniversalCRTSdkDir%\Lib\%UCRTVersion%\ucrt\x64"

; Platform libraries (Windows SDK 8.1)
LIB=%LIB%;"%WindowsSdkDir%\Lib\winv6.3\um\x64"

; Platform libraries (Windows SDK 8)
LIB=%LIB%;"%WindowsSdkDir%\Lib\win8\um\x64"

; Platform libraries (Windows SDK 7 and 6)
LIB=%LIB%;"%WindowsSdkDir%\Lib\x64"

; DirectX (newer versions are included in the Platform SDK but this
; will allow us to support older versions)
LIB=%LIB%;"%DXSDK_DIR%\Lib\x64"


; -----------------------------------------------------------------------------
[Environment32mscoff]
LIB="%@P%\..\lib32mscoff"

; settings very much copied from Environment64, see comments there
; needed to avoid COMDAT folding (bugzilla 10664)
DFLAGS=%DFLAGS% -L/OPT:NOICF

; Windows installer replaces the following lines with the actual paths
VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\
WindowsSdkDir=C:\Program Files (x86)\Windows Kits\8.1\
UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
UCRTVersion=10.0.10240.0

LINKCMD=%VCINSTALLDIR%\bin\link.exe

; needed with /DEBUG to find mspdb*.dll (only for VS2012 or VS2013)
PATH=%PATH%;%VCINSTALLDIR%\bin
;VC2013 PATH=%PATH%;%VCINSTALLDIR%\..\Common7\IDE;%VCINSTALLDIR%\bin
;VC2012 PATH=%PATH%;%VCINSTALLDIR%\..\Common7\IDE

; ----------------------------------------------------------------------------
; Add the library subdirectories of all VC and Windows SDK versions so things
; just work for users using dmd from the VS Command Prompt

; C Runtime libraries
LIB=%LIB%;"%VCINSTALLDIR%\lib"

; Platform/UCRT libraries (Windows SDK 10.0)
LIB=%LIB%;"%UniversalCRTSdkDir%\Lib\%UCRTVersion%\um\x86"
LIB=%LIB%;"%UniversalCRTSdkDir%\Lib\%UCRTVersion%\ucrt\x86"

; Platform libraries (Windows SDK 8.1)
LIB=%LIB%;"%WindowsSdkDir%\Lib\winv6.3\um\x86"

; Platform libraries (Windows SDK 8)
LIB=%LIB%;"%WindowsSdkDir%\Lib\win8\um\x86"

; Platform libraries (Windows SDK 7 and 6)
LIB=%LIB%;"%WindowsSdkDir%\Lib"

; DirectX (newer versions are included in the Platform SDK but this
; will allow us to support older versions)
LIB=%LIB%;"%DXSDK_DIR%\Lib\x86"


