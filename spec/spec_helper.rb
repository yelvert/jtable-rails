$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'jtable-rails'

require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite",
  :database => "#{File.dirname(__FILE__)}/support/db/test.sqlite"
)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
end