FactoryBot.define do
  factory :sleep_record do
    association :user
    clock_in_time { Time.current }
    clock_out_time { clock_in_time + 8.hours }
  end
end
