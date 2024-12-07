User.delete_all
users = []

1000.times do
  users << { name: Faker::Name.name }
end

User.insert_all(users)

puts "Created #{users.size} users."
