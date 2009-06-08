$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'

module Cached
  VERSION = '0.5.0' 
  
  mattr_accessor :store
  self.store = ActiveSupport::Cache.lookup_store(:memory_store)
end            


require 'cached/config'
require 'cached/config_compiler'
require 'cached/model'