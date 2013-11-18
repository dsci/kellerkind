require 'zlib'
require 'archive/tar/minitar'

module Kellerkind

  # Public: Compresses a mongodb dump directory by using Gzip and tar.
  class Compress < Set

    include Archive::Tar

    # Path where dump is located (parent direcotry of the dump)
#    attribute :path,          String
    # Database name which equals the dumps directory name
 #   attribute :database_name, String

    attribute :target_path,     String
    attribute :source_path,     String
    attribute :tarball_prefix,  String

    # Public: Duplicate some text an arbitrary number of times.
    #
    # Returns the duplicated String.
    def find_at_source_path
      @find_at_source_path ||= false
    end

    # Public: Duplicate some text an arbitrary number of times.
    #
    # flag -
    #
    # Returns the duplicated String.
    def find_at_source_path=(flag)
      @find_at_source_path = flag
    end

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
      File.exists?(File.join(self.target_path, @actual_tar_name))
    end

    def tarball_name
      "#{self.tarball_prefix}_#{Time.now.to_i}.tar.gz"
    end

    private

    def traverse_and_gzip
      Find.find(self.source_path).each do |file|
        tgz = Zlib::GzipWriter.new(db_dump_gz_file)
        Minitar.pack(file, tgz)
      end
    end

    def db_dump_gz_file
      File.open(tar_location, 'wb')
    end

    def tar_location
      @actual_tar_name = tarball_name
      File.join(define_lookup_path, @actual_tar_name)
    end

    def define_lookup_path
      if find_at_source_path
        if File.directory?(self.source_path)
          self.source_path
        else
          File.dirname(self.source_path)
        end
      else
        self.target_path
      end
    end

  end
end