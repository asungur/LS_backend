class Clock
  def initialize(hours, minutes = 0)
    @hours = hours
    @minutes = minutes
    correct_hh_mm
  end

  def self.at(hours, minutes = 0)
    new(hours, minutes)
  end

  def ==(other)
    to_s == other.to_s
  end

  def +(minutes)
    @minutes += minutes
    correct_hh_mm
    self
  end

  def -(minutes)
    self.+(-minutes)
  end

  def to_s
    format('%02d:%02d', @hours, @minutes)
  end

  private

  def correct_hh_mm
    @hours += (@minutes / 60).floor
    @hours %= 24
    @minutes %= 60
  end
end