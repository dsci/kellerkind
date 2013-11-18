module Kellerkind

  # Public: (Log)File Kellerkind module that compresses a bunch of files,
  # removes and recreates blank files of them.
  class Log

    # Public: Starts compressing a bunch of logfiles, removes and recreates
    # blank files of them - if --recreate is true.
    #
    # options={} - An options Hash to refine log file process.
    #              :paths     - A list fo file paths that should be compressed
    #                           and moved.
    #              :out       - The path the files should be moved to
    #              :recreate  - Indictator if the files should be renewed as
    #                           blank file after compressing.
    #
    # Returns the duplicated String.
    def self.exec(options={})
      Kellerkind::Process.locked?
      Kellerkind::Process.lock
      LogFile.new(options).archive
      Kellerkind::Process.unlock
    end
  end
end
