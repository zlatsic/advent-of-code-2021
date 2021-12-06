input = open('06/input.txt').read
initial_numbers = input.split(/,/).map(&:to_i)

def process(period, days)
  sum = 0
  days.times do
    sum += process(8, days - 1) if period.zero?
    period = period.zero? ? 6 : period - 1
    days -= 1
  end
  sum + 1
end

puts [3, 4, 3, 1, 2].map { |n| process(n, 80) }.sum
