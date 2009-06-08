module Cached                 
   
  module Model
    
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