module Kellerkind

  # Public: Various methods useful for configure Kellerkind.
  module Config
    extend self


    # Public: Gets the prefix that is use in the cli for database options.
    #
    # Returns a regular expression.
    def db_prefix
      /mongo_/
    end


    # Public: Gets the name of the command line executable to use for
    # dumping.
    #
    # Returns name of executable as String.
    def db_dump_cmd
      "mongodump"
    end


    # Public: Gets the path to the lock dir to mark process running.
    # Note that just one kellerkind process is runnable.
    def lock_dir
      File.join(Dir.home, "tmp")
    end

    # Public: Gets the direct path to kellerkind lock file
    def lock_path
      File.join(lock_dir,"Kellerkind.lock")
    end

    # Internal: Gets message for action when dumping was started.
    def start_dumping
      %Q{Start dumping ...}
    end

    # Internal: Gets message for action when a dump is about to remove.
    def remove_dump
      %Q{Remove raw dump. To disable that use --remove-dump false}
    end

    # Internal: Gets message for action when compressing was started.
    def start_compressing
      %Q{Start compressing of dump ... }
    end

    # Internal: Gets message for action when compressing is finished.
    def finished_compressing
      %Q{Compressing done ...}
    end

    # Internal: Gets message for action when all is done.
    #
    # database - Name of the database from which a dump is created.
    def finished_dumping(database)
      %Q{ -- Dumping of #{database} done ...}
    end

    # Internal: Sets if Kellerkind should be talkative or not.
    #
    # flag - Boolean, true if Kellerkind should generate output, false if not.
    def verbose_output=(flag)
      @verbose_output = flag
    end

    # Internal: Checks if Kellerkind should be verbose or not.
    def verbose?
      @verbose_output
    end

  end
end
