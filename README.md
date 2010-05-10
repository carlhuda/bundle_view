# Bundle View #

I have grand aspirations for this code.
For now: silly simple.

## Prerequisites ##

1. [Ruby Gems](http://rubygems.org/)
2. [Gem Bundler](http://gembundler.com/)
3. [GraphViz](http://www.graphviz.org/)
4. [ruby-graphviz gem](http://rubygems.org/gems/ruby-graphviz)
5. A project with a Bundler Gemfile. May I suggest a [Rails 3](http://guides.rails.info/3_0_release_notes.html) app?

## Run it! ##

Either copy this file into a dir with a Gemfile or set the Gemfile path manually by assigning `ENV['BUNDLE_GEMFILE']`

## What you'll see ##


## Future ##

I have a lot of crazy ideas. No clue if this is going to become anything. But it's fun...

* Turn it into an actual module, as opposed to just a bunch of ruby in a file
* Turn it into an actual Gem. Seems appropriate.
* Make it an extension/plugin to Bundler
* Support exporting to HTML with embedded SVG...maybe with some hover effects, links to RubyGems.org for each package, etc.
* Be slightly more robust about handling gems -> not just using their simple names
* Show version info, etc. Version requested vs what was picked, etc.

Your ideas? Share!