# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

mock_user = User.new(
  {
    id: 600,
    email: "foobarman@gmail.com"
  }
)

mock_user.save(validate: false)

mock_user_profile = Profile.new(
  user_id: mock_user.id,
  name: "test_user0",
  birthday: ((Time.now) - 1.month)
)

mock_user_profile.save