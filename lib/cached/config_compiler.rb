module Cached
    
  class ConfigCompiler
    
    def initialize(config)
      @config = config      
    end
    
    def to_ruby    
      [compiled_meta_methods, compiled_save_methods, compiled_fetch_methods].join      
    end        
        
    def compiled_meta_methods
      
      # Instance methods
      "def object_cache_primary_key; \"#{@config.primary_key}\"; end;" + 
      "def object_cache_key; \"\#{object_cache_prefix}:\#{#{@config.primary_key}}\"; end;" + 
      "def object_cache_prefix; \"#{@config.class_name}\"; end;" +       
      "def object_cache_hash(*args); args.join.hash; end;" +
      
      # Class methods
      "def self.object_cache_prefix; \"#{@config.class_name}\"; end;" +       
      "def self.object_cache_hash(*args); args.join.hash; end;"
    end
    
    def compiled_save_methods
      compiled_save_object_method + compiled_save_index_method
    end
    
    def compiled_save_object_method          
      "def save_object_to_cache;" + 
        "Cached.store.write(object_cache_key, self);" +
      "end;" +
      
      "def expire_object_in_cache;" + 
        "Cached.store.delete(object_cache_key);" +
      "end;"
    end          
    
    def compiled_save_index_method
            
      keys = @config.indexes.collect { |index| index_cache_key(index) }
      
      "def save_indexes_to_cache;" + 
        "v = #{@config.primary_key};" +
        keys.collect{|k| "Cached.store.write(#{k}, v);"}.join +
      "end;" +
      
      "def expire_indexes_in_cache;" +
        keys.collect{|k| "Cached.store.delete(#{k});"}.join +
      "end;"
    end
    
    def compiled_fetch_method_for(index)  
      index_name = index_name(index)     
      cache_key  = index_cache_key(index)
      
      method_suffix_and_parameters = "#{index_name}(#{index.join(', ')})"
      
      delegates = @config.delegates.collect { |delegate| "#{delegate}_by_#{method_suffix_and_parameters}"  }
      
      "def self.lookup_by_#{method_suffix_and_parameters};" + 
      "  key = Cached.store.read(#{cache_key}); "+
      #}"  key ? Cached.store.read(key): Cached.store.fetch(key) { #{ delegates.join(' || ')  } } ;" + 
      "  key ? lookup(key): nil;" +
      "end;"
    end

    def compiled_fetch_method_for_primary_key      
      
      delegation = @config.delegates.collect{|c| "|| #{c}(pk)" }.join
      
      "def self.lookup(pk);" +
      "  Cached.store.fetch(\"#\{object_cache_prefix}:#\{pk}\") { nil #{delegation} };" +      
      "end;" +
      
      
      "def self.lookup_by_#{@config.primary_key}(pk);" + 
      "  lookup(pk); "+
      "end;" 
    end
    
    def compiled_fetch_methods
      compiled_fetch_method_for_primary_key + @config.indexes.collect { |index| compiled_fetch_method_for(index) }.join(';')
    end
          
    private        
    
    def index_cache_key(index)
      "\"#\{object_cache_prefix}/#{index_name(index)}:#\{object_cache_hash(#{index.join(', ')})}\""  
    end  
    
    def index_name(index)
      index.collect(&:to_s).collect(&:downcase).collect(&:underscore).join('_and_')
    end
  end
  
  
end