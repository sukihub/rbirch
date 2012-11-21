# encoding: utf-8

require './lib/birch/abstract_node.rb'

class FakeNode < Birch::AbstractNode
    
  def initialize(point)
    @points_count = 1
    @linear_sum = Array.new(point.length) { |i| point[i] } 
    @square_sum = Array.new(point.length) { |i| point[i]*point[i] } 
  end
    
end