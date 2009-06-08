require File.dirname(__FILE__) + '/test_helper.rb'                                 
require File.dirname(__FILE__) + '/people_database'

require 'cached/record'

class Person < ActiveRecord::Base  
  include Cached::Model
  include Cached::Record
  
  def name
    "#{first_name} #{last_name}"
  end
  
  cache_by_key :id do     
    index :first_name
    index :last_name         
    index [:first_name, :last_name]
    
    #delegate_to :find
  end
end

class TestRecord < Test::Unit::TestCase
    
  def setup                             
    @bob = Person.create(:first_name => 'Bob', :last_name => 'Bobsen')
  end
  
  test "load bob from cache store" do
    @bob.save_to_cache
    
    assert_equal @bob, Person.find_by_first_name('Bob')
    assert_equal @bob, Person.find_by_last_name('Bobsen')
    assert_equal @bob, Person.find_by_first_name_and_last_name('Bob', 'Bobsen')
    
  end
    
  private
  
  def hash(text)
    text.hash
  end
  
end
