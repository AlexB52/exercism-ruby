Microwave = Struct.new(:input) do
  def timer
    format('%02d:%02d', minutes, seconds)
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
    input % 100
  end

  def input_minutes
    input / 100
  end
end
