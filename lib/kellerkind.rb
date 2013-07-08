require 'rubygems'
require 'bundler/setup'

libdir = File.dirname(__FILE__)

Dir.chdir(libdir) do
  Bundler.require
end
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require_relative 'kellerkind/dependencies'

<<-DOC
File.open('test.tar', 'wb') { |tar| Minitar.pack(File.join("/Users/Demo/tmp/"), tar) }
DOC

Kellerkind::Mongo.new