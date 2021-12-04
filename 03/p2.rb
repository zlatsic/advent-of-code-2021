def ratio(inputs, column)
  inputs.map { |str| Integer(str[column]) }.sum / Float(inputs.length)
end

input = open('03/input.txt').read.split

selection_oxy = input
selection_co2 = input

input[0].length.times do |i|
  most_common = ratio(selection_oxy, i).round
  selection_oxy = selection_oxy.select { |row| row[i] == most_common.to_s }
end

input[0].length.times do |i|
  least_common = 1 - ratio(selection_co2, i).round
  selection_co2 = selection_co2.select { |row| row[i] == least_common.to_s }
  break if selection_co2.length == 1
end

print selection_oxy[0].to_i(2) * selection_co2[0].to_i(2)
