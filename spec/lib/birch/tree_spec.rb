require './lib/birch'

describe Birch::Tree do

  it 'should create two children nodes in root, each with 2 points' do
    tree = create_tree(
      [ 2.0, 2.0 ], [ 2.1, 2.5 ], 
      [ 8.0, 8.0 ], [ 7.9, 7.9 ]
    )
    
    tree.root.children.length.should == 2
    children_counts(tree.root.children).should == [2, 2]
  end

  it 'should create three children nodes in root' do
    tree = create_tree(
      [ 2.0, 2.0 ], [ 2.1, 2.5 ], 
      [ 8.0, 8.0 ], [ 7.9, 7.9 ], 
      [ 5.0, 5.2 ]
    )
    
    tree.root.children.length.should == 3
    children_counts(tree.root.children).should == [2, 2, 1]
  end

  it 'should split the root into two nodes' do
    tree = create_tree(
      [ 2.0, 2.0 ], [ 2.1, 2.5 ], 
      [ 8.0, 8.0 ], [ 7.9, 7.9 ], 
      [ 5.0, 5.2 ],
      [ 11.0, 11.4 ] 
    )
    
    tree.root.children.length.should == 2
    children_counts(tree.root.children).should == [3, 3]
  end
  
  it 'should create one cluster' do
    tree = create_tree(
      [ 2.0, 2.0 ], [ 2.1, 2.1 ], [ 2.2, 2.2 ], [ 2.3, 2.3 ], [ 2.4, 2.4 ], [ 2.5, 2.5 ], [ 2.6, 2.6 ], [ 2.7, 2.7 ]
    )
    
    tree.root.children.length.should == 1
    children_counts(tree.root.children).should == [8]
  end
  
  it 'should create one big cluster and one small' do
    tree = create_tree(
      [ 2.0, 2.0 ], [ 2.1, 2.1 ], [ 2.2, 2.2 ], [ 2.3, 2.3 ], [ 2.4, 2.4 ], [ 2.5, 2.5 ], [ 2.6, 2.6 ], [ 2.7, 2.7 ],
      [ 2.35, 2.35 + 5.0 ]
    )
    
    tree.root.children.length.should == 2
    children_counts(tree.root.children).should == [8, 1]
  end
  
  it 'should still create one big cluster' do
    tree = create_tree(
      [ 2.0, 2.0 ], [ 2.1, 2.1 ], [ 2.2, 2.2 ], [ 2.3, 2.3 ], [ 2.4, 2.4 ], [ 2.5, 2.5 ], [ 2.6, 2.6 ], [ 2.7, 2.7 ],
      [ 2.35, 2.35 + 4.99 ]
    )
    
    tree.root.children.length.should == 1
    children_counts(tree.root.children).should == [9]
  end

  def create_tree(*items)
    tree = Birch::Tree.new( Birch::Config.new(2, :manhattan, 5.0, 3) )
    items.each { |i| tree << i }
    tree
  end

  def children_counts(nodes)
    nodes.map { |n| n.points_count }
  end

end