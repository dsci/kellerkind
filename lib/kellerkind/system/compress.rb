require 'zlib'
require 'archive/tar/minitar'

module Kellerkind

  # Public: Compresses a mongodb dump directory by using Gzip and tar.
  class Compress < Set

    include Archive::Tar

    # Path where dump is located (parent direcotry of the dump)
    attribute :path,          String
    # Database name which equals the dumps directory name
    attribute :database_name, String


    # Public: Initialises compressing of the dumps directory.
    def gzip
      traverse_and_gzip
    end


    # Public: Checks if tar file exists.
    #
    # If tar file exists we assume compressing succeeds
    #
    # Returns true if file exists otherwise false.
    def succeeded?
      File.exists?(File.join(self.path, @actual_tar_name))
    end

    private

    def traverse_and_gzip
      Dir.chdir(self.path) do
        Find.find(self.database_name).each do |file|
          if File.directory?(file)
            tgz = Zlib::GzipWriter.new(db_dump_gz_file)
            Minitar.pack(file, tgz)
          end
        end
      end
    end

    def tarball_name
      "#{self.database_name}_#{Time.now.to_i}.tar.gz"
    end

    def db_dump_gz_file
      File.open(tar_location, 'wb')
    end

    def tar_location
      @actual_tar_name = tarball_name
      File.join(self.path, @actual_tar_name)
    end

  end
end