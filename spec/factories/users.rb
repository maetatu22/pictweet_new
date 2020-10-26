FactoryBot.define do
  factory :user do
    nickname               {"abe"}
    email                  {"kkk@gmail.com"} 
    password               {"00000000"} 
    password_confirmation  {password}
  end
end
