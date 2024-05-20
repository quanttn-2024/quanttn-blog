User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', role: :admin)
User.create!(name: 'User1', email: 'user1@example.com', password: 'password', role: :user)
User.create!(name: 'User2', email: 'user2@example.com', password: 'password', role: :user)

10.times do |i|
  User.first.posts.create!(title: "Post #{i}", content: "Content for post #{i}", image: "image#{i}.jpg")
end
