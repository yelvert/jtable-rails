Fabricator(:place) do
  address   {Fabricate.sequence(:place_address) {|i| "#{i} Some Rd."}}
  city      {Fabricate.sequence(:place_city) {|i| "City #{i}"}}
  state     {Fabricate.sequence(:place_state) {|i| "State #{i}"}}
end