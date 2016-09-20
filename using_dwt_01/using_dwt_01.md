#dwtを使ってみた(Windowsインストール編)

難しそうと思って敬遠していた dwtを試してみたら...意外と便利だったという話。

##dwtとは
 D言語用のGUIツールキットです D Widget Toolkit を略して dwt 
単機能なちょっとしたツールを作るには便利そうだし、枯れたシステムなので安定しているだろうと思います。とりあえず以下に情報を列挙してみました。

0. Eclipseで使われている Standard Widget Toolkit(SWT) を D言語でも使えるように移植
0. Eclipseのもっさり感イメージがあるが、dwt は遅くないというか普通に使えます
0. Windows, Linux, Mac のマルチプラットホームでそれぞれのUI環境に特化したライブラリ
0. Windows版は実行時のランタイム(.dll)は不要
0. SWTとソースレベルな互換性？があり、dwt の情報は少ないが SWT の情報を見ればなんとかなる
0. dwt版 の jface など swt の一部は、2011年頃で更新を停止している
0. 32/64bitのアプリケーションが作成可能
0. StyledText()　がバグっている IME を使って漢字入力で落ちる 
0. dwt を使っている人はとっても少なそうだw

##まずはインストール
- dwt本家 https://github.com/d-widget-toolkit/dwt

dwt本家に必要な事は書いてあります、Windowsの場合は基本的に dwtが必要とするライブラリはすべてgitで取得できます。gitをインストールするにはMsys2が便利です。dwtのビルドは rdmd build.d base swt でスムーズに構築できます。
私の使用環境は: Windows7,MinGW,dmd.2066.1,emacs,vi

```console
 $ mkdir /c/D/dwt ; cd /c/D/dwt
 $ git clone --recursive git://github.com/d-widget-toolkit/dwt.git
　...snip
 $ cd dwt
 $ rdmd build.d base swt
 Building dwt-base
 workdir=>c:\D\dwt\dwt\base\src
 Building org.eclipse.swt.win32.win32.x86
 workdir=>c:\D\dwt\dwt\org.eclipse.swt.win32.win32.x86\src
 (in c:\D\dwt\dwt)
 dmd.exe @c:\D\dwt\dwt\rsp
 lib.exe @c:\D\dwt\dwt\rsp > c:\D\dwt\dwt\olog.txt
 dmd.exe @c:\D\dwt\dwt\rsp
 lib.exe @c:\D\dwt\dwt\rsp > c:\D\dwt\dwt\olog.txt

```

###dwt主要なファイルイメージ

```console
c:\D
└dwt
　└dwt
　　├─base
　　├─bin
　　├─imp
　　├─lib
　　├─org.eclipse.swt.snippets
　　├─org.eclipse.swt.win32.win32.x86
　　└─org.eclipse.swt.gtk.linux.x86
```

###gitを使わない場合
 git がない場合は github から zip でダウンロードする事もできまが、ディレクトリの内容が欠けてしまうので個別にダウンロードする必要があります。
まず、本体をzipでダウンロードし展開すると baseディレクトリの内容が存在しないので個別にダウンロードし展開後にそれぞれの位置に移動します。

- 本体 -> https://github.com/d-widget-toolkit/dwt
- dwt\base -> https://github.com/d-widget-toolkit/base
- dwt\org.eclipse.swt.win32.win32.x86 -> https://github.com/d-widget-toolkit/org.eclipse.swt.win32.win32.x86
- dwt\org.eclipse.swt.gtk.linux.x86 -> https://github.com/d-widget-toolkit/org.eclipse.swt.gtk.linux.x86
- dwt\org.eclipse.swt.snippets -> https://github.com/d-widget-toolkit/org.eclipse.swt.win32.win32.x86


###window を出してみる
hello worldを表示するサンプルプログラムです。なお、dwt が必要とするライブラリは多いので、レスポンスファイルを作ると便利です。
まずは、コンパイルは以下な感じです。

```console
$ dmd helloworld.d @dwt_build.txt

```

#### helloworld.d ソースファイル(utf-8で保存)

```d:helloworld.d
// Written in the D programming language.
// dmd 2.066.1
import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Label;

void main()
{
    auto display = new Display;
    auto shell = new Shell(display);
    shell.setText("hello world");
    shell.setLayout(new FillLayout());
    shell.setSize(300, 200);
    auto label = new Label(shell, SWT.NONE);
    label.setText("hello world/はろーわーるど");
    
    shell.open();
    while (!shell.isDisposed) {
        if (!display.readAndDispatch())
            display.sleep();
    }
    display.dispose();
}
```

#### dmdに指定する dwt_build.txt レスポンスファイル
dmd に指定するレスポンスファイルは'#'のコメントが使えます

```dwt_build.txt
#dwt_build.txt
-IC:\D\dwt\dwt\imp
-JC:\D\dwt\dwt\res
-op
#-L/SUBSYSTEM:CONSOLE:4.0
-L/SUBSYSTEM:WINDOWS:4.0
-LC:\D\dwt\dwt\lib\
advapi32.lib
comctl32.lib
comdlg32.lib
gdi32.lib
kernel32.lib
shell32.lib
ole32.lib
oleaut32.lib
olepro32.lib
oleacc.lib
user32.lib
usp10.lib
msimg32.lib
opengl32.lib
shlwapi.lib
dwt-base.lib
org.eclipse.swt.win32.win32.x86.lib

```

