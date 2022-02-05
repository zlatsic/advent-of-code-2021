inputs = open('10/input.txt').read.split(/\n/)

SCORE = {
  '>' => 4,
  '}' => 3,
  ']' => 2,
  ')' => 1
}.freeze

MATCH = {
  '<' => '>',
  '{' => '}',
  '[' => ']',
  '(' => ')'
}.freeze

scores = []

inputs.each do |row|
  stack = []
  corrupt = false
  row.chars.each do |c|
    if MATCH[c]
      stack.push MATCH[c]
    elsif stack.pop != c
      corrupt = true
      break
    end
  end

  scores << stack.reverse.reduce(0) { |sum, c| sum * 5 + SCORE[c] } unless corrupt
end

puts scores.sort[scores.length / 2]
