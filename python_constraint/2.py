#Dati su novčići od 1, 2, 5, 10, 20 dinara. Napisati program koji pronalazi sve
#moguće kombinacije tako da zbir svih novčića bude 50.
#Sve rezultate ispisati na standardni izlaz koristeći datu komandu ispisa

import constraint

problem = constraint.Problem()

problem.addVariable('1_din', range(0, 49))
problem.addVariable('2_din', range(0, 26))
problem.addVariable('5_din', range(0, 11))
problem.addVariable('10_din', range(0, 6))
problem.addVariable('20_din', range(0, 3))

problem.addConstraint(constraint.ExactSumConstraint(50, [1, 2, 5, 10, 20]), ['1_din', '2_din', '5_din', '10_din', '20_din'])
for r in problem.getSolutions():
    print(f'{r["1_din"]}, {r["2_din"]}, {r["5_din"]}, {r["10_din"]}, {r["20_din"]}')
    total = r['1_din'] + r["2_din"] + r["5_din"] + r["10_din"] + r["20_din"]
    print("Ukupno novčića: " + str(total))
    print('-------------')
