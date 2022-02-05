input = open('07/input.txt').read
positions = input.split(/,/).map(&:to_i)

center = positions.sum / positions.length
puts positions.map { |p| ((p - center).abs + 1).times.sum }.sum
