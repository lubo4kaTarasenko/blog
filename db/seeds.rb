# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

authors = 5.times do
  name = Faker::Name.unique.name.split(' ')
  Author.create(
    { 
      first_name: name.first,
      last_name: name.last,
      gender: Faker::Gender.binary_type,
      birthday: Faker::Date.between(from: '1970-09-23', to: '2007-09-25')
     }
  )
end     