Object.class_eval do

  def in?(list)
    raise ArgumentError unless list.respond_to?(:include?)
    list.include?(self)
  end

end