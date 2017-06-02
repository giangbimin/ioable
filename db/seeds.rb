10.times do
  User.create({ email: Faker::Internet.email, password: '12345678', password_confirmation: '12345678', name: Faker::Name.name})
end
User.all.each do |user|
  10.times do
    user.articles.create(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph(2, false, 4),
      body: Faker::Lorem.paragraph(7, false, 4),
      tag_list: (Faker::Job.key_skill+', '+Faker::Job.key_skill+', '+Faker::Job.key_skill).to_s)
  end
end
Article.all.each do |article|
  article.comments.create(user_id: User.first.id, body: Faker::Lorem.paragraph(2))
  article.comments.create(user_id: User.second.id, body: Faker::Lorem.paragraph(2))
end
