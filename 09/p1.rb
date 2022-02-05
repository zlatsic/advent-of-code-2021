inputs = open('09/input.txt').read.split(/\n/)
map = inputs.map { |row| row.chars.map(&:to_i) }

def check(value, neighborhood)
  neighborhood = neighborhood.reject(&:nil?)
  print value, neighborhood
  puts
  return 0 unless neighborhood.select { |v| v <= value }.empty?

  value + 1
end

risk = 0
map.each_with_index do |row, row_index|
  row.each_with_index do |value, col_index|
    risk += check(value, [
      col_index.positive? ? row[col_index - 1] : nil,
      row[col_index + 1],
      row_index.positive? && map[row_index - 1] ? map[row_index - 1][col_index] : nil,
      map[row_index + 1] ? map[row_index + 1][col_index] : nil
    ])
  end
end

puts risk
