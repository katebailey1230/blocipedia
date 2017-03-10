require 'random_data'
 # Create Users
 5.times do
   user = User.create!(
   name:     RandomData.random_name,
   email:    Faker::Internet.email,
   password: RandomData.random_sentence
   )
 users = User.all
end

25.times do
  Wiki.create!(
    title: Faker::Beer.unique.name,
    body: Faker::Lorem.paragraphs(2),
    private: false,
    user_id: User.all.sample.id
  )
wiki = Wiki.all
end

Wiki.create!(
  title: 'My Very First Markdown Wiki',
  body:
  %Q{### There Is Something You Should Know!
  This is my very first post using markdown!
  How do you like it?},
  user_id: User.all.sample.id
)
