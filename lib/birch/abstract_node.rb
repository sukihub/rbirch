# encoding: utf-8

module Birch

  ##
  # Abstract node, which:
  # - has CF (clustering feature),
  # - can absrob other nodes into self or extract them.
  #
  class AbstractNode

    attr_reader :points_count
    attr_reader :linear_sum
    attr_reader :square_sum

    ##
    # Create empty node (with zero points and zero linear and square sum vectors).
    #
    def initialize(config)
      @config = config
      
      @points_count = 0
      @linear_sum = Array.new(config.dimensions, 0)
      @square_sum = Array.new(config.dimensions, 0)
    end

    ##
    # Absorb given node into current node.
    # In other words, include given node's CF into current node's CF.
    #
    def absorb!(node)
      @points_count += node.points_count

      other_linear_sum = node.linear_sum
      other_square_sum = node.square_sum

      @config.dimensions.times do |i|
        @linear_sum[i] += other_linear_sum[i]
        @square_sum[i] += other_square_sum[i]
      end
    end

    ##
    # Extract given node from current node.
    # In other words, remove given node's CF from current node's CF.
    #
    def extract!(node)
      @points_count -= node.points_count

      other_linear_sum = node.linear_sum
      other_square_sum = node.square_sum

      @config.dimensions.times do |i|
        @linear_sum[i] -= other_linear_sum[i]
        @square_sum[i] -= other_square_sum[i]
      end
    end

  end

end