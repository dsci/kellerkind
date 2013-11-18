%w{ core/ext.rb
    core/configuration
    core/set
    system/lock
    system/compress
    system/die
    system/process
    modules/modules
    system/runner
  }.each{ |code| require_relative code }
