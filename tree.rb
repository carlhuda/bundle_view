require "rubygems"
require "bundler"
require "graphviz"

ENV['BUNDLE_GEMFILE'] = '/Users/kevin/tpl/Gemfile'

graph = GraphViz::new('Gemfile')
graph.node[:fontname => 'Helvetica']

clusters = {}

nodes = {}
# add all specs to the graph
# flag all spacs there were explicitly required
Bundler.definition.dependencies.each do |d|
  groups = d.groups.reject{ |g| g == :default}

  parent = graph
  if(groups.size == 1)
    group = groups[0]

    if clusters.has_key?(group)
      parent = clusters[group]
    else
      clusters[group] = parent = graph.add_graph(
        "cluster_#{group}",
        {:label => group}
      )
    end
  end

  nodes[d.name] = parent.add_node(d.name, {:style => 'bold',

    :fontname => 'Helvetica-Bold',
    :style => 'filled',
    :fillcolor => '#aaaacc'})
end

Bundler.runtime.specs.each do |s|
  if !nodes.has_key? s.name
    nodes[s.name] = graph.add_node(s.name)
  end
end


Bundler.runtime.specs.each do |s|

  from = nodes[s.name]

  s.runtime_dependencies.each do |d|
    to = nodes[d.name]
    from << to
  end

end

graph.output( :svg => "test.svg" )
