require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "OneToOne" do
  before(:each) do
    10.times do |i|
      Fabricate(:person, :place => Fabricate(:place))
    end
    
    @params = {
      :searchable_columns => ["first_name", "last_name", "age", "date_of_birth", "gender", "place_address", "place_city", "place_state"],
      :column_search => {},
      :limit => "5",
      :offset => "0",
      :search => "",
      :sort_column => "",
      :sort_direction => ""
    }
  end
  
  it "Person should load initial set with nested Place" do
    Person.jtable_one_to_one_query(@params).collect(&:jtable_one_to_one_item).to_json.should eql(Person.all.collect(&:jtable_one_to_one_item).to_json)
  end
  
  it "should paginate" do
    Person.jtable_one_to_one_query(@params).jtable_one_to_one_paginate(@params[:limit], @params[:offset]).to_json.should eql(Person.limit(5).offset(0).to_json)
    @params[:offset] = 5
    Person.jtable_one_to_one_query(@params).jtable_one_to_one_paginate(@params[:limit], @params[:offset]).to_json.should eql(Person.limit(5).offset(5).to_json)
  end
  
  it "should search on top level object" do
    person_1 = Fabricate(:person, :place => Fabricate(:place))
    person_2 = Fabricate(:person, :place => Fabricate(:place))
    person_1.first_name = "John"
    person_1.last_name = "Smith"
    person_1.save
    person_2.first_name = "Johnathan"
    person_2.last_name = "Smith"
    person_2.save
    @params[:search] = "john smith"
    Person.jtable_one_to_one_query(@params).to_json.should eql(Person.where(['(first_name LIKE ? OR last_name LIKE ?) AND (first_name LIKE ? OR last_name LIKE ?)', "%john%", "%john%", "%smith%", "%smith%"]).to_json)
  end
  
  it "should search on nested object" do
    place_1 = Person.first.place
    place_2 = Person.last.place
    place_1.state = "Alabama"
    place_1.save
    place_2.state = "Alaska"
    place_2.save
    @params[:search] = "ala"
    Person.jtable_one_to_one_query(@params).to_json.should eql(Person.joins(:place).where(['"places".state LIKE ?', "%ala%"]).to_json)
  end
  
  it "should order on nested object" do
    @params[:sort_column] = "place_state"
    @params[:sort_direction] = "DESC"
    Person.jtable_one_to_one_query(@params).to_json.should eql(Person.joins(:place).order('"places".state DESC').to_json)
  end
  
  it "Person should format an item for jtable with nested place" do
    person = Fabricate(:person, :first_name => "John", :last_name => "Smith", :age => 21, :date_of_birth => 21.years.ago, :gender => "Male", :alive => true, :place => Fabricate(:place, :address => "100 Infinite Loop", :city => "Mountain View", :state => "California"))
    person.jtable_one_to_one_item.should eql({:id => person.id, :first_name => "John", :last_name => "Smith", :age => 21, :date_of_birth => 21.years.ago.strftime("%m/%d/%Y %I:%M%P"), :gender => "Male", :alive => true, :place_address => "100 Infinite Loop", :place_city => "Mountain View", :place_state => "California"})
  end
end