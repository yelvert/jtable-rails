class Person < ActiveRecord::Base
  jtable :first_name, :last_name, :age, :date_of_birth, :gender, :alive
end
