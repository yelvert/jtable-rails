class Person < ActiveRecord::Base
  jtable :basic, :first_name, :last_name, :age, :date_of_birth, :gender, :alive
end
