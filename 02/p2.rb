input = open('02/input.txt').read.split(/\n/)

horizontal_factors = input.map do |row|
  direction, amount = row.split
  next direction == 'forward' ? 1 : 0, Integer(amount)
end
horizontal = horizontal_factors.map { |factor, amount| factor * amount }.sum

aims = input.reduce([]) do |arr, row|
  direction, amount = row.split
  aim_direction = { up: -1, down: 1, forward: 0 }[direction.to_sym]
  arr.append (arr[-1] || 0) + aim_direction * Integer(amount)
end

vertical_zipped = horizontal_factors.zip(aims)
vertical = vertical_zipped.reduce(0) do |sum, ((factor, distance), aim)|
  sum + factor * distance * aim
end

print horizontal * vertical
