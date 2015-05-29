# To run tests:
# > rspec euler.rb --color --format documentation
require 'rspec'

class Euler

  def problem_16(num, power)
    num ** power
  end

  def problem_20(num)
    factorial = num.downto(1).inject(:*)
    digits = int_to_array(factorial)
    reduce_digits(digits)
  end

  def int_to_array(int)
    digits = []
    while int != 0 do
      int, last_digit = int.divmod(10)
      digits << last_digit
    end
    digits
  end

  def reduce_digits(arr)
    arr.reduce(:+)
  end

end

describe 'Project Euler Problems' do
  before(:all) do
    @euler = Euler.new
  end

  describe 'problem 16' do
    it 'should return the sum of the power result digits' do
      expect(@euler.problem_16(2, 15)).to eq(26)
    end
  end
  describe 'problem 20' do
    it 'should return the sum of the factorial result digits' do
      expect(@euler.problem_20(10)).to eq(27)
      expect(@euler.problem_20(9)).to eq(27)
      expect(@euler.problem_20(100)).to eq(648)
    end
  end
end