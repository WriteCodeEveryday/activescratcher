$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activescratcher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activescratcher"
  s.version     = ActiveScratcher::VERSION
  s.authors     = ["Lazaro Herrera"]
  s.email       = ["lazherrera@gmail.com"]
  s.homepage    = "http://writecodeeveryday.github.io/projects/activescratcher"
  s.summary     = "ActiveRecord-based gem to get you from 'git clone' to 'rails s'"
  s.description = "This gem fills your database with some 'full loop' records in order to get a non-documented database up and running ASAP"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency "activerecord" #Should be obvious why.
  s.add_dependency "faker"

  s.add_development_dependency "sqlite3"
end
