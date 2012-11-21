# encoding: utf-8

require './lib/birch/non_leaf_node'
require './lib/birch/leaf_node'

module Birch

  ##
  # Birch tree data structure.
  #
  class Tree
  
    attr_reader :root
  
    ##
    # Creates empty birch tree.
    #
    def initialize(config)
      @config = config
      @root = NonLeafNode.new(nil, @config)
    end
    
    ##
    # Adds point into the birch tree.
    #
    def <<(point)
      leaf = LeafNode.new(point, @config)
      @root << leaf
      
      if @root.needs_splitting?
        n1, n2 = @root.split
        @root = NonLeafNode.new([ n1, n2 ], @config)
      end
    end
  
  end

end