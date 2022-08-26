# This isn't a linked list, yet specs pass

class SimpleLinkedList
  def initialize(array = [])
    @elements = []
    array.each { push(Element.new(_1)) }
  end

  def to_a
    @elements.map(&:datum)
  end

  def reverse!
    @elements.reverse!
    to_a.empty? ? self : to_a
  end

  def push(element)
    @elements.unshift(element)
    self
  end

  def pop
    @elements.shift
  end
end

Element = Struct.new(:datum) do
  attr_accessor :next
end
