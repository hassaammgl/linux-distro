// Basic Node.js + Qt (NodeGui) window
const { QMainWindow, QWidget, QLabel, QPushButton, FlexLayout } = require("@nodegui/nodegui");

const win = new QMainWindow();
win.setWindowTitle("rat nodeqt");
win.resize(360, 200);

const root = new QWidget();
root.setObjectName("root");
const layout = new FlexLayout();
root.setLayout(layout);

const label = new QLabel();
label.setText("Hello from Node.js + Qt");
label.setInlineStyle("font-size: 18px; color: #89b4fa;");

const btn = new QPushButton();
btn.setText("Click me");
btn.addEventListener("clicked", () => label.setText("clicked!"));

layout.addWidget(label);
layout.addWidget(btn);
win.setCentralWidget(root);

win.setStyleSheet(`
  #root {
    background-color: #1e1e2e;
    padding: 16px;
  }
`);

win.show();
global.win = win; // prevent GC
