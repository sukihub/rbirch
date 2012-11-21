RBirch
======

Ruby implementation of Birch clustering algorithm:

*   [Wikipedia](http://en.wikipedia.org/wiki/BIRCH_%28data_clustering%29 "Wikipedia - Birch")
*   [Original ACM paper](http://dl.acm.org/citation.cfm?id=593443 "Original ACM papier")

Usage
-----
**Work in progress - only insertion of points is currently supported.**

    Birch::Config.new(
      2,                # number of dimensions of data points
      :manhattan,       # distance metric, only :manhattan is supported currently
      5.0,              # distance treshold
      3                 # branching factor
    )
    
    tree = Birch::Tree.new(config)
    tree << [ 2.0, 2.0 ]
    tree << [ 2.1, 2.5 ]
    tree << [ 8.0, 8.0 ]
    tree << [ 7.9, 7.9 ]
    tree << [ 5.0, 5.2 ]
    
    tree.root.children.length # == 3 - three clusters were created
    tree.root.children[0].points_count # == 2 - first cluster has 2 points
    tree.root.children[1].points_count # == 2 - second cluster also has 2 points
    tree.root.children[2].points_count # == 1 - third cluster has 1 point