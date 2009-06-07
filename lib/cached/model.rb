module Cached                 
   
  module Model         
    
    class Config     
      attr_accessor :indexes, :class_name, :primary_key
      
      def initialize(class_name, primary_key)           
        @indexes, @class_name, @primary_key = [], class_name.to_s, primary_key.to_s
      end
            
      def index(*args)
        @indexes.push [args].flatten
      end         

    end
    
    module ClassMethods
      def cache_by_key(primary_key, &block)

        config = Config.new(name.underscore.downcase, primary_key)
        config.instance_eval(&block)      
        
        self.class_eval ConfigCompiler.new(config).to_ruby        
        
        self.class_eval "def self.hello; 'hi'; end"
      end
    end
    
    def self.included(base)          
      base.extend ClassMethods                            
    end
                                                                                                 
    
    def save_to_cache
      Cached.store.write(object_cache_key, self)
    end
    
    
  end            
  
  
end