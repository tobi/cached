require 'cached'

ActiveRecord::Base.send(:include, Cached::Model)
ActiveRecord::Base.send(:include, Cached::Record)