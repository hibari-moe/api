class Array
  def mean
    return nil if size == 0
    sum.to_f / size
  end

  def median
    sorted = sort
    count = sorted.size
    half = count / 2
    return nil if count == 0
    if count % 2 == 1
      sorted[half]
    else
      (sorted[half - 1] + sorted[half]) / 2.to_f
    end.to_f
  end

  def mode
    freq = sorted_frequencies
    freq.last.first unless freq.size == 0
  end

  def variance
    return nil if mean == nil
    v = self.reduce(0) { |acc, i| acc + ((i - (mean || 0)) ** 2) }
    v.to_f / size
  end

  def stddev
    return nil if variance == nil
    Math.sqrt(variance || 0)
  end

  def relative_stddev
    return nil if mean == nil
    return nil if stddev == nil
    100.0 * ((stddev || 0) / (mean || 0))
  end

  def frequencies
    hash = {} of Int64 => Int64

    self.each { |key|
      if hash[key]?
        hash[key] += 1_i64
      else
        hash[key] = 1_i64
      end
    }

    hash
  end

  def sorted_frequencies
    frequencies.to_a.sort_by { |key, value| value }
  end
end
