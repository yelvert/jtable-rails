require 'jtable-rails/version'
require 'rails/all'
require 'jtable-rails/active_record'
require 'jtable-rails/action_controller'
::ActiveRecord::Base.send(:include, JTable::ActiveRecord) if defined? ::ActiveRecord
::ActionController::Base.send(:include, JTable::ActionController) if defined? ::ActionController
module JTable
  require 'jtable-rails/railtie' if defined?(Rails)
end