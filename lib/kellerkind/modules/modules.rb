Dir[File.expand_path(File.join(File.dirname(__FILE__), '**','*.rb'))].each do |file|
  require file unless file.match(/modules.rb/)
end