qsort []        = []
qsort (p:xs)    = sortedLeft ++ [p] ++ sortedRight
    where sortedLeft    = qsort [x | x <- xs, x < p]
          sortedRight   = qsort [x | x <- xs, x >= p]