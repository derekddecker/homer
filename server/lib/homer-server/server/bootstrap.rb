require 'active_record'
require 'sqlite3'
require 'angelo'
require 'mustermann'
require 'securerandom'
require 'net/http'
require_relative 'settings'

CONFIG = Homer::Server::Settings.from_config
APP_ROOT = File.dirname(__FILE__)

ActiveRecord::Base.establish_connection(
  adapter:  CONFIG.db_adapter,
  database: CONFIG.db_name
)

require 'homer-server/schema'