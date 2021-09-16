require 'date'

Meetup = Struct.new(:month, :year) do
  def day(day_name, descriptor)
    day_range(descriptor)
      .select(&:"#{day_name}?")
      .slice(day_index(descriptor))
  end

  private

  def day_range(descriptor)
    descriptor == :teenth ? teenth_days_of_month : days_of_month
  end

  def day_index(descriptor)
    {teenth: 0, first: 0, second: 1, third: 2, fourth: 3, last: -1}[descriptor]
  end

  def teenth_days_of_month
    dates_range(start_day: 13, end_day: 19)
  end

  def days_of_month
    dates_range(start_day: 1, end_day: -1)
  end

  def dates_range(start_day:, end_day:)
    Date.new(year, month, start_day).step(Date.new(year, month, end_day))
  end
end