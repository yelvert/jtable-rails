require 'rails/all'
require 'jtable-rails/active_record'
require 'jtable-rails/action_controller'
::ActiveRecord::Base.send(:include, JTable::ActiveRecord) if defined? ::ActiveRecord
::ActionController::Base.send(:include, JTable::ActionController) if defined? ::ActionController