# VSCode のタスク機能で dub, dmd (Ｄ言語)を使う

1. ワークスペースの直下に以下の .vscode\tasks.json を配置すると vscode のタスク機能が有効になります
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

- location https://github.com/SeijiFujita/quiita_works/tree/master/using_vscode_03


tag: dlang,VSCode,Visual Studio Code
filename: using_vscode_03.md
last update: 2017/01/23

