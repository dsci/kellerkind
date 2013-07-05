module Kellerkind
  module Lock
    extend self

    def lock_process
      unless File.exists?(Kellerkind::Config.lock_dir)
        FileUtils.mkdir(Kellerkind::Config.lock_dir)
      end
      FileUtils.touch(Kellerkind::Config.lock_path)
    end

    def unlock_process
      if File.exists?(Kellerkind::Config.lock_path)
        FileUtils.rm(Kellerkind::Config.lock_path)
      end
    end

  end
end