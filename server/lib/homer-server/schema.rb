require 'active_record'

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'clients'
    create_table :clients, :id => false do |table|
      table.column :id,   :string
      table.column :fqdn, :string
      table.column :port, :integer
      table.column :actions, :string
      table.column :label, :string
    end
  end
end