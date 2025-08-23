#Napisati program koji dodeljuje različite vrednosti različitim karakterima tako
#da suma bude zadovoljena:

import constraint

problem = constraint.Problem()

problem.addVariables("WOUR", range(10))
problem.addVariables("TF", range(1, 10))

problem.addConstraint(constraint.AllDifferentConstraint())

def function (t, w, o, f, u, r):
    return t*100+w*10+o + t*100+w*10+o == f*1000+o*100+u*10+r

problem.addConstraint(function, "TWOFUR")

for r in problem.getSolutions():
    print("--------------")
    print(f'   {r["T"]}{r["W"]}{r["O"]}')
    print(f'+  {r["T"]}{r["W"]}{r["O"]}')
    print(f'=  {r["F"]}{r["O"]}{r["U"]}{r["R"]}')

