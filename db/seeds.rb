# frozen_string_literal: true

50.times do |i|
  Product.create(
    title: Faker::Food.ingredient,
    price: (1..50).to_a.sample * i,
    description: Faker::Lorem.paragraphs(6).join,
    remote_image_url: Faker::LoremPixel.image("1920x1080", false, "food")
  )
end

50.times do
  User.create(
    name: Faker::StarWars.character,
    email: Faker::Internet.email,
    password: (password = SecureRandom.hex),
    password_confirmation: password
  )
end
