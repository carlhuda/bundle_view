require "rubygems"
require "bundler"
require 'ap'

ENV['BUNDLE_GEMFILE'] = '/Users/kevin/tpl/Gemfile'

# all explicitly required dependencies
#puts Bundler.definition.dependencies

rails = Bundler.definition.dependencies[0]

# all specs for all required gems
# these are of type gem specification
all_specs = Bundler.runtime.specs.to_a

all_specs.each do |s|
  puts s.full_name
  puts "  #{s.runtime_dependencies}"

end