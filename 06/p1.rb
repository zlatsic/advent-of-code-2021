input = open('06/input.txt').read
initial_numbers = input.split(/,/).map(&:to_i)

# fish
class Fish
  @all = []
  def initialize(days)
    @days = days
    self.class.instance_variable_get(:@all).append(self)
  end

  def pass
    @days -= 1
    return unless @days == -1

    Fish.new(8)
    @days = 6
  end
end

initial_numbers.each { |n| Fish.new(n) }

80.times { Array.new(Fish.instance_variable_get(:@all)).each(&:pass) }

puts Fish.instance_variable_get(:@all).length
