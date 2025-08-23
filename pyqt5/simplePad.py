import ui_simplePad
import PyQt5 
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QFileDialog, QMessageBox
import sys
import os

class SimplePadClass(ui_simplePad.Ui_MainWindow, QtWidgets.QMainWindow):
    def __init__(self):
        super(SimplePadClass, self).__init__()
        self.setupUi(self)

        self.path = None

        self.actionOpen.triggered.connect(lambda: self.Open())
        self.actionSave_As.triggered.connect(lambda: self.SaveAs())
        self.actionSave.triggered.connect(lambda: self.Save())

    def __save_util(self, path):
        data = self.plainTextEdit.toPlainText()
        try:
            with open(path, 'w') as f:
                f.write(data)
        except Exception as e:
            self.__dialog(str(e))
        else:
            self.path = path
            self.__title()

    def __dialog(self, msg):
        box = QMessageBox(self)
        box.setText(msg)
        box.show()


    def __title(self):
        self.setWindowTitle(f'{os.path.basename(self.path)} - SimplePad' if self.path else 'Untitled')


    def Open(self):
        #self.__dialog("Hi :3")
        path, _ = QFileDialog.getOpenFileName(self, "Open file", "", 'All files (*.*)')
        if path:
            try:
                with open(path, 'r') as f:
                    data= f.read()
            except Exception as e:
                self.__dialog(str(e))
            else:
                self.plainTextEdit.setPlainText(data)
                self.path = path
                self.__title()

    def SaveAs(self):
        path, _ = QFileDialog.getSaveFileName(self, "Save file", "", 'All files (*.*)')
        if not path:
            return
        self.__save_util(path)

    def Save(self):
        if self.path is None:
            return self.SaveAs()
        
        self.__save_util(self.path)
        


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    simplePad = SimplePadClass()
    simplePad.show()
    sys.exit(app.exec_())