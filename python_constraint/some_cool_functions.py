#map(f, [1,2,3,1]) -> [f(1), f(2), f(3), f(1)]

xs = [1, 2, 3]

def f(x):
    return True

def my_map(f, xs):
    for x in xs:
        yield f(xs)

#filter(f, xs) [1, 2, 3] where 1 and 3 return True and 2 returns False -> [1, 3]

def my_filter(f, xs):
    for x in xs:
        if f(x):
            yield x

#zip, list(zip([1,2], [3,4], ['a', 'b'])) -> [1, 3, 'a'], [2, 4, 'b']
def my_zip(f, xs):
    pass

#sorted(list, key), where key is the value we use for comparing elements of the list
#sum = reduce(lambda x, y: x+y, list), where reduce applies function cumulatively to the items of the list



