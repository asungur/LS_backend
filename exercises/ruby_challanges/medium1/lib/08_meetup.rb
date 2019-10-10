require 'date'

class Meetup
  DAYS_O_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ].freeze

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, week)
    days_array = compute_days_per_week(week)
    weekday = convert_day_into_number(weekday)

    correct_day = days_array.select do |day|
                    Date.new(year, month, day).cwday == weekday
                  end.join.to_i

    Date.new(year, month, correct_day)
  end

  def compute_days_per_week(string)
    case string
    when :first then (1..7).to_a
    when :second then (8..14).to_a
    when :third then (15..21).to_a
    when :fourth then (22..28).to_a
    when :teenth then (13..19).to_a
    when :last then (DAYS_O_MONTH[month] - 6..DAYS_O_MONTH[month]).to_a
    end
  end

  def convert_day_into_number(string)
    case string
    when :monday then 1
    when :tuesday then 2
    when :wednesday then 3
    when :thursday then 4
    when :friday then 5
    when :saturday then 6
    when :sunday then 7
    end
  end

  private

  attr_reader :month, :year
end
