# encoding: utf-8

require './lib/birch/leaf_node'
require './lib/birch/config'
require './spec/lib/birch/fake_node'

describe Birch::LeafNode do

  describe 'can_absorb?' do
  
    before :all do
      @config = Birch::Config.new(2, :manhattan, 5.0, 3)
      @ln = Birch::LeafNode.new([ 0.0, 0.0 ], @config)
    end
    
    it 'should absorb [0.0, 4.9]' do
      @ln.can_absorb?(FakeNode.new([ 0.0, 4.9 ])).should be_true
    end
  
    it 'should absorb [4.9, 0.0]' do
      @ln.can_absorb?(FakeNode.new([ 4.9, 0.0 ])).should be_true
    end
  
    it 'should absorb [2.19, 2.8]' do
      @ln.can_absorb?(FakeNode.new([ 2.19, 2.8 ])).should be_true
    end
  
    it 'should not absorb [0.0, 5.0]' do
      @ln.can_absorb?(FakeNode.new([ 0.0, 5.0 ])).should be_false
    end
  
    it 'should absorb [4.9, 0.0]' do
      @ln.can_absorb?(FakeNode.new([ 5.0, 0.0 ])).should be_false
    end
  
    it 'should absorb [2.2, 2.8]' do
      @ln.can_absorb?(FakeNode.new([ 2.2, 2.8 ])).should be_false
    end
  
  end

end