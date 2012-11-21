# encoding: utf-8

require './lib/birch/abstract_node'
require './lib/birch/distances'

module Birch

  ##
  # Leaf node, does not contain any children.
  # Should only absorb nodes when distance treshold condition is not violated. 
  #
  class LeafNode < AbstractNode
    
    ##
    # Creates leaf node from a given point in multidimensional space.
    #
    def initialize(point, config)
      @config = config
      
      @points_count = 1
      @linear_sum = Array.new(config.dimensions) { |i| point[i] }
      @square_sum = Array.new(config.dimensions) { |i| point[i]*point[i] }
    end
    
    ##
    # Chceks whether this node can absorb given node wihout violating of treshold condition.
    #
    def can_absorb?(node)
      Distances.send(@config.distance_metric, self, node) < @config.distance_treshold 
    end
    
  end

end