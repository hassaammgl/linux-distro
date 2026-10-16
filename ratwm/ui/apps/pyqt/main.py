#!/usr/bin/env python3
"""Basic Python + Qt (PySide6) window."""

import sys
from PySide6.QtWidgets import QApplication, QLabel, QVBoxLayout, QWidget, QPushButton
from PySide6.QtCore import Qt


def main():
    app = QApplication(sys.argv)

    win = QWidget()
    win.setWindowTitle("rat pyqt")
    win.resize(360, 200)
    win.setStyleSheet("background: #1e1e2e; color: #cdd6f4;")

    label = QLabel("Hello from Python + Qt")
    label.setAlignment(Qt.AlignCenter)
    label.setStyleSheet("font-size: 20px; color: #89b4fa;")

    btn = QPushButton("Click me")
    btn.setStyleSheet("padding: 8px; background: #313244; color: #cdd6f4; border-radius: 6px;")
    btn.clicked.connect(lambda: label.setText("clicked!"))

    layout = QVBoxLayout(win)
    layout.addWidget(label)
    layout.addWidget(btn)

    win.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
