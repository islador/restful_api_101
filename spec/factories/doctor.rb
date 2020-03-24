FactoryBot.define do
  factory :doctor do
    first_name { "First Name" }
    last_name { "Last Name"}
    created_by { "MyString" }
    updated_by { "MyString" }
  end
end