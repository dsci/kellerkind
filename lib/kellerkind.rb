require 'rubygems'
require 'bundler/setup'

Bundler.require

require_relative 'kellerkind/dependencies'

<<-DOC
File.open('test.tar', 'wb') { |tar| Minitar.pack(File.join("/Users/Demo/tmp/"), tar) }
DOC

Kellerkind::Mongo.new