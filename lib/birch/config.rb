# encoding: utf-8

module Birch

  class Config
    
    attr_reader :dimensions
    attr_reader :distance_metric
    attr_reader :distance_treshold
    attr_reader :branching_factor
    
    def initialize(dimensions, distance_metric, distance_treshold, branching_factor)
      @dimensions = dimensions
      @distance_metric = distance_metric
      @distance_treshold = distance_treshold
      @branching_factor = branching_factor
    end
    
  end

end