require "rubygems"
require "bundler"
require "graphviz"

ENV['BUNDLE_GEMFILE'] = '~/tpl/Gemfile' #set to a Gemfile path if you don't run this in a directory with a Gemfile

FONT_NAME = 'Arial'

graph = GraphViz::new('Gemfile')
graph.node[:fontname => FONT_NAME, :margin => '0.05, 0.05' ]
graph.graph[ :dpi => 100, :size => '9,9', :nodesep => '.1', :bgcolor => 'transparent']

# clusters store sub-graphs that aren't default. 'test' is common, for instance.
clusters = {}

# hash of name => graph node
nodes = {}

# Walk through the dependencies.
#  This is done before walking the specs, since we can know
#  1) This was an explicit requirement by the user
#  2) What group (if any) the item is associated with
Bundler.definition.dependencies.each do |d|

  # by default, all nodes are just children of the main graph
  parent = graph

  # But if a dependency is in a non-default group, we want to
  #  cluster them seperately
  groups = d.groups.reject{ |g| g == :default}

  # graphviz doesn't support overlapping clusters.
  # A node can't be in both cluster 'a' and 'b'
  # So only cluster a node iff it's in only one non-default group
  if(groups.size == 1)
    group = groups[0]

    if clusters.has_key?(group)
      parent = clusters[group]
    else
      clusters[group] = parent = graph.add_graph(
        "cluster_#{group}",
        { :label => "Group: #{group}" }
      )
    end
  end

  # Add a node (with styles for a dependency) to the graph
  # and save it in our hash
  nodes[d.name] = parent.add_node(d.name, {:style => 'bold',
    :style => 'filled',
    :fillcolor => '#aaaacc'}
  )

end

# Now walk through all of the 'specs'
Bundler.runtime.specs.each do |spec|
  name = spec.name
  node = nil

  if nodes.has_key? name
    # we might have already added this one
    node = nodes[name]
  else
    # If we haven't create it
    node = nodes[name] = graph.add_node(name)
  end

  # display all system gems in boxes
  node[:shape] = 'box' if spec.source.to_s == 'system gems'
end

# now walk though a final time and add edges
Bundler.runtime.specs.each do |s|

  from = nodes[s.name]
  s.runtime_dependencies.each do |d|
    to = nodes[d.name]
    from << to
  end

end

# You can do output(:svg => "file.svg") here, etc.
graph.output( :png => "Gemfile.png" )
