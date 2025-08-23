#Napisati program koji pronalazi trocifren broj ABC tako da je količnik ABC /
#(A + B + C) minimalan i A, B i C su različiti brojevi.
#Sve rezultate ispisati na standardni izlaz koristeći datu komandu ispisa.

import constraint

solution = 1000
number = 0

problem = constraint.Problem()

problem.addVariable('A', range(1, 10))
problem.addVariables('BC', range(10))

problem.addConstraint(constraint.AllDifferentConstraint())

for r in problem.getSolutions():
    d = (r['A'] * 100 + r['B'] * 10 + r['C']) / (r['A'] + r['B'] + r['C'])
    if d < solution:
        solution = d
        number = r['A'] * 100 + r['B'] * 10 + r['C']

print(number)