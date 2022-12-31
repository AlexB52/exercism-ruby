class Proverb
  def initialize(*things, qualifier: nil)
    @things = things
    @goal = things.first
    if qualifier
      @goal = format("%s %s", qualifier, @goal)
    end
  end

  def to_s
    @things.each_cons(2)
           .map { |want, lost| format("For want of a %s the %s was lost.", want, lost) }
           .push(format("And all for the want of a %s.", @goal))
           .join("\n")
  end
end