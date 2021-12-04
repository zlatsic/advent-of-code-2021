input = open('02/input.txt').read.split(/\n/)

horizontal_factors = input.map do |row|
  direction, amount = row.split
  next direction == 'forward' ? 1 : 0, Integer(amount)
end
horizontal = horizontal_factors.map { |factor, amount| factor * amount }.sum

vertical_factors = input.map do |row|
  direction, amount = row.split
  amount_int = Integer(amount)
  next { up: -1, down: 1, forward: 0 }[direction.to_sym], amount_int
end
vertical = vertical_factors.map { |factor, amount| factor * amount }.sum

print horizontal * vertical
