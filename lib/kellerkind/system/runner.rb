module Kellerkind
  class Runner
    extend Die

    PROCESS_LOCKED_WARNING = <<-WARNING
      kellerkind.lock find! Make sure that there isn't another kellerkind process running!
    WARNING

    DUMP_NOT_SUCCEEDED_WARNING = <<-WARNING
      No dump found. It seems dumping failed.
    WARNING

    def self.exec(options={})
      process_locked?
      lock_process
      mongo = Mongo.new(options)
      puts Kellerkind::Config.start_dumping
      mongo.dump_database
      if options[:compress]
        compress = Compress.new(:path => options[:out],
                                :database_name =>options[:mongo_db])
        if File.exists?(File.join(options[:out], options[:mongo_db]))
          puts Kellerkind::Config.start_compressing
          compress.gzip
          if compress.succeeded?
            puts Kellerkind::Config.finished_compressing
            if options[:remove_dump]
              puts Kellerkind::Config.remove_dump
              FileUtils.rm_rf(File.join(options[:out],mongo.db))
            end
          end
        else
          unlock_process
          die(DUMP_NOT_SUCCEEDED_WARNING)
        end
      end

      unlock_process
      puts Kellerkind::Config.finished_dumping(mongo.db)
    end

    def self.process_locked?
      die(PROCESS_LOCKED_WARNING) if File.exists?(Kellerkind::Config.lock_path)
    end

    private

    def self.lock_process
      Kellerkind::Lock.lock_process
    end

    def self.unlock_process
      Kellerkind::Lock.unlock_process
    end
  end
end