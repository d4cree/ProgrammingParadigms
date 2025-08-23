#Napisati program koji ređa brojeve u magičan kvadrat. Magičan kvadrat
#je kvadrat dimenzija 3x3 takav da je suma svih brojeva u svakom redu, svakoj koloni i svakoj
#dijagonali jednak 15 i svi brojevi različiti. Na primer:

import constraint

problem = constraint.Problem()

problem.addVariables('abcdefghi', range(0, 10))
problem.addConstraint(constraint.AllDifferentConstraint())

def function(x, y, z):
    if x+y+z == 15:
        return True
    

#a b c
#d e f
#g h i

#Kolone
problem.addConstraint(function, 'abc')
problem.addConstraint(function, 'def')
problem.addConstraint(function, 'ghi')

#Redovi
problem.addConstraint(function, 'adg')
problem.addConstraint(function, 'beh')
problem.addConstraint(function, 'cfi')

#Dijagonale
problem.addConstraint(function, 'aei')
problem.addConstraint(function, 'ceg')

for r in problem.getSolutions():
    print("-------")
    print(f'{r["a"]}', f'{r["b"]}', f'{r["c"]}')
    print(f'{r["d"]}', f'{r["e"]}', f'{r["f"]}')
    print(f'{r["g"]}', f'{r["h"]}', f'{r["i"]}')
    print("-------")