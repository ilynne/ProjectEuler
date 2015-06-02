# To run tests:
# > rspec euler_support.rb --color --format documentation
require 'rspec'
module EulerSupport

  def fibonacci_to_index(n = 3, fibonacci_seq = [1, 1]) # this would need some error handling
    n = n - 1
    fibonacci_seq.size.upto(n) do |i|
      fibonacci_seq.push (fibonacci_seq[i - 1] + fibonacci_seq[i - 2])
    end
    fibonacci_seq
  end

  def is_multiple_of(i, int)
    i % int == 0
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
end
