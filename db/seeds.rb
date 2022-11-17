puts "🌱 Seeding data..."

# Make 10 users
15.times do
    user = User.create(full_name: Faker::Name.name, email_address: Faker::Internet.email, gender: Faker::Gender.binary_type, password: Faker::Internet.password)
end

20.times do
    # create a car with random data
    car = Car.create(make: Faker::Vehicle.make, model: Faker::Vehicle.model, price: Faker::Commerce.price, image_url: Faker::LoremFlickr.image) #LoremFlickr

    rand(1..5).times do
        user = User.order('RANDOM()').first

        Review.create(
        score: rand(1..10),
        comment: Faker::Lorem.sentence,
        car_id: car.id,
        user_id: user.id
        )
    end
end

puts "🌱 Done seeding!"