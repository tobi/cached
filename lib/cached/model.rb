module Cached
   
  module Model
    
    module ClassMethods
      def cache_by_key(primary_key, &block)
        config = Config.new(name.underscore.downcase, primary_key)
        config.instance_eval(&block)      
        
        self.class_eval ConfigCompiler.new(config).to_ruby, __FILE__, __LINE__               
      end            
    end
    
    def self.included(base)          
      base.extend ClassMethods                            
    end
    
                                                                                                     
    def save_to_cache
      save_object_to_cache
      save_indexes_to_cache
    end
        
  end            
  
  
end