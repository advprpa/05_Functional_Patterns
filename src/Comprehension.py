numbers = [1, 2, 3, 4, 5]

# List comprehension
even_squares = [num ** 2 for num in numbers if num % 2 == 0]
print(even_squares)

# Same with map and filter
even_squares2 = list(map(lambda num: num ** 2, filter(lambda num: num % 2 == 0, numbers)))
print(even_squares2)