module Hibari::JsonAPI

  def attribute_stats_freq(json, key, value)
    json.field key do
      json.object do
        value.each do |k, v|
          JsonAPI.field json, k, v
        end
      end
    end
  end


  def attribute_stats(json, stats)
    json.object do
      stats.each do |key, value|
        if value.is_a?(Hash)
          attribute_stats_freq json, key, value
        else
          value = value.round(2) unless value.nil?
          JsonAPI.field json, key, value
        end
      end
    end
  end
end
