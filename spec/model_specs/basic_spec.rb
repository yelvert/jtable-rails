require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Basic" do
  before(:each) do
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
  
  it "should have the jtable scopes and methods" do
    Person.respond_to?(:jtable).should be_true
    Person.respond_to?(:jtable_basic_search).should be_true
    Person.respond_to?(:jtable_basic_single_search).should be_true
    Person.respond_to?(:jtable_basic_order).should be_true
    Person.respond_to?(:jtable_basic_paginate).should be_true
    Person.respond_to?(:jtable_basic_default).should be_true
    Person.respond_to?(:jtable_basic_query).should be_true
    [:first_name, :last_name, :age, :date_of_birth, :gender, :alive].each do |attribute|
      Person.respond_to?("jtable_basic_search_#{attribute}").should be_true
      Person.respond_to?("jtable_basic_order_#{attribute}").should be_true
      Person.respond_to?("jtable_basic_attributes").should be_true
      Person.new.respond_to?("jtable_basic_attribute_#{attribute}").should be_true
      Person.new.respond_to?("jtable_basic_item").should be_true
    end
  end
  
  it "should know jtables attributes" do
    Person.jtable_basic_attributes.should eql([:first_name, :last_name, :age, :date_of_birth, :gender, :alive])
  end
  
  it "should load initial set" do
    Person.jtable_basic_query(@params).to_json.should eql(Person.all.to_json)
  end
  
  it "should paginate" do
    Person.jtable_basic_query(@params).jtable_basic_paginate(@params[:limit], @params[:offset]).to_json.should eql(Person.limit(5).offset(0).to_json)
    @params[:offset] = 5
    Person.jtable_basic_query(@params).jtable_basic_paginate(@params[:limit], @params[:offset]).to_json.should eql(Person.limit(5).offset(5).to_json)
  end
  
  it "should search" do
    person_1 = Person.first
    person_2 = Person.last
    person_1.first_name = "John"
    person_1.last_name = "Smith"
    person_1.save
    person_2.first_name = "Johnathan"
    person_2.last_name = "Smith"
    person_2.save
    @params[:search] = "john smith"
    Person.jtable_basic_query(@params).to_json.should eql(Person.where(['(first_name LIKE ? OR last_name LIKE ?) AND (first_name LIKE ? OR last_name LIKE ?)', "%john%", "%john%", "%smith%", "%smith%"]).to_json)
  end
  
  it "should single column search" do
    person_1 = Person.first
    person_2 = Person.last
    person_1.first_name = "John"
    person_1.save
    person_2.first_name = "Johnathan"
    person_2.save
    @params[:column_search][:first_name] = "john"
    Person.jtable_basic_query(@params).to_json.should eql(Person.where(['(first_name LIKE ?)', "%john%"]).to_json)
  end
  
  it "should order" do
    @params[:sort_column] = "age"
    @params[:sort_direction] = "ASC"
    Person.jtable_basic_query(@params).to_json.should eql(Person.order('age ASC').to_json)
  end
  
  it "should format an item for jtable" do
    person = Fabricate(:person, :first_name => "John", :last_name => "Smith", :age => 21, :date_of_birth => 21.years.ago, :gender => "Male", :alive => true)
    person.jtable_basic_item.should eql({:id => person.id, :first_name => "John", :last_name => "Smith", :age => 21, :date_of_birth => 21.years.ago.strftime("%m/%d/%Y %I:%M%P"), :gender => "Male", :alive => true})
  end
end