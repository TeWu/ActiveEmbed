# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "active_embed/version"

Gem::Specification.new do |s|
  s.name        = "active_embed"
  s.version     = ActiveEmbed::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TeWu"]
  s.email       = ["wm.tewu@poczta.fm"]
  s.homepage    = "https://github.com/TeWu"
  s.summary     = %q{"Embeddable Value" design pattern implementation for ActiveRecord}
  s.description = %q{Allows to embed PORO in Rails-Model class}

  #s.rubyforge_project = "active_embed"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
