require 'stringio'
require 'test/unit'
require 'rubygems'                                                 
require 'mocha'
require File.dirname(__FILE__) + '/../lib/cached'
              
require 'active_support/cache'
require 'active_record'

Cached.store = ActiveSupport::Cache.lookup_store(:memory_store)
#Cached.store = ActiveSupport::Cache.lookup_store(:mem_cache_store)
                                                                 

class Test::Unit::TestCase
  
  def self.test(string, &block)
    define_method("test:#{string}", &block)
  end
  
  def self.context(string)
    yield
  end
  
end