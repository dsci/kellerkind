require 'pathname'

module Kellerkind

  # Public: Compresses/Backups a bunch of files.
  # All methods are module methods and should be called on the Math module.
  #
  class LogFile < Set

    # A list of files (at least one)
    attribute :paths,     Array
    # File path location for compressed backups
    attribute :out,       String
    # Indicator if list of files should be recreated after compressing as
    # blank file.
    attribute :recreate,  Boolean

    # Public: Compresses the backup, removes the files and (optional) recreates
    # them as blank files.
    def archive
      paths.each do |path|
        path_obj  = Pathname.new(path)
        path_name = path_obj.dirname.to_s
        compress  = Kellerkind::Compress.new(:target_path => out,
                                             :source_path => path,
                                             :tarball_prefix => path_obj.basename.to_s)
        compress.find_at_source_path = true
        if File.exists?(path)
          Kellerkind::Process.verbose(:start_compressing)
          compress.gzip
          if File.exists?("#{path_name}/#{compress.tarball_name}")
            Kellerkind::Process.verbose(:finished_compressing)
            FileUtils.mv("#{path_name}/#{compress.tarball_name}",
                       "#{out}/#{compress.tarball_name}")
            FileUtils.rm_rf(path)
            FileUtils.touch(path) if self.recreate
          end
        end
      end
    end

  end

end