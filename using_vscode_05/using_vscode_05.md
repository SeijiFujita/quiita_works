# VSCode でＤ言語のデバッグ環境を整える(Windows)

Clang でデバッグしていてＤ言語もこんな簡単にデバッグできたら...と、試したところ簡単にデバッグできました。
よく考えると ６４ビット環境はＭＳのツールで作成しているので使えて当たり前？なのかもしれません。


## 必要なツールとデバッグ出来る環境

- VSCode(Visual Studio Code) 本体
- MS-CppTools(MS-vscode-CppTools)
- Native-debug(webfreak.debug)
- D Programing Language code-d (webfreak.code-d) 


### デバッグ可な環境
- windows 64bit(dmd -g -m64)
- windows 32bit mscoff (dmd -g -m32mscoff) 


### デバッグできなかった
- windows 32bit omf (dmd -g -m32) でデバッグをスタートすると、すぐに Exception で落ちてしまいます。


## インストール手順
code-d 以外は特に問題なくインストールできるので拡張機能の画像を張っておきます、code-d のインストールは[こちらを参照してくだい](http://qiita.com/sfujita/items/24c47b68f15d24f0c03e)

- MS-CppTools(MS-vscode-CppTools)

![ms-cpptools.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/ms-cpptools.png)


- Native-debug(webfreak.debug)

![native-debug.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/native-debug.png)


- D Programing Language code-d (webfreak.code-d) 

![code-d.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/code-d.png)


## デバッグの手順

1  インストールが出来たら早速デバッグが開始できます。まずはデバッグするプログラムを用意します(画像は code-d: Create new project -> Basic Console App)、ステータスバーをクリックしてアーキテクチャを X64_86 ビルドタイプ debug に変更しビルド(code-d : Build project)します

![debug-step1.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/debug-step1.png)


2  デバッグの設定ファイル(launch.json)を作るために、コマンドパレットを開き Debug: Open launch.json -> C++(Windows) を選択すると launch.json が作成されます

![debug-step2.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/debug-step2.png)

![debug-step3.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/debug-step3.png)


3  launch.json の "Program" : "${workspaceRoot}/debug-test.exe" をデバッグするプログラムに書き換えます

![debug-step4.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/debug-step4.png)


4 VSCodeのデバッグ(Ctrl+Shift+D)画面を開きます、ソースコードを表示してブレークポイント(赤丸)をマウスで設定します

![debug-step5.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/debug-step5.png)


5 ファンクションキーの F5 でデバッグをスタートさせます。

![debug-step6.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_05/pics/debug-step6.png)


6 以上 / nice debug!



## 関連リンク

- code-d wiki https://github.com/Pure-D/code-d/wiki
- Ｄ言語のエディタ対応状況 http://wiki.dlang.org/Editors

----

- location https://github.com/SeijiFujita/quiita_works/tree/master/using_vscode_05


tag: dlang,VSCode,Visual Studio Code
filename: using_vscode_05.md
last update: 2017/01/29

