

## Visual Studio CodeのＤ言語拡張機能を使ってみた(Windows)


Visual Studio Code(VSCode) Ｄ言語拡張機能のインテリセンス/オートコンプリートは、とても良い感じです。
EmacsのFlycheckように呼び出し先の関数・変数やテンプレートのコメントが見る事ができます。

![vscode_dlang_intellisense.png](https://github.com/SeijiFujita/quiita_work/blob/master/using_vscode_01/vscode_dlang_intellisense.png)


## 

![vscode_dlang_err.png](https://github.com/SeijiFujita/quiita_work/blob/master/using_vscode_01/vscode_dlang_err.png)

![vscode_dlang_ext.png](https://github.com/SeijiFujita/quiita_work/blob/master/using_vscode_01/vscode_dlang_ext.png)

![vscode_dlang_setting.png](https://github.com/SeijiFujita/quiita_work/blob/master/using_vscode_01/vscode_dlang_setting.png)




"A path in your d.stdlibPath setting doesn't exist."





settings.json
// 既定の設定を上書きするには、このファイル内に設定を挿入します
{
"d.stdlibPath": [
     "C:\\D\\dmd.2.071.2\\src\\druntime\\import",
     "C:\\D\\dmd.2.071.2\\src\\phobos"
    ]
}



tag: dlang,VSCode,Visual Studio Code
filename: template_md
last update: 2015/03/

