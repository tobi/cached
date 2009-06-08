module Cached
  class Config     
    attr_accessor :indexes, :class_name, :primary_key, :delegates
    
    def initialize(class_name, primary_key)           
      @delegates, @indexes, @class_name, @primary_key = [], [], class_name.to_s, primary_key.to_s
    end
          
    def index(*args)
      @indexes.push args.flatten
    end         
    
    def delegate_to(*methods)
      @delegates += methods.flatten
    end

  end
end