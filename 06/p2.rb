input = open('06/input.txt').read
initial_numbers = input.split(/,/).map(&:to_i)

$cache = {}

def branch(days_left)
  total = 1

  periods_left = (days_left / 7 + 1)
  return $cache[days_left] if $cache[days_left]

  periods_left.times do |period|
    total += branch(days_left - period * 7 - 9)
  end
  $cache[days_left] = total
end

puts initial_numbers.map { |n| branch(256 - n - 1) }.sum
