# clean up
SleepRecord.destroy_all
User.destroy_all

users = []

# Create 1000 users
100.times do
  users << { name: Faker::Name.name }
end
User.insert_all(users)

# Fetch all users to establish relationships
all_users = User.all.to_a

# Create sleep records and follow relationships
all_users.each do |user|
  # Create sleep records for each user
  rand(10..20).times do
    # Random sleep time within the last week
    sleep_time = Faker::Time.between(from: Time.current - 7.days, to: Time.current)
    # Random wake time between 1 to 8 hours later
    wake_time = sleep_time + rand(1..8).hours
    user.sleep!(sleep_time)
    user.wake_up!(wake_time)
  end

  # Make the user follow random users
  following_users = all_users.sample(rand(1..20)) # Randomly select up to 20 users
  following_users.each do |followed_user|
    user.follow(followed_user) unless user == followed_user || user.following.include?(followed_user)
  end
end
