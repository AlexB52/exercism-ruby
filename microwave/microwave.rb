require 'byebug'

Microwave = Struct.new(:input) do
  def timer
    min, sec = convert(seconds)
    "#{format(min+minutes)}:#{format(sec)}"
  end

  def convert(seconds)
    [seconds / 60, seconds % 60]
  end

  def seconds
    format(input.to_s)[-2..].to_i
  end

  def minutes
    input.to_s[..-3].to_i
  end

  private

  def format(duration)
    duration.to_s.rjust(2,"0")
  end
end
