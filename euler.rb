# To run tests:
# > rspec euler.rb --color --format documentation
require 'rspec'

class Euler

  def problem_20(num)
    factorial = num.downto(1).inject(:*)
    digits = []
    while factorial != 0 do
      factorial, last_digit = factorial.divmod(10)
      digits << last_digit
    end
    digits.reduce(:+)
  end
end

describe 'Project Euler Problems' do
  before(:all) do
    @euler = Euler.new
  end

  it 'should do something' do
    expect(@euler.problem_20(10)).to eq(27)
    expect(@euler.problem_20(9)).to eq(27)
    expect(@euler.problem_20(100)).to eq(648)
  end
end