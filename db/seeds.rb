# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'toshino@elzup.com', password: 'password')

puts "#{User.count} User created"

user.missions.create(title: 'テストミッション1', description: 'これはテストミッションの詳細分です。')
user.missions.create(title: 'テストミッション2', description: '長い詳細文。' * 10)

puts "#{Mission.count} Mission created"
