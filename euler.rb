# To run tests:
# > rspec euler.rb --color --format documentation
require 'rspec'
require './euler_support'
require 'prime'

class Euler
  include EulerSupport

  def problem_1(max, arr)
    digits = []
    1.upto(max - 1) do |i|
      arr.each do |n|
        if is_multiple_of(i, n)
          digits.push i
        end
      end
    end
    reduce_digits(digits.uniq)
  end

  def problem_2(max)
    fib = fibonacci_to_index
    i = fib.size + 1
    while fib.last <= max do
      fib = fibonacci_to_index(i, fib)
      i = i + 1
    end
    fib.pop unless fib.last == max
    reduce_digits(fib.select{ |n| n % 2 == 0})
  end

  def problem_3(num)
    i = num
    if Prime.prime?(num)
      i
    elsif Prime.prime?(num / 2)
      i = num / 2
    else
      Prime.each do |p|
        if is_multiple_of(num, p)
          i = p
        end
        break if p >= Math.sqrt(num)
      end
    end
    i
  end

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

end

describe 'Project Euler Problems' do
  before(:all) do
    @euler = Euler.new
  end

  describe 'problem_1' do
    it 'should return the sum of all multiples of [n] below max' do
      expect(@euler.problem_1(10, [3, 5])).to eq(23)
      expect(@euler.problem_1(1000, [3, 5])).to eq(233168)
    end
  end

  describe 'problem_2' do
    it 'should return the sum of even Fibonacci numbers below n' do
      expect(@euler.problem_2(20)).to eq(10)
      expect(@euler.problem_2(4000000)).to eq(4613732)
    end
  end

  describe 'problem_3' do
    it 'should return the largest prime factor for n' do
      expect(@euler.problem_3(29)).to eq(29)
      expect(@euler.problem_3(13195)).to eq(29)
      expect(@euler.problem_3(600851475143)).to eq(6857)
    end
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
    describe 'fibonacci_to_index' do
      it 'should return the Fibonacci number at id n' do
        expect(@euler.fibonacci_to_index(6).last).to eq(8)
        expect(@euler.fibonacci_to_index(12).last).to eq(144)
      end
    end
    describe 'is_multiple_of' do
      it 'should return true if i is a multiple of n' do
        expect(@euler.is_multiple_of(9, 4)).to eq(false)
        expect(@euler.is_multiple_of(9, 3)).to eq(true)
      end
    end
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
  end
end