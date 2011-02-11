$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'jtable-rails'

require 'support/rails_app/config/environment.rb'

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'fabricators', '**', '*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    [Person].each do |model|
      model.destroy_all
    end
  end
end