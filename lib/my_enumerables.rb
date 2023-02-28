module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    for element in self do
      yield(element, index)
      index += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    for element in self do
      arr.push(element) if yield(element) == true
    end
    arr
  end

  def my_all?
    for element in self do
      if block_given?
        if yield(element) == false
          return false
        end
      else
        if element == false || element.nil?
          return false
        end
      end
    end
    true
  end

  def my_any?
    for element in self do
      if block_given?
        if yield(element) == true
          return true
        end
      else
        if element == true
          return true
        end
      end
    end
    false
  end

  def my_none?
    for element in self do
      if block_given?
        if yield(element) == true
          return false
        end
      else
        if element == true
          return false
        end
      end
    end
    true
  end

  def my_count
    count = 0
    for element in self do
      if block_given?
        if yield(element) == true
          count += 1
        end
      else
        count += 1
      end
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    array = []
    for element in self
      array << yield(element)
    end
    array
  end
 
  def my_inject(initial_operand = 0, symbol = :+)
    result = self[0]
    count = 0
    if initial_operand != 0
      count -= 1
      result = initial_operand
    end
    while count < self.length - 1
      if block_given?
        result = yield(result, self[count+1])
      else
        result = symbol.to_proc.call(result,self[count+1])
      end
      count += 1
    end
    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    return to_enum(:my_each) unless block_given?

    for element in self do
      yield(element)
    end
  end
end

class Hash
  def my_each
    return to_enum(:my_each) unless block_given?

    for key, value in self
      yield(key, value)
    end
  end
end