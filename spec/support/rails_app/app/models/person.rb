class Person < ActiveRecord::Base
  has_one :place
  
  jtable :basic, :first_name, :last_name, :age, :date_of_birth, :gender, :alive
  
  jtable :one_to_one, :first_name, :last_name, :age, :date_of_birth, :gender, :alive, {:place => [:address, :city, :state]}
end
