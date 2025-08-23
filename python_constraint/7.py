#Napisati program koji raspoređuje 8 dama na šahovsku tablu tako da se nikoje
#dve dame ne napadaju.
#Sve rezultate ispisati na standardni izlaz koristeći datu komandu ispisa.

import constraint
import math

problem = constraint.Problem()

problem.addVariables('12345678', range(0, 9))
problem.addConstraint(constraint.AllDifferentConstraint()) # i != j -> xi != xj

for k1 in range(1, 9):
    for k2 in range(1, 9):
        if k1 < k2: #isti par se ne razmatra 2 puta
            def diagonal(v1, v2, k1 = k1, k2 = k2):
                if math.fabs(v1 - v2) != math.fabs(k1 - k2):
                    return True
            problem.addConstraint(diagonal, [str(k1), str(k2)])


resenja = problem.getSolutions()
print("Broj resenja je: {0:d}.".format(len(resenja)))
for r in resenja:
    print("+++++++++++")
    for i in "12345678":
        for j in range (1,9):
            if r[i] == j:
                print("D", end='')
            else:
                    print("-", end='')
        print(" ")
    print("+++++++++++")
