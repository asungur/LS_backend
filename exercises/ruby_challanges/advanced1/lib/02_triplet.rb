class Triplet
  attr_reader :a, :b, :c

  def initialize(angle_a, angle_b, angle_c)
    @a = angle_a
    @b = angle_b
    @c = angle_c
  end

  def self.where(options)
    result = []
    max = options[:max_factor] || 10
    min = options[:min_factor] || 1
    sum = options[:sum]

    combinations(min.upto(max).to_a).each do |combo|
      triplet = Triplet.new(combo[0], combo[1], combo[2])

      if triplet.pythagorean?
        if sum
          result << triplet if triplet.sum == sum
        else
          result << triplet
        end
      end
    end

    result
  end

  def self.combinations(arr)
    arr
    .product(arr)
    .product(arr)
    .map(&:flatten)
    .map(&:sort)
    .uniq
  end

  def pythagorean?
    !!(c ** 2 == a ** 2 + b ** 2)
  end

  def sum
    a + b + c
  end

  def product
    a * b * c
  end
end
