require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Person" do
  it "should have the jtable scopes and methods" do
    Person.respond_to?(:jtable_query).should be_true
  end
end