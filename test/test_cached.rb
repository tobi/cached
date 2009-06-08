require File.dirname(__FILE__) + '/test_helper.rb'            
                     
class Product < Struct.new(:id, :name, :price, :vendor)  
  include Cached::Model
  
  cache_by_key :id do     
    index :name         
    index [:vendor, :name]    
  end
  
end


class TestCached < Test::Unit::TestCase

  def setup                             
    @product = Product.new(1, 'ipod', 149.00, 'apple')
  end
  
  context "cache storage" do
  
    test "product can be stored to cache" do    
      @product.respond_to?(:save_to_cache)
    end
  
    test "product stores meta data in instance methods" do    
      assert_equal "id", @product.object_cache_primary_key
    end
  
    test "product has efficient object_cache_key instance method" do
      assert_equal "product:1", @product.object_cache_key    
    end
  
    test "product stores itself to memcached on save_to_cache call" do
      assert @product.save_to_cache    
      assert_equal @product, Cached.store.read('product:1')             
    end
  
    test "product stores defined indexes as backreference to product key" do
      assert @product.save_to_cache    
      assert_equal 1, Cached.store.read("product/name:#{hash('ipod')}")
      assert_equal 1, Cached.store.read("product/vendor_and_name:#{hash('appleipod')}")
    end                     
    
  end
  
  context "lookups" do
    
    test "product explicit lookup by primary_key" do      
      @product.save_to_cache
      Cached.store.expects(:read).with('product:1', {})
      Product.lookup_by_id(1)
    end
    
    test "product lookup by primary_key" do      
      @product.save_to_cache
      Cached.store.expects(:read).with('product:1', {})
      Product.lookup(1)
    end
    
    test "product lookup by index" do      
      @product.save_to_cache
      Cached.store.expects(:read).with("product/name:#{hash('ipod')}").returns(1)
      Cached.store.expects(:read).with('product:1', {})
      Product.lookup_by_name('ipod')
    end

    test "product lookup by multi index" do      
      @product.save_to_cache
      Cached.store.expects(:read).with("product/vendor_and_name:#{hash('appleipod')}").returns(1)
      Cached.store.expects(:read).with('product:1', {})
      Product.lookup_by_vendor_and_name('apple', 'ipod')
    end
    
  end
    
  private
  
  def hash(text)
    text.hash
  end
  
end