### helloworld スクリーンショット
![helloworld.png](https://qiita-image-store.s3.amazonaws.com/0/55585/4f6ccb4a-3bbd-0c8e-22db-4b7c860c92d9.png)

## dwtのサンプルプログラム

 dwtのサンプルプログラムは org.eclipse.swt.snippets ディレクトリにありますので、各種のコントロール/ウィジットなどの使い方を見ることができます。
また、サンプルをコンパイルする場合は 以下を実行すると bin ディレクトリに 実行ファイルが作成されます。

```console
 $ rdmd build.d snippets
```


##dwtを使ってみる

SWTのサンプルアプリを参考にして簡単にdwtのアプリを作る事ができます。http://cjasmin.fc2web.com/samples/buttons.html のいろいろなスタイルのボタンのアプリケーションをD言語で

###いろいろなスタイルのボタン(buttons.d)
![Buttons.png](https://qiita-image-store.s3.amazonaws.com/0/55585/be314532-489d-95b7-7b12-960936212519.png)

```d:buttons.d
// Written in the D programming language.
// buttons.d
// dmd 2.066.1
// ねた元 http://cjasmin.fc2web.com/samples/buttons.html

import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;

enum string WINDOW_TITLE = "Buttons";

class MainForm {
	Display display;
	Shell shell;
	//
	this() {
		// create window
		display = new Display();
		shell = new Shell(display);
		shell.setText(WINDOW_TITLE);
		shell.setLayout(new GridLayout(1, false));
		// contents
		createContents(shell);
		// window packing
		shell.pack();
	}
	void createContents(Composite parent) {
		GridLayout layout = new GridLayout();
		layout.numColumns = 4;
		layout.verticalSpacing = 15;
		parent.setLayout(layout);
		//
		createLabel(parent, SWT.NONE, "Button Type");
		createLabel(parent, SWT.NONE, "NONE");
		createLabel(parent, SWT.NONE, "BORDER");
		createLabel(parent, SWT.NONE, "FLAT");
		//
		createLabel(parent, SWT.NONE, "Push");
		createButton(parent, SWT.PUSH, "button1");
		createButton(parent, SWT.BORDER, "button2");
		createButton(parent, SWT.FLAT, "button3");
		//
		createLabel(parent, SWT.NONE, "Radio");
		createButton(parent, SWT.RADIO, "button1");
		createButton(parent, SWT.RADIO | SWT.BORDER, "button2");
		createButton(parent, SWT.RADIO | SWT.FLAT, "button3");
		//
		createLabel(parent, SWT.NONE, "Toggle");
		createButton(parent, SWT.TOGGLE, "button1");
		createButton(parent, SWT.TOGGLE | SWT.BORDER, "button2");
		createButton(parent, SWT.TOGGLE | SWT.FLAT, "button3");
		//
		createLabel(parent, SWT.NONE, "Check");
		createButton(parent, SWT.CHECK, "button1");
		createButton(parent, SWT.CHECK | SWT.BORDER, "button2");
		createButton(parent, SWT.CHECK | SWT.FLAT, "button3");
		//
		createLabel(parent, SWT.NONE, "Arrow | Right");
		createButton(parent, SWT.ARROW | SWT.RIGHT, "button1");
		createButton(parent, SWT.ARROW | SWT.RIGHT | SWT.BORDER, "button2");
		createButton(parent, SWT.ARROW | SWT.RIGHT | SWT.FLAT, "button3");
		//
		createLabel(parent, SWT.NONE, "Arrow | Left");
		createButton(parent, SWT.ARROW | SWT.LEFT, "button1");
		createButton(parent, SWT.ARROW | SWT.LEFT | SWT.BORDER, "button2");
		createButton(parent, SWT.ARROW | SWT.LEFT | SWT.FLAT, "button3");
		//
		createLabel(parent, SWT.NONE, "Arrow | UP");
		createButton(parent, SWT.ARROW | SWT.UP, "button1");
		createButton(parent, SWT.ARROW | SWT.UP | SWT.BORDER, "button2");
		createButton(parent, SWT.ARROW | SWT.UP | SWT.FLAT, "button3");
		//
		createLabel(parent, SWT.NONE, "Arrow | DOWN");
		createButton(parent, SWT.ARROW | SWT.DOWN, "button1");
		createButton(parent, SWT.ARROW | SWT.DOWN | SWT.BORDER, "button2");
		createButton(parent, SWT.ARROW | SWT.DOWN | SWT.FLAT, "button3");
	}
	void createButton(Composite c, int style, string text) {
		Button b = new Button(c, style);
		b.setText(text);
	}
	void createLabel(Composite c, int style, string text) {
		Label l = new Label(c, style);
		l.setText(text);
	}
	void run() {
		shell.open();
		while(!shell.isDisposed()) {
			if (!display.readAndDispatch())
				display.sleep();
		}
		display.dispose();
	}
}

void main() {
	auto main = new MainForm;
	main.run();
}
```

##参考になるサイト

0. 本家 https://github.com/d-widget-toolkit/dwt
0. SWT本家 https://www.eclipse.org/swt/
0. SWT Widgets https://www.eclipse.org/swt/widgets/
0. SWT tips & samples http://cjasmin.fc2web.com/ 
0. SWT - JavaでGUIプログラミング http://study-swt.info/index.html
0. SWT http://www.java2s.com/Code/Java/SWT-JFace-Eclipse/CatalogSWT-JFace-Eclipse.htm
0. SWT http://www.java2s.com/Code/JavaAPI/org.eclipse.swt.widgets/Catalogorg.eclipse.swt.widgets.htm
0. SWT http://www.java2s.com/Tutorial/Java/0280__SWT/Catalog0280__SWT.htm


##おわりに
D言語, dwt, 誤字, 間違い、などなど色々と初心者なのでツッコミがありましたらよろしくお願いします。

-------
-location https://github.com/SeijiFujita/quiita_works/tree/master/using_dwt_01

tag: dwt,dlang,SWT
filename: using_dwt_01.md
last update: 2016/09/20




