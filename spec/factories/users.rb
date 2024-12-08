FactoryBot.define do
  factory :user do
    name { "John Doe" }
    clock_in_time { nil }
    clock_out_time { nil }
  end
end