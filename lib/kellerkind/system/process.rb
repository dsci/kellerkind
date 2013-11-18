module Kellerkind
  module Process
    extend Die

    class Output
      def self.outputs
        {
          :start_dumping => lambda do
            puts Kellerkind::Config.start_dumping
          end,
          :start_compressing => lambda do
            puts Kellerkind::Config.start_compressing
          end,
          :finished_compressing => lambda do
            puts Kellerkind::Config.finished_compressing
          end,
          :remove_dump => lambda do
            puts Kellerkind::Config.remove_dump
          end,
          :finished_dumping => lambda do |db_name|
            puts Kellerkind::Config.finished_dumping(db_name)
          end
        }
      end

      def self.respond_to?(meth_name)
        outputs.has_key?(meth_name) || super
      end

      def self.method_missing(meth_name, *args, &block)
        if outputs.has_key?(meth_name)
          output = outputs[meth_name]
          if Kellerkind::Config.verbose?
            output.call(*args) if output.arity == 1
            output.call unless output.arity == 1
          end
        else
          super
        end
      end

    end

    PROCESS_LOCKED_WARNING = <<-WARNING
      kellerkind.lock find! Make sure that there isn't another kellerkind process running!
    WARNING

    DUMP_NOT_SUCCEEDED_WARNING = <<-WARNING
      No dump found. It seems dumping failed.
    WARNING

    def self.lock
      Kellerkind::Lock.lock_process
    end

    def self.unlock
      Kellerkind::Lock.unlock_process
    end

    def self.locked?
      die(PROCESS_LOCKED_WARNING) if File.exists?(Kellerkind::Config.lock_path)
    end

    def self.verbose(*args)
      kind = args.shift
      Kellerkind::Process::Output.send(kind, *args)
    end

  end
end