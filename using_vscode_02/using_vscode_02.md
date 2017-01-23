# Ｄ言語拡張機能(code-d)のアップデート(Windows)

code-d 0.16.0 + workspace-d 2.10.0 released (2017/1/22)されたので試してみました。

新規にVSCodeからインストールする場合は[ここを参照](http://qiita.com/sfujita/items/24c47b68f15d24f0c03e)


## Topics

- import 文の追加支援機能がおもしろい(Auto-Fix for issues like missing imports)
- コンパイルエラーがなくなると自動的にビルドします

![vscode_auto_import_fix.gif](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_02/pics/vscode_auto_import_fix.gif)



## Ｄ言語拡張機能のインストールとアップデート
初めてインストールする場合もツール類を実行できる環境を作った後に VSCode の拡張機能のインストールを行うことでスムーズに
インストールできると思います。

0. 各種ツールをビルドしPATHを通す
0. VSCode の拡張機能で dlang を検索し "D Programing Language(code-d)" をインストールまたはアップデートを行う
0. VSCode メニューの ファイル -> 基本設定 -> ユーザ設定 ->  D configration
0. 以上でインストール・アップデートは終了



## 各種ツールをビルドしPATHを通す
ビルドするには git, dmd, ldc2 が必要です。なお、workspace-d は ldc2 でコンパイルするようにassertされています。

- workspace-d  https://github.com/Pure-D/workspace-d
- DCD  https://github.com/Hackerpilot/DCD
- dfmt  https://github.com/Hackerpilot/dfmt.git
- Dscanner  https://github.com/Hackerpilot/Dscanner

以下の Build.bat で git clone ->　コンパイル -> できたバイナリを　Binディレクトリに集めるので PATH を通してください。

```bat:Build.bat

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
```

----

- location https://github.com/SeijiFujita/quiita_works/tree/master/using_vscode_02


tag: dlang,VSCode,Visual Studio Code
filename: using_vscode_02.md
last update: 2017/01/23

