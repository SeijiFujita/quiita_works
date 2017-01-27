# VSCode のＤ言語のデバック環境を整える(Windows)

Clang でデバックしていてＤ言語もこんな簡単にデバックできたら...と、試したところ簡単にデバックできました。
よく考えると ６４ビット環境はＭＳのツールで作成しているので使えて当たり前？なのかもしれません。
なお、３２ビット環境のデバッグは色々試していますが成功していません、３２ビット

## 必要なもの

- VSCode(Visual Studio Code) 本体
- D Programing Language code-d (webfreak.code-d) 
- Native-debug(webfreak.debug)
- MS-CppTools(MS-vscode-CppTools)

## インストール
code-d 以外は特に問題なくインストールできるので拡張機能の画像を張っておきます、code-d のインストールは[こちらを参照してくだい]()

ms-cpptools.png
native-debug.png
code-d.png

## デバックの手順

1. デバックするプログラムを用意します(画像は code-d: Create new project -> Basic Console App)
2. ステータスバーをクリックしてアーキテクチャを X64_86 ビルドタイプ debug に変更しビルド(code-d : Build project)します

debug-step1.png

3. デバッグの設定ファイル(launch.json)を作るために、コマンドパレットを開き Debug: Open launch.json -> C++(Windows) を選択

debug-step2.png
debug-step3.png

4. launch.json の "Program" : "${workspaceRoot}/debug-test.exe" をデバッグするプログラムに書き換えます

debug-step4.png

5. VSCodeのデバッグ(Ctrl+Shift+D)画面を開きます、ソースコードを表示してブレークポイント(画像の赤丸)をマウスで設定します

debug-step5.png

6. ファンクションキーの F5 でデバックをスタートさせます。

debug-step6.png


7. 以上



## 関連リンク

- code-d wiki https://github.com/Pure-D/code-d/wiki
- Ｄ言語のエディタ対応状況 http://wiki.dlang.org/Editors

----

- location https://github.com/SeijiFujita/quiita_works/tree/master/using_vscode_05


tag: dlang,VSCode,Visual Studio Code
filename: using_vscode_05.md
last update: 2017/01/27

