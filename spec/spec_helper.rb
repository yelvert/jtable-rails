$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'jtable-rails'

require 'support/rails_app/config/environment.rb'

RSpec.configure do |config|
end