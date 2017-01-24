# Ｄ言語拡張機能(code-d) の機能一覧


## code-d: Build project

　dub build を実行します。

## code-d: Create new Project

　新しプロジェクトを作成します。以下のプロジェクトを作成することができます。

- ConsoleApp
- DlangUIapp
- GtkDapp
- OpenGLapp(sdl2/OpenGL)
- WebServer
- Win32app
- X11app


## code-d: Debug project using code-debug

?

## code-d: Generate coverage report
## code-d: Insert default dscanner.ini content
## code-d: Kill DCD Server
## code-d: Reload import paths
## code-d: Restart DCD Server
## code-d: Run project
## code-d: Show GC calls from profilegc.log
## code-d: Stop project
## code-d: Switch Configuration
## code-d: Switch Arch Type
## code-d: Switch Build Type
## code-d: Switch Compiler
## code-d: Upload selection to dpaste.com
## code-d/dub: Open project settings
## code-d/dub: Close project settings


## dfmt (ソースコードフォーマッタ)

- https://github.com/Hackerpilot/dfmt

ソースコードウィドウでマウスの右ボタンをクリックし"ドキュメントフォマット(Alt+Shift+f)"を選択

![dcode-dfmt.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_04/pics/dcode-dfmt.png)

dfmt.maxLineLength = 120;
dfmt.softMaxLineLength = 80;



## rdmd (Ｄソースコードの実行)

- https://dlang.org/rdmd.html

ファイル一覧表示で実行目的のソースコードを選択後マウスの右ボタンをクリックし"Run Document using rdmd"を選択

![dcode-rdmd.png](https://raw.githubusercontent.com/SeijiFujita/quiita_works/master/using_vscode_04/pics/dcode-rdmd.png)

## code-d の対応言語

| Name            |ファイル拡張子  |
|:----------------|:--------------|
| D言語 | .d .di | |
| arsd.Dscript | .ds .dscript |
| DlangUI Markup Languge | .dml |
| Simple Declarative Language | .sdl
| Diet | .dt



## D Configuration setting.json

| Name            | Default      | Description     |
|:----------------|:-------------|:----------------|
|d.workspacedPath | workspace-d | workspace-d のパスを設定します、環境変数PATHに設定されている場合は省略できます / Path of the workspace-d executable. Path can be omitted if in $PATH or installed using code-d |
|d.dcdClientPath  | dcd-client  | dcd-client のパスを設定します、環境変数PATHに設定されている場合は省略できます / Path of the dcd-client executable. Path can be omitted if in $PATH or installed using code-d |
|d.dcdServerPath  | dcd-server  | dcd-server のパスを設定します、環境変数PATHに設定されている場合は省略できます / Path of the dcd-server executable. Path can be omitted if in $PATH or installed using code-d |
|d.dscannerPath   | dscanner    | dscanner のパスを設定します、環境変数PATHに設定されている場合は省略できます / Path of the dscanner executable. Path can be omitted if in $PATH or installed using code-d |
|d.dfmtPath       | dfmt        | dfmt のパスを設定します、環境変数PATHに設定されている場合は省略できます / Path of the dfmt executable. Path can be omitted if in $PATH or installed using code-d
|d.dubPath        | dub         | dub のパスを設定します、環境変数PATHに設定されている場合は省略できます / Path of the dub executable. Path can be omitted if in $PATH or installed using code-d
|d.stdlibPath     | null        | 標準ライブラリのフルパスを指定します、指定指定しない場合はオートコンプレート・インポート入力支援は動作できません。 / Array of paths to phobos and D runtime for automatic inclusion for auto completion |
|d.enableLinting  | true        | 構文チェック(Linting)を有効にします / If code-d should watch for file saves and report static analysis. Might interfere with other lint plugins or settings.
|d.enableSDLLinting | true      | dub.sdl のエラーレポートを有効にします / If code-d should report errors in your dub.sdl file.
|d.enableDubLinting | true      | dub.json のエラーレポートを有効にします / If code-d should build on save to check for compile errors.
|d.enableAutoComplete | true    | オートコンプレートを有効にします / dcd-serverを起動し、dcd-clientを使用して完了します。 / Start dcd-server at startup and complete using dcd-client.
|d.neverUseDub | false | If this is true then a custom workspace where you manually provide the import paths will always be used instead of dub. See d.projectImportPaths for setting import paths then. This is discouraged as it will remove most features like packages, building & compiler linting. If this is a standalone project with no external dependencies with a custom build system then this should be true. |
|d.projectImportPaths | [] | Setting for import paths in your workspace if not using dub. This will replace other paths. Its recommended to set this in your workspace settings instead of your user settings to keep it separate for each project. |
|d.dubConfiguration   |    | dub のデフォルトを設定します/ Sets the default configuration to use when starting up |
|d.dubArchType  | | dub のビルドアーキテクチャタイプを設定します / Sets the default arch type to use when starting up |
|d.dubBuildType | | dub のビルドタイプを指定します / Sets the default build type to use when starting up |
|d.dubCompiler  | | dub のコンパイラを指定します / Sets the default compiler to use when starting up |
|d.disableWorkspaceD | false | code-d の機能を無効にします debug用 / Disables most code-d features. Intended for debugging/working on new features with lots of vscode restarts |
|d.overrideDfmtEditorconfig | true | dfmt の設定をvscodeの設定で上書きします(maxLineLength,softMaxLineLength) / Uses dfmt config options & vscode editor config instead of .editorconfig because dfmt seems to be quite buggy with them. |
|dfmt.alignSwitchStatements | true | dfmt はまだ未実装です / Not yet implemented (on dfmt side) |
|dfmt.braceStyle  |allman | ブレススタイルを選択します[allman, otbs, stroustrup] 詳しくは https://en.wikipedia.org/wiki/Brace_style // See Wikipedia https://en.wikipedia.org/wiki/Brace_style |
|dfmt.outdentAttributes | true | dfmt はまだ未実装です / Not yet implemented (on dfmt side) |
|dfmt.spaceAfterCast | true | cast(type)式 のあとにスペースを入れます / Insert space after the closing paren of a cast expression. |
|dfmt.splitOperatorAtLineEnd | false | 行の分割するときは、前の行に最後に演算子を配置します / Place operators on the end of the previous line when splitting lines. |
|dfmt.selectiveImportSpace | true | 選択的インポート文のセパレータ(:)にスベースを挿入します / Insert space after the module name and before the : for selective imports. |
|dfmt.compactLabeledStatements | true | switch, for, foreach, while文と同じラインにラベルを配置します / Place labels on the same line as the labeled switch, for, foreach, or while statement. |
|dfmt.templateConstraintStyle |conditional_newline_indent | template がラインサイズ(80)を超えた場合のフォーマットの動作を指定します / Control the formatting of template constraints.|

- 英訳文は意訳です、注意してください、歪曲していたらご指摘ください。


## 関連リンク

- code-d wiki https://github.com/Pure-D/code-d/wiki
- Ｄ言語のエディタ対応状況 http://wiki.dlang.org/Editors

----

- location https://github.com/SeijiFujita/quiita_works/tree/master/using_vscode_03


tag: dlang,VSCode,Visual Studio Code
filename: using_vscode_03.md
last update: 2017/01/23

