# encoding: utf-8

require './lib/birch/non_leaf_node.rb'
require './lib/birch/config'
require './spec/lib/birch/fake_node'

describe Birch::NonLeafNode do

  before :all do
    @config = Birch::Config.new(2, :manhattan, 5.0, 3)
  end 

  describe 'initialize' do
  
    it 'should create empty NonLeafNode' do
      nn = Birch::NonLeafNode.new(@config)
      nn.points_count.should == 0      
    end
    
    describe 'with children' do
    
      before :all do
        @nn = Birch::NonLeafNode.new([ FakeNode.new([ 2.0, 2.0 ]), FakeNode.new([ 4.0, 5.0 ]) ], @config)
      end
    
      it 'should create NonLeafNode with 2 children' do
        @nn.points_count.should == 2
      end
    
      it 'should absorb both children' do
        @nn.linear_sum.should == [ 6.0, 7.0 ]
        @nn.square_sum.should == [ 20.0, 29.0 ]
      end
    
    end
  
  end
  
  describe 'need_splitting?' do
  
    it 'should not need splitting' do
      nn = Birch::NonLeafNode.new([ FakeNode.new([ 2.0, 2.0 ]), FakeNode.new([ 4.0, 5.0 ]), FakeNode.new([ 2.0, 5.0 ])  ], @config)
      nn.needs_splitting?().should be_false
    end
  
    it 'should need splitting' do
      nn = Birch::NonLeafNode.new([ FakeNode.new([ 2.0, 2.0 ]), FakeNode.new([ 4.0, 5.0 ]), FakeNode.new([ 2.0, 5.0 ]), FakeNode.new([ 1.0, 1.0 ])  ], @config)
      nn.needs_splitting?().should be_true
    end
  
  end
  
  describe 'split' do
  
    it 'should split 2 children' do
      fakes = [ FakeNode.new([ 1.0, 1.0 ]), FakeNode.new([ 1.0, 2.0 ]) ]
      nn = Birch::NonLeafNode.new(fakes, @config)
      
      s1, s2 = nn.split
      
      s1.children.length.should == 1
      s1.children[0].should == fakes[1]
      
      s2.children.length.should == 1
      s2.children[0].should == fakes[0]
    end
  
    it 'should split lot of children' do
      fakes = [ 
        FakeNode.new([ 1.0, 1.0 ]), FakeNode.new([ 1.0, 2.0 ]), FakeNode.new([ 1.0, 3.0 ]), FakeNode.new([ 1.0, 4.0 ]), FakeNode.new([ 1.0, 5.0 ]),
        FakeNode.new([ 1.0, 6.0 ]), FakeNode.new([ 1.0, 7.0 ]), FakeNode.new([ 1.0, 8.0 ]), FakeNode.new([ 1.0, 9.0 ]), FakeNode.new([ 1.0, 10.0 ]) 
      ]
      nn = Birch::NonLeafNode.new(fakes, @config)
      
      s1, s2 = nn.split
      
      s1.children.length.should == 5
      s1.children.should == fakes.last(5)
      
      s2.children.length.should == 5
      s2.children.should == fakes.first(5)
    end
  
  end

end