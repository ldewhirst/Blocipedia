include Faker

User.destroy_all
Wiki.destroy_all


15.times do
  User.create!(
    username: Faker::Internet.user_name,
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password(8)
  )
end

users = User.all

30.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample
  )
end

10.times do
  Wiki.create(
  title: Faker::Lorem.sentence,
  body: Faker::Lorem.paragraph,
  user: users.sample,
  private: true
  )
end



puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
