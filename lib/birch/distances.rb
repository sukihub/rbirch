# encoding: utf-8

module Birch

  module Distances
  
    def self.manhattan(n1, n2)
  
      distance = 0.0
      
      n1_linear_sum = n1.linear_sum
      n1_points_count = n1.points_count.to_f
      
      n2_linear_sum = n2.linear_sum
      n2_points_count = n2.points_count.to_f
      
      n1_linear_sum.length.times do |i|
        distance += (n1_linear_sum[i] / n1_points_count - n2_linear_sum[i] / n2_points_count).abs
      end
      
      distance
  
    end
  
  end

end