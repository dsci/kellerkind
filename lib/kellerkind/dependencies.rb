%w{ core/ext.rb
    core/configuration
    core/set
    system/lock
    system/compress
    system/die
    database/mongo
    system/runner
  }.each{ |code| require_relative code }
