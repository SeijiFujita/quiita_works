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

class Buttons {
}

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
