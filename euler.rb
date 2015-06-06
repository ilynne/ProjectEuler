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
    Prime.prime_division(num).last[0]
  end

  def problem_4(num)
    max = (10 ** num) -1
    arr = (max.downto(10 ** (num - 1)))
    palindrome = false
    product = nil
    palindromes = []
    arr.each do |n|
      break if palindrome
      arr.each do |i|
        product = n * i
        palindrome = product.to_s == product.to_s.reverse
        palindromes.push product if palindrome
      end
    end
    palindromes.uniq.sort.last
  end

  def problem_5(max) # much too slow
    arr =  unique_multipliers(max)
    product = max
    until arr.map{|i| product % i}.reduce(:+) == 0
      product += max
      break if product > 10000000000
    end 
    product
  end

  def problem_6(max)
    arr = 1.upto(max)
    arr.reduce(:+)**2 - arr.map{|n| n ** 2}.reduce(:+)
  end

  def problem_7(num)
    Prime.first(num).last
  end

  def problem_8(num, max)
    arr = num.to_s.split('').map{|n| n.to_i}
    product = []
    arr_slice = []
    i = 0
    until i + max > arr.length
      arr_slice = arr.slice(i, max)
      product.push arr_slice.reduce(:*)
      i = i + 1
    end
    product.sort.last
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

  describe 'problem_4' do
    it 'should return the palindrome product for n' do
      expect(@euler.problem_4(2)).to eq(9009)
      expect(@euler.problem_4(3)).to eq(906609)
    end
  end

  describe 'problem_5' do
    it 'should return the smallest multiple of all numbers 1 to n' do
      expect(@euler.problem_5(2)).to eq(2)
      expect(@euler.problem_5(10)).to eq(2520)
      expect(@euler.problem_5(20)).to eq(232792560)
    end
  end

  describe 'problem_6' do
    it 'should return the square sum difference of n' do
      expect(@euler.problem_6(10)).to eq(2640)
      expect(@euler.problem_6(100)).to eq(25164150)
    end
  end

  describe 'problem_7' do
    it 'should return the nth prime number' do
      expect(@euler.problem_7(6)).to eq(13)
      expect(@euler.problem_7(10001)).to eq(104743)
    end
  end

  describe 'problem_8' do
    it 'should find the largest n adjacent digits' do
      num = 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450
      expect(@euler.problem_8(num, 4)).to eq(5832)
      expect(@euler.problem_8(num, 13)).to eq(5832)
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