module Cached
  module Record
    
    def self.included?(base)
      
      if base.respond_to?(:save)
        base.alias_method_chain :save, :cached        
      end
      
    end
    
    
    def save_with_cached
      save_without_cached
      
      # expire the cache, the object will be stored in it's prestine form
      # after the next lookup call hopefull.       
      expire_object_in_cache
      
      # update the indexes for the new values.
      store_indexes_in_cache      
    end
    
  end
end