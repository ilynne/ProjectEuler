# To run tests:
# > rspec euler.rb --color --format documentation
require 'rspec'

class Euler

  def problem_20(num)
    n = num
    while n > 1 do
      num = num * (n - 1)
      n = n - 1
    end

    digits = []

    while num != 0 do
      num, last_digit = num.divmod(10)
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