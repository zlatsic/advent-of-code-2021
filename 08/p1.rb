positions = open('08/input.txt').read.split(/\n/)

total = 0

positions.each do |p|
  _, output = p.split(/\|/).map(&:strip)
  total += output.split(/\s+/).select { |o| [2, 4, 3, 7].include? o.length }.length
end

puts total
