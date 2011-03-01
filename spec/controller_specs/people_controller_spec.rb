require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "PeopleController" do
  before(:each) do
    @people_controller = PeopleController.new
    
    10.times do |i|
      Fabricate(:person)
    end
    
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
  
  it "should have the jtable_for_json method" do
    @people_controller.respond_to?(:jtable_for_json).should be_true
  end
  
  it "should return the appropriate json" do
    people = Person.jtable_query(@params)
    jtable_items = people.jtable_paginate(@params[:limit], @params[:offset]).collect(&:jtable_item)
    @people_controller.jtable_for_json(people, @params).to_json.should eql({:total_items => people.count, :items => jtable_items}.to_json)
  end
end