module Kellerkind

  # Public: Dumps a MongoDb database.
  #
  # For more see mongodump --help
  class Mongo < Set

    # MongoDb database (required)
    attribute :db,        String
    # MongoDb host
    attribute :host,      String
    # MongoDb user
    attribute :username,  String
    # MongoDb user password
    attribute :password,  String
    # MongoDb server host
    attribute :port,      String
    # File path location for dump
    attribute :out,       String

    def initialize(options={})
      init_instance(options) unless options.empty?
    end


    # Public: Dumps the database by using a stream to the underlying
    # operation system.
    #
    def dump_database
      cmd = %Q{`which #{Kellerkind::Config.db_dump_cmd}` #{dump_argument_list}}
      out = IO.popen(cmd)
      out.readlines.join(" ")
    end


    # Public: Builds an argument list for mongodump by taking only values
    # existing in #attributes
    #
    # Returns the argument list string.
    def dump_argument_list
      usable_line_args = attributes.select{|k,v| not v.nil? }
      return "" if usable_line_args.empty?
      return usable_line_args.collect do |key,value|
        "--#{key} #{value}"
      end.join(" ")
    end

    private

    def init_instance(options)
      options.each_pair do |key,value|
        instance_attr = key.to_s.split(Kellerkind::Config.db_prefix).last
        if instance_attr.to_sym.in?(attributes.keys)
          self.send("#{instance_attr}=", value)
        end
      end
    end
  end
end