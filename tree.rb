require "rubygems"
require "bundler"
require "graphviz"


ENV['BUNDLE_GEMFILE'] = '/Users/kevin/tpl/Gemfile'

all_specs = Bundler.runtime.specs.to_a


g = GraphViz::new( "G" )

nodes = {}

all_specs.each do |s|
  nodes[s.name] = g.add_node(s.name)
end

all_specs.each do |s|
  
  from = nodes[s.name]
  
  s.runtime_dependencies.each do |d|
    to = nodes[d.name]
    g.add_edge( from, to )
    
  end
  
end

g.output( :png => "test.png" )
