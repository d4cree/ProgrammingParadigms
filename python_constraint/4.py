#Napisati program koji pronalazi sve vrednosti promenljivih X, Y i Z za koje
#važi da je X >= Z i X ∗ 2 + Y ∗ X + Z <= 34 pri čemu promenljive pripadaju narednim domenima
#X ∈ {1, 2, ..., 90}, Y ∈ {2, 4, 6, ...60} i Z ∈ {1, 4, 9, 16, ..., 100}

import constraint

problem = constraint.Problem()

problem.addVariable('X', range(1, 91))

pair = []
for i in range(1, 61):
    if i % 2 == 0:
        pair.append(i)

problem.addVariable('Y', pair)

square = []
for i in range(1, 11):
    square.append(i*i)

problem.addVariable('Z', square)

problem.addConstraint(lambda a, b: a >= b, ['X', 'Z'])
problem.addConstraint(lambda a, b, c: a*2 + b*a + c <= 34, ['X', 'Y', 'Z'])

for r in problem.getSolutions():
    print("------------------")
    print(f'{r["X"]}, {r["Y"]}, {r["Z"]}')

