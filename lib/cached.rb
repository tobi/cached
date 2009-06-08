$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Cached
  VERSION = '0.5.0' 
  
  mattr_accessor :store
end            


require 'cached/config'
require 'cached/config_compiler'
require 'cached/model'