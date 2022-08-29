require "byebug"

Element = Struct.new(:datum) do
  attr_accessor :next
end

class SimpleLinkedList
  def initialize(array = [])
    @head = nil
    array.each { push(Element.new(_1)) }
  end

  def to_a
    to_ary.map(&:datum)
  end

  def to_ary
    return [] unless @head

    element = @head
    result = []
    while element
      result << element
      element = element.next
    end
    result
  end

  def reverse!
    array = to_ary.reverse
    @head = array.first
    array.each_cons(2) do |el1, el2|
      el2.next = el1
    end
    to_a
  end

  def push(element)
    element.next = @head
    @head = element
    self
  end

  def pop
    if (element = @head)
      @head = element.next
    end
    element
  end
end
