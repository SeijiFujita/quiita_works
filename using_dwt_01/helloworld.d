// http://www.dsource.org/projects/dwt-samples
// https://github.com/d-widget-toolkit/org.eclipse.swt.snippets

// http://study-swt.info/foundation/helloSWT.html
// http://cjasmin.fc2web.com/

// http://amateras.sourceforge.jp/cgi-bin/fswiki/wiki.cgi/swt?page=FrontPage


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
