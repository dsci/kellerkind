# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "kellerkind"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Schmidt"]
  s.date = "2013-07-08"
  s.description = "Dumps mongodb databases and archives them."
  s.email = "dsci@code79.net"
  s.executables = ["kellerkind"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/kellerkind",
    "kellerkind.gemspec",
    "lib/kellerkind.rb",
    "lib/kellerkind/core/configuration.rb",
    "lib/kellerkind/core/ext.rb",
    "lib/kellerkind/core/set.rb",
    "lib/kellerkind/database/mongo.rb",
    "lib/kellerkind/dependencies.rb",
    "lib/kellerkind/system/compress.rb",
    "lib/kellerkind/system/die.rb",
    "lib/kellerkind/system/lock.rb",
    "lib/kellerkind/system/runner.rb",
    "spec/fixtures/mongodb.js",
    "spec/kellerkind/database/mongo_spec.rb",
    "spec/kellerkind/system/compress_spec.rb",
    "spec/kellerkind/system/lock_spec.rb",
    "spec/kellerkind/tmp/.gitkeep",
    "spec/kellerkind_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/dsci/kellerkind"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Mongodb archiving tool."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<virtus>, ["~> 0.5.5"])
      s.add_runtime_dependency(%q<minitar>, ["~> 0.5.4"])
      s.add_runtime_dependency(%q<trollop>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3.5"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
    else
      s.add_dependency(%q<virtus>, ["~> 0.5.5"])
      s.add_dependency(%q<minitar>, ["~> 0.5.4"])
      s.add_dependency(%q<trollop>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.3.5"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    end
  else
    s.add_dependency(%q<virtus>, ["~> 0.5.5"])
    s.add_dependency(%q<minitar>, ["~> 0.5.4"])
    s.add_dependency(%q<trollop>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.13.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.3.5"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
  end
end
