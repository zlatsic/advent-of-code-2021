positions = open('08/input.txt').read.split(/\n/)

AND_MAPPINGS = {
  1 => { 1 => [2, 3, 5, 6], 2 => [9, 0] },
  4 => { 2 => [2], 3 => [3, 5, 6, 0], 4 => [9] },
  7 => { 2 => [2, 3, 5, 6], 3 => [9, 0] },
  2 => { 3 => [5], 4 => [3, 9, 0] },
  6 => { 4 => [3], 5 => [5, 9, 0] },
  5 => { 4 => [0], 5 => [9] }
}.freeze

def deduce(patterns)
  unresolved = patterns.select { |_, v| v.length > 1 }.keys
  until unresolved.length.zero?
    resolved = patterns.select { |_, v| v.length == 1 }.keys
    unresolved.product resolved do |encoding, encoding_solved|
      deduced = iter(patterns, encoding, encoding_solved)
      patterns[encoding] = deduced if deduced
    end
    unresolved = patterns.select { |_, v| v.length > 1 }.keys
  end
  patterns
end

def iter(patterns, encoding, encoding_solved)
  solved = patterns[encoding_solved][0]
  return unless AND_MAPPINGS[solved]

  intersection = encoding.chars.intersection(encoding_solved.chars)
  new_options = AND_MAPPINGS[solved][intersection.length]
  return unless new_options

  deduced = patterns[encoding].intersection(new_options)
  return if deduced.empty?

  return if patterns.invert[deduced]

  deduced
end

total = 0

positions.each do |p|
  patterns, outputs = p.split(/\|/).map(&:strip)
  patterns = patterns.split(/\s+/).map { |x| x.chars.sort.join }
  patterns = patterns.each_with_object({}) do |v, hash|
    hash[v] = { 2 => [1],
                3 => [7],
                4 => [4],
                5 => [2, 3, 5],
                6 => [6, 9, 0],
                7 => [8] }[v.length]
    hash
  end
  patterns = deduce(patterns)
  outputs = outputs.split(/\s+/).map { |x| x.chars.sort.join }
  total += outputs.map { |o| patterns[o][0].to_s }.join.to_i
end

puts total
