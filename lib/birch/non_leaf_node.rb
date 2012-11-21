# encoding: utf-8

require './lib/birch/abstract_node'
require './lib/birch/distances'

module Birch

  ##
  # Node with clustering feature that can have children.
  #
  class NonLeafNode < AbstractNode

    attr_reader :children

    ##
    # Creates either empty non leaf node, or node containing given children nodes.
    #
    def initialize(children = nil, config)
      super(config)

      @children = children || []
      @children.each { |child| absorb!(child) }
    end

    ##
    # Finds out whether node needs to be split.
    # (whether its number of children is greater than branching factor)
    #
    def needs_splitting?
      @children.length > @config.branching_factor
    end

    ##
    # Adds given node into this node's subtree:
    # - if current node has no children, given node is set as first child and current node's CF is updated
    # - if current node has children:
    #   - finds child that is closest to the given node
    #   - if closest child is leaf node:
    #     - if closest leaf child can absorb given node without violating treshold condition, given node's CF 
    #       is absorbed into child leaf node's CF
    #     - else given node is appended as new child, and its CF is absorbed into current node
    #   - else << method is called recursively on closest child and if necessary, closest child is split after it
    #     (which consits of removing closest child from current node and its CF, and adding new splitted nodes
    #     into current node and its CF) 
    #
    def <<(node)
    
      # if current node has no children, just add new one
      if @children.length == 0
        @children << node
        absorb!(node)
      
      # if current node already has children    
      else
        closest_child_index = find_closest_child(node)
        closest_child = @children[closest_child_index]  
    
        # if closest child is leaf, either absorb node or create a new child
        if closest_child.instance_of? LeafNode
          if closest_child.can_absorb?(node)
            closest_child.absorb!(node)
          else
            @children << node
          end
          
          absorb!(node)
          
        # if closest child is not leaf, add node to that child and split it, if necessary
        else
          closest_child << node
          absorb!(node)
          
          if closest_child.needs_splitting?
            n1, n2 = closest_child.split
            
            @children[closest_child_index] = n1
            @children << n2
            
            extract!(closest_child)
            absorb!(n1)
            absorb!(n2)
          end
        end
      
      end

    end
      
    ##
    # Splits current node into two nodes by finding two children of this node that are the most far apart
    # and by dividing the rest of the children between these two nodes.
    #
    def split
    
      distances = Array.new(@children.length) { Array.new(@children.length) }
    
      max_distance = -1.0
      farthest1 = -1
      farthest2 = -1
    
      @children.length.times do |i|
        i.times do |j|
          distance = Distances.send(@config.distance_metric, @children[i], @children[j])
          distances[i][j] = distances[j][i] = distance

          if distance > max_distance
            max_distance = distance
            farthest1 = i
            farthest2 = j
          end
        end
        distances[i][i] = 0.0
      end

      split1 = []
      split2 = []
      
      @children.each_with_index do |child, i|
        distance1 = distances[farthest1][i]
        distance2 = distances[farthest2][i]
        
        distance1 < distance2 ? split1 << child : split2 << child
      end    
      
      return NonLeafNode.new(split1, @config), NonLeafNode.new(split2, @config)
    
    end

  private
  
    ##
    # Return index of a child that is closest to the given node.
    # If current node has no children, returns nil.
    #
    def find_closest_child(node)
      # if node has no children yet
      return nil if @children.length == 0
    
      # calculate distance between each children and given node
      distances = @children.map do |child|
        Distances.send(@config.distance_metric, child, node)
      end
      
      # find the index of a child, whose distance to node is lowest
      distances.each_with_index.min_by { |with_index| with_index[0] } [1]
    end
  
  end

end