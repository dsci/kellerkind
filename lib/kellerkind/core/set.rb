module Kellerkind
  class Set
    include Virtus

    protected

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