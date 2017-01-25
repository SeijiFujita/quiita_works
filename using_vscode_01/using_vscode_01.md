# Visual Studio Code(VSCode)のＤ言語拡張機能(code-d)を使ってみた(Windows)

Visual Studio Code(VSCode) の初心者がＤ言語拡張機能(code-d)を試してみました。

この記事を更新しました。(2017/01/23 現在)

## Topics

- Ｄ言語拡張機能(code-d ver 1.16.0) の状態のレポートです(2017/01/23 現在)
- インテリセンス/オートコンプリートは、ほぼ完成の域に達しています素晴らしいです
- Emacs の FlyCheck のようにコンパイルせずにエラーや警告を示します
- マウスカーソルで関数や変数を指定するとエラーメッセージや関数定義のコメント行を見ることができる
- code-d: Create new Projectなど問題なく使える
- import 文の追加の支援機能がおもしろい(code-d version 0.16.0)
- コンパイルエラーがなくなると自動的にビルドします(code-d version 0.16.0)
- 動作環境は Window10 で確認/他の環境でも問題はなさそうです(作者はWindows 環境を持っていないかも？)
- さらに詳しい話は code-d home  https://github.com/Pure-D/code-d/wiki

## 実際の動作はこんな感じです
![vscode_dlang_intellisense.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_01/vscode_dlang_intellisense.png)

## Ｄ言語拡張機能(code-d)インストール


### インストールに必要なもの

- VSCode 本体
- Ｄ言語拡張機能(code-d)
- workspace-d 以下の dcd,dscanner,dfmt,dub をコントロール　
- dcd - オートコンプリート・コードナビゲート
- dscanner シンタックスチェック
- dfmt ソースコードフォマッタ
- 以上をビルドするツールとして git, dub, dmd, ldc2 が必要です


### インストールを行う順番 

1. 各種ツールをビルドしPATHを通す
1. VScode がインストールされていない場合はインストール
1. VSCode の拡張機能で dlang を検索し "D Programing Language(code-d)" をインストールまたはアップデートを行う
1. VSCode メニューの ファイル -> 基本設定 -> ユーザ設定 ->  D configration で設定を行う
1. 拡張機能を初めてインストールする場合は、D言語の標準ライブラリ(phobos,)


### 各種ツールをビルドしPATHを通す

- Ｄ言語拡張機能(code-d)のアップデート 

### VSCode のインストール 

VSCode 本体のダウンロード/インストール、基本的な使い方を読んで理解を深めましょう。

1. VSCode Download https://code.visualstudio.com/Download 
1. VSCode 基本的な使い方 http://www.atmarkit.co.jp/ait/articles/1507/10/news028.html


### Ｄ言語拡張機能のインストール 

VSCodeを起動し拡張機能で "dlang" で検索、 Ｄ言語拡張機能は２つありますので、D Programming Language(code-d) をインストール  

Ｄ言語拡張機能は D Programming Language(code-d) を選択


![vscode_dlang_ext.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_01/vscode_dlang_ext.png)


### Ｄ言語拡張機能の動作確認と設定

拡張機能の d.stdlibPath が正しく設定されていない場合は要求されるので、dmdの標準ライブラリのPATHを以下のように設定

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
  
![vscode_dlang_setting.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_01/vscode_dlang_setting.png)



以上、バリバリコードを書きましょう！

## 関連リンク

- Ｄ言語のエディタ対応状況 http://wiki.dlang.org/Editors

----

- location https://github.com/SeijiFujita/quiita_works/tree/master/using_vscode_01


tag: dlang,VSCode,Visual Studio Code
filename: using_vscode_01.md
last update: 2017/01/25

