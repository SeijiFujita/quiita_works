# Visual Studio Code(VSCode)のＤ言語拡張機能を使ってみた(Windows)

Visual Studio Code(VSCode) の初心者がＤ言語拡張機能(webfreak.code-d)を試してみました。


## 注意点

- Ｄ言語拡張機能(webfreak.code-d) はまだまだ作成中(2016/11/03 現在)
- インテリセンス/オートコンプリートは、ほぼ完成の域？に達しています素晴らしいです
- Emacs の FlyCheck のようにコンパイルせずにエラーや警告を示します
- マウスカーソルで関数や変数を指定するとエラーメッセージや関数定義のコメント行を見ることができる
- dub サポートなど(Build関係)は作成中？動く機能と動かない機能がある
- ~~コンパイル/ビルド時にエラーのジャンプができない(タクスランナーで補えるので方法を紹介)~~
- コンパイル/ビルド時にエラーのジャンプができる事を確認(code-d version 0.14.1)
- Ｄ言語拡張機能(webfreak.code-d) を動かすまでにツールのビルドに試行錯誤した
- 動作環境は Window10 で確認

## 実際の動作はこんな感じです
![vscode_dlang_intellisense.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_01/vscode_dlang_intellisense.png)

## VSCode + Ｄ言語拡張機能(webfreak.code-d)インストール

Ｄ言語拡張機能の動作イメージは、workspace-d は code-d の要求にしたがって各種機能(dcd, dscanner, dfmt, dub)を呼び出します。

### インストールに必要なもの

1. VSCode 本体 
1. Ｄ言語拡張機能(webfreak.code-d)
1. workspace-d 以下の dcd,dscanner,dfmt,dub をコントロール　
1. dcd - オートコンプリート・コードナビゲート
1. dscanner シンタックスチェック
1. dfmt ソースコードフォマッター
1. ツールとして git, dub, dmd が必要


### VSCode のインストール 

VSCode 本体のダウンロード/インストールなど基本的な使い方は以下が便利です。

1. VSCode Download https://code.visualstudio.com/Download 
1. VSCode 基本的な使い方 http://www.atmarkit.co.jp/ait/articles/1507/10/news028.html

### Ｄ言語拡張機能のインストール 

拡張機能を dlang で検索すると Ｄ言語拡張機能は２つありますので、D Programming Language(code-d) をインストールしてください。
code-d インストール後　workspace-d.exe が無いとメッセージがでますが気にせず 一旦、VSCcode を終了し
つぎの "workspace-d 側のインストール"に進んでください。

Ｄ言語拡張機能は D Programming Language(code-d) を選択
![vscode_dlang_ext.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_01/vscode_dlang_ext.png)


### workspace-d 側のインストール

以下のプログラムをビルド後に各.exeをディレクトリにまとめPATHを通してください。
Build.bat に手順をまとめました workspace-d.exe は 64bit でコンパイルしてください、32bit だと動きませんでした。

1. workspace-d  https://github.com/Pure-D/workspace-d#workspace-d
1. dcd - auto completion https://github.com/Hackerpilot/DCD
1. dscanner - dlang code linting https://github.com/Hackerpilot/Dscanner
1. 必須ではないが非常に便利です。dfmt - dlang code formatting https://github.com/Hackerpilot/dfmt


```bat:Build.bat

git clone https://github.com/Pure-D/workspace-d.git
git clone https://github.com/Hackerpilot/DCD.git
git clone https://github.com/Hackerpilot/Dscanner.git
git clone https://github.com/Hackerpilot/dfmt.git
rem git clone --recursive https://github.com/Hackerpilot/Dscanner.git
rem git clone --recursive https://github.com/Hackerpilot/dfmt.git

mkdir bin

pushd workspace-d
rem dub build --compiler=ldc2 --arch=x86_64 --combined --build=release
dub build --compiler=dmd  --arch=x86_64 --combined --build=release
copy workspace-d.exe ..\bin
popd

rem goto :eof

pushd DCD
dub build --combined --arch=x86_64 --build=release --config=client
dub build --combined --arch=x86_64 --build=release --config=server
copy dcd-client.exe ..\bin
copy dcd-server.exe ..\bin
popd

rem goto :eof

pushd Dscanner
dub build --compiler=dmd  --arch=x86_64 --combined --build=release
copy dscanner.exe ..\bin
rem call build.bat
rem libdparse　のエラーが出たら
rem dub.json: "libdparse": "0.7.0-beta.2", -> "libdparse": "0.7.0-beta.1",
popd

rem goto :eof

pushd dfmt
dub build --compiler=dmd  --arch=x86_64 --combined --build=release
copy dscanner.exe ..\bin
rem call build.bat
popd

pause

```

### Ｄ言語拡張機能の動作確認と設定


