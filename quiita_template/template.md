##タイトル　dwtを使ってみた(アプリケーション編)

現在のdwt には JFace[^1] がないので _GUI_ ツール ~~キット~~ としては寂しいですが
少しでも補うことができればよいと思います。


[^1]: http://ja.wikipedia.org/wiki/JFace

##タイトル２
モジュールをインストールするには #import  \<module\> を使います


 1. 番号
 1. 番号
 1. 番号




- 以下はhello.d ソースコード

*以下はhello.d ソースコード

```d:helloworld.d
import std.stdio;

int main()
{
	writeln("hello world");
}

```


![VisualStadioComm2015_setup.png](https://https://github.com/SeijiFujita/quiita_work/blob/master/using_m64/VisualStadioComm2015_setup.png)


##参考サイト

0. 本家 https://github.com/d-widget-toolkit/dwt
0. SWT本家 https://www.eclipse.org/swt/
0. SWT Widgets https://www.eclipse.org/swt/widgets/
0. SWT tips & samples http://cjasmin.fc2web.com/ 
0. SWT - JavaでGUIプログラミング http://study-swt.info/index.html

##おわりに
D言語, dwt, 誤字, 間違い、などなど色々と初心者なのでツッコミがありましたらよろしくお願いします。

tag: dwt,dlang,SWT
filename: template_md
last update: 2015/03/


