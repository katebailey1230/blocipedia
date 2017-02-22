require 'random_data'
 # Create Users
 5.times do
   user = User.create!(
   name:     RandomData.random_name,
   email:    RandomData.random_name,
   password: RandomData.random_sentence
   )
 end
 users = User.all

puts "#{User.count} users created"