VSCode を起動し、Ｄ言語のソースコードの編集をすると d.stdlibPath に druntime,phobos パスを要求されるので以下のように設定


![vscode_dlang_setting.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_01/vscode_dlang_setting.png)


```json:settings.json

// settings.json
// 既定の設定を上書きするには、このファイル内に設定を挿入します
{
    "d.stdlibPath": [
        "C:\\D\\dmd.2071.2\\src\\druntime\\import",
        "C:\\D\\dmd.2071.2\\src\\phobos"
    ]
}

```

## VSCode のタスク機能で dub, dmd のエラーメッセージでソースコード行に移動する方法

1. ワークスペースに直下に .vscode\tasks.json を配置すると vscode のタスク機能が有効になります
1. ctrl+shift+b で　dub を実行しエラーメッセージを取り込みます。
1. VSCode のタスク機能の内容は以下を参照してください。

- http://www.atmarkit.co.jp/ait/articles/1509/08/news019.html
- https://code.visualstudio.com/Docs/editor/tasks


```json:tasks.json
// .vscode/tasks.json
{
    "version": "0.1.0",
    "command": "cmd",
    "args": ["/c"],
    "isShellCommand": true,
    "echoCommand": true,
    "showOutput": "always",
    "tasks": [
        {
            "taskName": "dub build",
            // ctrl+shift+t
            // "isTestCommand": true,
            // ctrl+shift+b
            "isBuildCommand": true,
            "suppressTaskName": true,
            "args": ["dub", "build"],
            "problemMatcher": {
                "owner": "dub",
                "fileLocation": ["relative", "${workspaceRoot}"],
                "pattern":
                {
                    // The regular expression. Example to match:
                    //source\app.d(36,2): Error: undefined identifier 'riteln', did you mean template 'writeln(T...)(T args)'?
                    "regexp": "^(.*)\\((\\d+),(\\d+)\\):\\s+(Error|Warning):\\s+(.*)$",
                    // The first match group matches the file name which is relative.
                    "file": 1,
                    // The second match group matches the line on which the problem occurred.
                    "line": 2,
                    // The third match group matches the column at which the problem occurred.
                    "column": 3,
                    // The fourth match group matches the problem's severity. Can be ignored. Then all problems are captured as errors.
                    "severity": 4,
                    // The fifth match group matches the message.
                    "message": 5
                }
            }
        },
        {
            "taskName": "dmd @Respons",
            // "isBuildCommand": true,
            // "isTestCommand": true,
            "suppressTaskName": true,
            "args": ["dmd", "@Respons.txt"],
            "problemMatcher": {
                "owner": "dmd",
                "fileLocation": ["relative", "${workspaceRoot}"],
                "pattern":
                {
                    // The regular expression. Example to match:
                    //hello.d(26): Error: undefined identifier 'at', did you mean function 'cat'?
                    "regexp": "^(.*)\\((\\d+)\\):\\s+(Error|Warning):\\s+(.*)$",
                    // The first match group matches the file name which is relative.
                    "file": 1,
                    // The second match group matches the line on which the problem occurred.
                    "line": 2,
                    // The third match group matches the column at which the problem occurred.
                    // "column": 3,
                    // The fourth match group matches the problem's severity. Can be ignored. Then all problems are captured as errors.
                    "severity": 3,
                    // The fifth match group matches the message.
                    "message": 4
                }
            }
        },
        {
            "taskName": "dmd-unittest",
            "isBuildCommand": false,
            "suppressTaskName": true,
            "args": ["dmd", "-unittest", "${file}"],
            "problemMatcher": {
                "owner": "dmd",
                "fileLocation": ["relative", "${workspaceRoot}"],
                "pattern":
                {
                    // The regular expression. Example to match:
                    //hello.d(26): Error: undefined identifier 'at', did you mean function 'cat'?
                    "regexp": "^(.*)\\((\\d+)\\):\\s+(Error|Warning):\\s+(.*)$",
                    // The first match group matches the file name which is relative.
                    "file": 1,
                    // The second match group matches the line on which the problem occurred.
                    "line": 2,
                    // The third match group matches the column at which the problem occurred.
                    // "column": 3,
                    // The fourth match group matches the problem's severity. Can be ignored. Then all problems are captured as errors.
                    "severity": 3,
                    // The fifth match group matches the message.
                    "message": 4
                }
            }
        },
        {
            "taskName": "make",
            "suppressTaskName": true,
            "args": ["make"]
        }
//--------------------------------------
    ]
}

```


## 関連リンク

- Ｄ言語のエディタ対応状況 http://wiki.dlang.org/Editors

----

- location https://github.com/SeijiFujita/quiita_works/tree/master/using_vscode_01


tag: dlang,VSCode,Visual Studio Code
filename: using_vscode_01.md
last update: 2016/11/08

