# encoding: utf-8

require './lib/birch/abstract_node'
require './lib/birch/config'
require './spec/lib/birch/fake_node'

describe Birch::AbstractNode do

  before :all do
    @config = Birch::Config.new(2, :manhattan, 5.0, 3)
  end

  describe 'initialize' do

    before :all do
      @an = Birch::AbstractNode.new(@config)
    end

    it 'should create node with zero points' do
      @an.points_count.should == 0 
    end
    
    it 'should create zero linear sum vector' do
      @an.linear_sum.should == [0, 0]
    end
    
    it 'should create zero square sum vector' do
      @an.square_sum.should == [0, 0] 
    end

  end

  describe 'absorb!' do
  
    before :all do
      @an = Birch::AbstractNode.new(@config)
      @an.absorb! FakeNode.new([ 2.0, 4.0 ])
    end
  
    it 'should have one point' do
      @an.points_count.should == 1 
    end
    
    it 'should correctly update linear sum vector' do
      @an.linear_sum.should == [ 2.0, 4.0 ] 
    end
    
    it 'should correctly update square sum vector' do
      @an.square_sum.should == [ 4.0, 16.0 ] 
    end 
  
    describe 'two nodes' do
    
      before :all do
        @an.absorb! FakeNode.new([ 5.0, 3.0 ])
      end
      
      it 'should have two points' do
        @an.points_count.should == 2 
      end
      
      it 'should correctly update linear sum vector' do
        @an.linear_sum.should == [ 7.0, 7.0 ] 
      end
      
      it 'should correctly update square sum vector' do
        @an.square_sum.should == [ 29.0, 25.0 ] 
      end
    
    end
  
  end
  
  describe 'extract!' do
  
    describe 'same as already inserted' do
      
      before :all do
        @an = Birch::AbstractNode.new(@config)
        @an.absorb! FakeNode.new([ 2.0, 4.0 ])
        @an.absorb! FakeNode.new([ 5.0, 3.0 ])
        
        @an.extract! FakeNode.new([ 2.0, 4.0 ])
      end
      
      it 'should have one point' do
        @an.points_count.should == 1 
      end
      
      it 'should correctly update linear sum vector' do
        @an.linear_sum.should == [ 5.0, 3.0 ] 
      end
      
      it 'should correctly update square sum vector' do
        @an.square_sum.should == [ 25.0, 9.0 ] 
      end
    
    end
    
    describe 'multiple points' do
    
      before :all do
        @an = Birch::AbstractNode.new(@config)
        @an.absorb! FakeNode.new([ 2.0, 4.0 ])
        @an.absorb! FakeNode.new([ 5.0, 3.0 ])
        @an.absorb! FakeNode.new([ 3.0, 6.0 ]) 
      
        e = Birch::AbstractNode.new(@config)
        e.absorb! FakeNode.new([ 2.0, 4.0 ])
        e.absorb! FakeNode.new([ 2.0, 6.0 ]) 
        
        @an.extract! e
      end
      
      it 'should have one point' do
        @an.points_count.should == 1 
      end
      
      it 'should correctly update linear sum vector' do
        @an.linear_sum.should == [ 6.0, 3.0 ] 
      end
      
      it 'should correctly update square sum vector' do
        @an.square_sum.should == [ 30.0, 9.0 ] 
      end
    
    end
  
  end
  
end