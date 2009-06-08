module Cached
    
  class ConfigCompiler
    
    def initialize(config)
      @config = config      
    end
    
    def to_ruby    
      [compiled_meta_methods, compiled_save_method, compiled_fetch_methods].join      
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
    
    def compiled_save_method          
      lines = ['k = object_cache_key', "Cached.store.write(k, self)"]

      @config.indexes.each do |index| 
        index_name = index_name(index)
        cache_key  = index_cache_key(index)

        lines.push "Cached.store.write(#{cache_key}, k)" 
      end
      
      "def save_to_cache;" + 
        lines.join(';') + 
      "end;"
    end          
    
    def compiled_fetch_method_for(index)  
      index_name = index_name(index)     
      cache_key  = index_cache_key(index)
      
      "def self.lookup_by_#{index_name}(#{index.join(', ')});" + 
      "  key = Cached.store.read(#{cache_key}); "+
      "  key ? Cached.store.read(key): nil;" +
      "end;"
    end

    def compiled_fetch_method_for_primary_key      
      "def self.lookup(pk);" + 
      "  Cached.store.read(\"#\{object_cache_prefix}:#\{pk}\");"+
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