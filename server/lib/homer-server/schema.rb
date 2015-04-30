require 'active_record'

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'clients'
    create_table :clients do |table|
      table.column :fqdn, :string, :null => false
      table.column :port, :integer, :null => false
      table.column :api_key, :string, :null => false
      table.timestamps :null => false
    end
  end

  unless ActiveRecord::Base.connection.tables.include? 'services'
    create_table :services do |table|
      table.column :client_id, :integer, :null => false
      table.column :labels, :string
      table.column :locations, :string
      table.column :actions, :string
      table.timestamps :null => false
    end
  end
end