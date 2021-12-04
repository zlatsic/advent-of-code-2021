input = open('01/input.txt').read
depths = input.split.map { |str| Integer(str) }
print depths.zip([depths[0], *depths[...-1]]).map { |x| x[0] > x[1] ? 1 : 0 }.sum
