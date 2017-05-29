100.times do
  Article.create({ title: Faker::Name.title, body: Faker::Lorem.paragraph })
end
