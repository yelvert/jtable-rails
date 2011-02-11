Fabricator(:person) do
  [:first_name, :last_name, :age, :date_of_birth, :gender, :alive]
  first_name    {Fabricate.sequence(:person_first_name) {|i| "FirstName #{i}"}}
  last_name     {Fabricate.sequence(:person_last_name) {|i| "LastName #{i}"}}
  age           {Fabricate.sequence(:person_age)}
  date_of_birth {Fabricate.sequence(:person_date_of_birth).years.ago}
  gender        {Fabricate.sequence(:person_gender) {|i| i%2==0 ? "Male" : "Female"}}
  alive         {rand(10).even?}
end