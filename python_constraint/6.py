#Napisati program koji pronalazi sve vrednosti promenljivih X, Y, Z i W za koje
#važi da je X >= 2 ∗ W , 3 + Y <= Z i X − 11 ∗ W + Y + 11 ∗ Z <= 100 pri čemu promenljive
#pripadaju narednim domenima X ∈ {1, 2, ..., 10}, Y ∈ {1, 3, 5, ...51}, Z ∈ {10, 20, 30, ..., 100} i
#W ∈ {1, 8, 27, ..., 1000}.
#Sve rezultate ispisati na standardni izlaz koristeći datu komandu ispisa

import constraint

problem = constraint.Problem()

problem.addVariable('X', range(1, 11))

domainY = []
for i in range(1, 52):
    if i % 2 == 1:
        domainY.append(i)

problem.addVariable('Y', domainY)

domainZ = []
for i in range(1, 11):
    domainZ.append(i*10)

problem.addVariable('Z', domainZ)

domainW = []
for i in range(1, 11):
    domainW.append(i*i*i)

problem.addVariable('W', domainW)

problem.addConstraint(lambda a, b: a >= 2*b, 'XW')
problem.addConstraint(lambda a, b: 3 + a <= b, 'YZ')
problem.addConstraint(lambda a, b, c, d: a - 11 * d + b + 11 * c <= 100, 'XYZW')

result = problem.getSolutions()
if result == []:
    print("No solutions")
else:
    for r in problem.getSolutions():
        print(f'{r["X"]}, {r["Y"]}, {r["Z"]}, {r["W"]}')
