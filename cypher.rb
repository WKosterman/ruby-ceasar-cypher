# frozen_string_literal: true

# to cypher and decypher strings with ceasar cypher
# tried to use object oriented programming and array / hash functions
class CypherArray
  def initialize(string, shift)
    @string = string
    @shift = shift
  end

  attr_reader :string, :shift, :array

  def encypher
    @reverse = false
    unwind_case.join
  end

  def decypher
    @reverse = true
    unwind_case.join
  end

  def to_letters
    numbers_shift!.reduce([]) do |a, v|
      a << if v.is_a? Numeric
             ('a'..'z').to_a[v % 26]
           else
             v
           end
    end
  end

  def to_numbers
    convert_array.reduce([]) do |a, v|
      a << if ('a'..'z').include? v
             ('a'..'z').to_a.index(v)
           else
             v
           end
    end
  end

  def numbers_shift!
    to_numbers.map! do |v|
      if v.is_a? Numeric
        v.+((@reverse ? -1 : 1) * @shift)
      else
        v
      end
    end
  end

  def wind_case
    @string.split('').reduce([]) do |a, v|
      a << if ('A'..'Z').include? v
             true
           else
             false
           end
    end
  end

  def unwind_case
    case_arr = wind_case
    result_arr = [nil]
    to_letters.each_with_index do |e, i|
      result_arr[i] = if case_arr[i]
                        e.upcase
                      else
                        e
                      end
    end
    result_arr
  end

  def convert_array
    @array = @string.downcase.split('')
  end
end

def caesar_cypher(string, shift = 0)
  string_array = CypherArray.new(string, shift)
  string_array.encypher
end

def caesar_decypher(string, shift = 0)
  string_array = CypherArray.new(string, shift)
  string_array.decypher
end

puts caesar_cypher('What a string!', 5)

puts caesar_decypher('Bmfy f xywnsl!', 5)

puts caesar_cypher('What a string!', 5) == 'Bmfy f xywnsl!'
