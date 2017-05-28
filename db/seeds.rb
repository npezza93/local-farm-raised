# frozen_string_literal: true

50.times do |i|
  Product.create(
    title: Faker::Food.ingredient,
    price: (1..50).to_a.sample * i,
    description: Faker::Lorem.paragraphs(6).join,
    remote_image_url: Faker::LoremPixel.image
  )
end
