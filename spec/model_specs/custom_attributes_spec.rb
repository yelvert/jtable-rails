require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Custom Attributes" do
  before(:each) do
    @person = Fabricate(:person, :place => Fabricate(:place))
    
    @params = {
      :searchable_columns => ["first_name", "last_name", "age", "date_of_birth", "gender"],
      :column_search => {},
      :limit => "5",
      :offset => "0",
      :search => "",
      :sort_column => "",
      :sort_direction => ""
    }
  end
  
  it "should return the correctly formatted attributes" do
    date = 10.years.ago
    @person.date_of_birth = date
    @person.jtable_custom_attributes_attribute_date_of_birth.should eql(date.strftime("%m/%d/%Y"))
  end
end