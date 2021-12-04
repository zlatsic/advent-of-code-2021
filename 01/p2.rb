input = open('01/input.txt').read.split
depths = input.map { |str| Integer(str) }
sums = depths[...-2].zip(depths[1...-1], depths[2...]).map(&:sum)
sums_zipped = sums.zip([sums[0], *sums[...-1]])
print sums_zipped.map { |current, previous| current > previous ? 1 : 0 }.sum
