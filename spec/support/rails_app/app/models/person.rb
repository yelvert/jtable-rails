class Person < ActiveRecord::Base
  has_one :place
  
  jtable :basic, :first_name, :last_name, :age, :date_of_birth, :gender, :alive
  
  jtable :one_to_one, :first_name, :last_name, :age, :date_of_birth, :gender, :alive, {:place => [:address, :city, :state]}
  
  jtable :custom_attributes, :first_name, :last_name, :date_of_birth
  
  def jtable_custom_attributes_attribute_date_of_birth
    self.date_of_birth.strftime("%m/%d/%Y")
  end
end
