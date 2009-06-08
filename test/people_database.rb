require 'active_record'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => '/tmp/people.db')

ActiveRecord::Schema.define do

  create_table :people, :force => true do |t|
    t.column :first_name, :string
    t.column :last_name, :string
  end
end

