require 'stringio'
require 'test/unit'
require 'rubygems'                                                 
require 'mocha'
require File.dirname(__FILE__) + '/../lib/cached'
                                                                 

class Test::Unit::TestCase
  
  def self.test(string, &block)
    define_method("test:#{string}", &block)
  end
  
  def self.context(string)
    yield
  end
  
end