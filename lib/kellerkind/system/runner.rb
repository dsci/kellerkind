module Kellerkind

  # Public: Runs the Kellerkind modules depending of the --type commandline
  # argument.
  class Runner
    extend Die

    # Public: Executes a Kellerkind module.
    #
    # options={} - An optins Hash to define the behaviour of the Kellerkind
    # modules. That is - in fact - the command line arguments.
    #
    def self.exec(options={})
      Kellerkind::Config.verbose_output = options.delete(:verbose)
      handle_type(options)
    end

    private

    def self.handle_type(options={})
      module_name = options[:type].capitalize
      Module.const_get("Kellerkind").const_get("#{module_name}").exec(options)
    rescue NameError => name_error
      raise name_error
      die("No module named '#{module_name}' registered.")
    end

  end
end
