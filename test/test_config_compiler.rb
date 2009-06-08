require File.dirname(__FILE__) + '/test_helper.rb'            
                     

class TestConfigCompiler < Test::Unit::TestCase

  def setup                             
    @dump = Class.new
    @config = Cached::ConfigCompiler.new(Cached::Config.new('product', 'id'))
  end
  
  test "syntax compiled_meta_methods" do    
    @dump.instance_eval @config.compiled_meta_methods
    @dump.respond_to?(:object_cache_primary_key)    
    @dump.respond_to?(:object_cache_key)    
    @dump.respond_to?(:object_cache_prefix)    
    @dump.respond_to?(:object_cache_hash)    
  end
  
  test "syntax compiled_save_method" do
    @dump.instance_eval @config.compiled_save_method
    
    @dump.respond_to?(:save_to_cache)    
  end
  
  test "syntax compiled_fetch_method_for single column" do
    @dump.instance_eval @config.compiled_fetch_method_for([:name])
    
    @dump.respond_to?(:lookup_by_name)    
  end
  
  test "syntax compiled_fetch_method_for multi column" do
    @dump.instance_eval @config.compiled_fetch_method_for([:name, :brand])
    
    @dump.respond_to?(:lookup_by_name_and_brand)        
  end
  
  test "compiled_fetch_method_for_primary_key" do
    @dump.instance_eval @config.compiled_fetch_method_for_primary_key
    
    @dump.respond_to?(:lookup)    
    @dump.respond_to?(:lookup_by_id)        
  end
  
end
