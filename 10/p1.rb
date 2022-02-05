inputs = open('10/input.txt').read.split(/\n/)

SCORE = {
  '>' => 25_137,
  ']' => 57,
  '}' => 1197,
  ')' => 3
}.freeze

MATCH = {
  '<' => '>',
  '[' => ']',
  '{' => '}',
  '(' => ')'
}.freeze

score = 0

inputs.each do |row|
  stack = []
  row.chars.each do |c|
    if MATCH[c]
      stack.push MATCH[c]
    elsif stack.pop != c
      score += SCORE[c]
      break
    end
  end
end

puts score
