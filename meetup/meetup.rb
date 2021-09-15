require 'byebug'
require 'date'

class Meetup
  attr_reader :month, :year

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(day_name, rank)
    Date.new(year, month, day_number(day_name, rank))
  end

  private

  def day_number(day_name, rank)
    case rank
    when :teenth
      teenth_day(day_name)
    when :first
      first_day(day_name)
    when :second
      second_day(day_name)
    when :third
      third_day(day_name)
    when :fourth
      fourth_day(day_name)
    when :last
      last_day(day_name)
    end
  end

  def teenth_day(day_name)
    [13, 14, 15, 16, 17, 18, 19]
      .map  { |day| Date.new(year, month, day) }
      .find { |date| date.send("#{day_name}?")}
      .day
  end

  def first_day(day_name)
    Date.new(year, month).step(Date.new(year,month,-1))
      .find { |date| date.send("#{day_name}?") }
      .day
  end

  def second_day(day_name)
    Date.new(year, month).step(Date.new(year,month,-1))
      .select { |date| date.send("#{day_name}?") }
      .slice(1)
      .day
  end

  def third_day(day_name)
    Date.new(year, month).step(Date.new(year,month,-1))
      .select { |date| date.send("#{day_name}?") }
      .slice(2)
      .day
  end

  def fourth_day(day_name)
    Date.new(year, month).step(Date.new(year,month,-1))
      .select { |date| date.send("#{day_name}?") }
      .slice(3)
      .day
  end

  def last_day(day_name)
    Date.new(year, month).step(Date.new(year,month,-1))
      .select { |date| date.send("#{day_name}?") }
      .slice(-1)
      .day
  end
end