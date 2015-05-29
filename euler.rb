# To run tests:
# > rspec euler.rb --color --format documentation
require 'rspec'

class Euler

  def problem_16(num, power)
    reduce_digits(int_to_array(num ** power))
  end

  def problem_20(num) # this could be a one-liner, but it's easier to read on 3 lines
    factorial = num.downto(1).inject(:*)
    digits = int_to_array(factorial)
    reduce_digits(digits)
  end

  def problem_25(n)
    fib = fibonacci_to_index
    i = fib.size + 1
    until fib.last.to_s.size >= n do
      fib = fibonacci_to_index(i, fib)
      i = i + 1
    end
    i - 1
  end

  def int_to_array(int)
    digits = []
    while int != 0 do
      int, last_digit = int.divmod(10)
      digits.unshift last_digit
    end
    digits
  end

  def reduce_digits(arr)
    arr.reduce(:+)
  end

  def fibonacci_to_index(n = 3, fibonacci_seq = [1, 1]) # this would need some error handling
    n = n - 1
    fibonacci_seq.size.upto(n) do |i|
      fibonacci_seq.push (fibonacci_seq[i - 1] + fibonacci_seq[i - 2])
    end
    fibonacci_seq
  end

end

describe 'Project Euler Problems' do
  before(:all) do
    @euler = Euler.new
  end

  describe 'problem 16' do
    it 'should return the sum of the power result digits' do
      expect(@euler.problem_16(2, 15)).to eq(26)
      expect(@euler.problem_16(2, 1000)).to eq(1366)
    end
  end

  describe 'problem 20' do
    it 'should return the sum of the factorial result digits' do
      expect(@euler.problem_20(10)).to eq(27)
      expect(@euler.problem_20(9)).to eq(27)
      expect(@euler.problem_20(100)).to eq(648)
    end
  end

  describe 'problem 25' do
    it 'should return the Fibonacci sequence id containing n digits' do
      expect(@euler.problem_25(3)).to eq(12)
      expect(@euler.problem_25(1000)).to eq(4782)
    end
  end

  describe 'supporting methods' do
    describe 'int_to_array' do
      it 'should return an array containing the digits in an integer' do
        expect(@euler.int_to_array(1142)).to eq([1, 1, 4, 2])
      end
    end
    describe 'reduce_digits' do
      it 'should return the sum of the digits in the array' do
        expect(@euler.reduce_digits([1, 3, 5])).to eq(9)
      end
    end
    describe 'fibonacci_to_index' do
      it 'should return the Fibonacci number at id n' do
        expect(@euler.fibonacci_to_index(6).last).to eq(8)
        expect(@euler.fibonacci_to_index(12).last).to eq(144)
      end
    end
  end
end