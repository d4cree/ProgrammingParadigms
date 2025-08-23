import sys
import os
import ui_calculator
import re
import PyQt5
from PyQt5 import QtWidgets, QtCore, QtGui
from PyQt5.QtWidgets import QFileDialog, QMessageBox

class CalculatorClass(ui_calculator.Ui_MainWindow, QtWidgets.QMainWindow):
    def __init__(self):
        super(CalculatorClass, self).__init__()
        self.setupUi(self)

        #Brojevi
        self.pushButton_0.clicked.connect(lambda: self.display_screen('0'))
        self.pushButton_1.clicked.connect(lambda: self.display_screen('1'))
        self.pushButton_2.clicked.connect(lambda: self.display_screen('2'))
        self.pushButton_3.clicked.connect(lambda: self.display_screen('3'))
        self.pushButton_4.clicked.connect(lambda: self.display_screen('4'))
        self.pushButton_5.clicked.connect(lambda: self.display_screen('5'))
        self.pushButton_6.clicked.connect(lambda: self.display_screen('6'))
        self.pushButton_7.clicked.connect(lambda: self.display_screen('7'))
        self.pushButton_8.clicked.connect(lambda: self.display_screen('8'))
        self.pushButton_9.clicked.connect(lambda: self.display_screen('9'))

        #Operatori
        self.pushButton_plus.clicked.connect(lambda: self.display_opp('+'))
        self.pushButton_minus.clicked.connect(lambda: self.display_opp('-'))
        self.pushButton_prod.clicked.connect(lambda: self.display_opp('*'))
        self.pushButton_div.clicked.connect(lambda: self.display_opp('/'))
        self.pushButton_proc.clicked.connect(lambda: self.display_opp('%'))

        #Delete
        self.pushButton_Del.clicked.connect(lambda: self.lineEdit.backspace())
        self.pushButton_C.clicked.connect(lambda: self.lineEdit.clear())

        #Eq
        self.pushButton_eq.clicked.connect(lambda: self.calculate())
    
    def display_screen(self, input):
        self.lineEdit.insert(input)
    
    def display_opp(self, input):
        text = self.lineEdit.text()
        if len(text) > 0 and text[-1] not in ['+', '-', '*', '/', '%']:
            self.lineEdit.insert(input)

    def calculate(self):
        data = self.lineEdit.text()
        operands = re.split('\+|\-', data)
        operators = list(filter(lambda c: c in ['+', '-'], data))
        assert len(operators) + 1 == len(operands)
        operands = list(map(lambda ex: self.evaluate(ex), operands))

        result = int(operands[0])
        for i in range(0, len(operators)):
            nextOperand = operands[i+1]
            nextOperator = operators[i]

            if nextOperator == '+':
                result += int(nextOperand)
            else:
                result -= int(nextOperand)

        self.lineEdit.setText(str(result))

    def evaluate(self, data):
        operands = re.split('\*|/|%', data)
        if len(operands) == 1:
            return data
        operators = list(filter(lambda c: c in ['*', '/', '%'], data))
        assert len(operators) + 1 == len(operands)

        result = int(operands[0])
        for i in range(0, len(operators)):
            nextOperand = operands[i+1]
            nextOperator = operators[i]

            if nextOperator == '*':
                result *= int(nextOperand)
            elif nextOperator == '/':
                result = int(result/float(nextOperand))
            else:
                result = int(result%float(nextOperand))
        return result  


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    calculator = CalculatorClass()
    calculator.show()
    sys.exit(app.exec_())