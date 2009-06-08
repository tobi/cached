require File.dirname(__FILE__) + '/test_helper.rb'            


class DelegatingProduct < Struct.new(:id, :name, :price, :vendor)
  include Cached::Model

  cache_by_key :id do     
    index :name         
    index [:vendor, :name]    
    
    delegate_to :find
  end  
end

class TestCachedDelegation < Test::Unit::TestCase

  def setup                             
    @delegating_product = DelegatingProduct.new(1, 'ipod', 149.00, 'apple')
  end
  
  
  test "lookup miss will delegate to find method" do        
    DelegatingProduct.expects(:find).with(2)    
    DelegatingProduct.lookup(2)      
  end
      
  test "lookup by index miss will delegate to find_by_index method" do        
    DelegatingProduct.expects(:find).with(2)    
    DelegatingProduct.lookup(2)      
  end
      
  private
  
  def hash(text)
    text.hash
  end
  
end



