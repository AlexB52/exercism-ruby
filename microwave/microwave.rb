Microwave = Struct.new(:input) do
  def timer
    "#{format(minutes)}:#{format(seconds)}"
  end

  def seconds
    input_seconds % 60
  end

  def minutes
    input_minutes + extra_minutes
  end

  private

  def extra_minutes
    input_seconds / 60
  end

  def input_seconds
    format(input)[-2..].to_i
  end

  def input_minutes
    format(input)[...-2].to_i
  end

  def format(duration)
    duration.to_s.rjust(2,"0")
  end
end
