input = open('04/input.txt').read.split(/\n/)

numbers = input[0].split(/,/).map(&:to_i)

# bingo board
class Board
  def initialize(table)
    @table = table
    @rowcounts = Array.new(5, 0)
    @colcounts = Array.new(5, 0)
    @numbers = []
  end

  attr_reader :numbers

  def update(number)
    @table.each_with_index do |row, row_index|
      col_index = row.index number
      if col_index
        @rowcounts[row_index] += 1
        @colcounts[col_index] += 1
      end
    end
    @numbers << number
  end

  def winner?
    (@rowcounts.include? 5) || (@colcounts.include? 5)
  end

  def score
    score = @table.map(&:sum).sum
    @numbers.each do |number|
      @table.each_with_index do |row, row_index|
        score -= @table[row_index][row.index number] if row.index number
      end
    end
    score * @numbers[-1]
  end
end

boards = input[2...].reduce([[]]) do |arr, row|
  next arr << [] if row == ''

  arr[-1] << row.strip.split(/\s+/).map(&:to_i)
  next arr
end
boards = boards.map { |nums| Board.new(nums) }

winner = nil
numbers.each do |n|
  boards.each { |b| b.update(n) }
  winner = boards.select(&:winner?)[0] || winner
  boards = boards.reject(&:winner?)
end

print winner.score
