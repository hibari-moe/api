class Array
  def mean
    return nil if size == 0
    sum.to_f / size
    # round(2)
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

#     def modes(&block)
#       sorted_frequencies = self.sorted_frequencies
#       sorted_frequencies.select do |item, frequency|
#         frequency == sorted_frequencies.first[1]
#       end.map do |item, frequency|
#         item
#       end
#     end

#     # This function is oddly written in order to group 1 (integer) and 1.0 (float) together.
#     # If we loaded a hash or used group_by, 1 and 1.0 would be counted as separate things.
#     # Instead, we use the == operator for grouping.
#     def frequencies(&block)
#       begin
#         sorted = sort
#       rescue NoMethodError # i.e. undefined method `<=>' for :my_symbol:Symbol
#         sorted = sort_by do |item|
#           item.respond_to?(:"<=>") ? item : item.to_s
#         end
#       end
#       current_item = nil;

#       Hash[
#         sorted.reduce {|frequencies, item|
#           if frequencies.size == 0 || item != current_item
#             current_item = item
#             frequencies << [item, 1]
#           else
#             frequencies.last[1] += 1
#             frequencies
#           end
#         }
#       ]
#     end

#     def sorted_frequencies(&block)
#       frequencies.sort_by do |item, frequency|
#         if item.respond_to?(:"<=>")
#           [-frequency, item]
#         else
#           [-frequency, item.to_s]
#         end
#       end
#   end
# end
