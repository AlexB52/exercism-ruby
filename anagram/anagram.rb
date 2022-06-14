Anagram = Struct.new(:reference) do
  def match(words)
    words.select do |word|
      a = reference.downcase
      b = word.downcase

      a != b && a.each_char.sort == b.each_char.sort
    end
  end
end
