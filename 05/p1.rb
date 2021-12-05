input = open('05/input.txt').readlines

lines = input.map do |row|
  row.strip.split(/ -> /).map { |p| p.split(/,/).map(&:to_i) }
end

lines = lines.select { |l| l[0][0] == l[1][0] || l[0][1] == l[1][1] }

def points(line)
  start, stop = line
  short = (start[0] - stop[0]).abs > (start[1] - stop[1]).abs ? 1 : 0
  long = 1 - short
  if stop[long] == start[long]
    yield start
    return
  end
  increment = (stop[short] - start[short]) / Float(stop[long] - start[long]).abs
  yield start
  current = Array.new(start)
  while (current[long] - stop[long]) != 0
    current[long] += current[long] < stop[long] ? 1 : -1
    current[short] += increment
    yield current.map(&:round)
  end
end

occurences = {}
lines.each do |line|
  points(line) { |p| occurences[p] = (occurences[p] || 0) + 1 }
end

puts occurences.select { |_, value| value > 1 }.length
