module Kellerkind

  # Public: MongoDB Kellerkind module that dumps a MongoDB database and
  # compresses it into a tarball (if --compress is true).
  class Mongodb

    # Public: Starts dumping and compressing the MongoDB database specified in
    # options.
    #
    # options - A Hash to refine the dumping and compressing process
    #           :out - The target directory the (compressed) dump is saved to
    #           :mongo_db - The MongoDB database
    #           :compress - Compress the dump [true|false]
    #           :remove_dump - Remove the dump after compressing it
    #
    def self.exec(options)
      Kellerkind::Process.locked?
      Kellerkind::Process.lock
      mongo = Mongo.new(options)
      Kellerkind::Process.verbose(:start_dumping)
      mongo.dump_database
      if options[:compress]
        compress = Compress.new(:source_path => options[:out],
                                :target_path => options[:out],
                                :tarball_prefix =>options[:mongo_db])
        if File.exists?(File.join(options[:out], options[:mongo_db]))
          Kellerkind::Process.verbose(:start_compressing)
          compress.gzip
          if compress.succeeded?
            Kellerkind::Process.verbose(:finished_compressing)
            if options[:remove_dump]
              Kellerkind::Process.verbose(:remove_dump)
              FileUtils.rm_rf(File.join(options[:out],mongo.db))
            end
          end
        else
          Kellerkind::Process.unlock
          die(DUMP_NOT_SUCCEEDED_WARNING)
        end
      end

      Kellerkind::Process.unlock
      Kellerkind::Process.verbose(:finished_dumping, mongo.db)
    end
  end
end