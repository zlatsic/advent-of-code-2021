inputs = open('09/input.txt').read.split(/\n/)
MAP = inputs.map { |row| row.chars.map(&:to_i) }.freeze

def neighbor_coords(row, col)
  [col.zero? ? nil : [row, col - 1],
   [row, col + 1],
   row.zero? ? nil : [row - 1, col],
   MAP[row + 1] && [row + 1, col]].reject(&:nil?).select { |x, y| MAP[x][y] }
end

def low_point?(row, col)
  neighborhood = neighbor_coords(row, col).map { |x, y| MAP[x][y] }
  neighborhood.select { |v| v <= MAP[row][col] }.empty?
end

def basin(row, col)
  coords = neighbor_coords(row, col)
  coords = coords.reject { |x, y| MAP[x][y] == 9 }
  coords = coords.select { |x, y| MAP[x][y] > MAP[row][col] }
  recursion = coords.map { |x, y| basin(x, y) }.flatten 1
  [[row, col]].push(*coords).push(*recursion).uniq
end

sizes = []
MAP.each_with_index do |row, row_index|
  row.each_with_index do |_, col_index|
    next unless low_point?(row_index, col_index)

    sizes << basin(row_index, col_index).length
  end
end

puts sizes.sort[-3...].reduce(1) { |prod, v| prod * v }
