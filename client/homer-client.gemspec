# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "homer-client/version"

Gem::Specification.new do |s|
  s.name        = 'homer-client'
  s.version     = Homer::Client::VERSION
  s.date        = '2015-04-28'
  s.summary     = "Homer is an interface for proxying text or voice commands to home-automation APIs."
  s.description = "A common interface and convention for home automation clients."
  s.authors     = ["derekddecker@gmail.com"]
  s.email       = 'derekddecker@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec}/*`.split("\n")
  s.require_paths = ['lib']
  
  s.add_dependency "angelo"
  s.add_dependency "sqlite3"
  s.add_dependency "activerecord"
  s.add_dependency "psych"
  s.add_dependency "mustermann"
  s.add_development_dependency "rspec"
end
