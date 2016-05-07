# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all
Post.destroy_all
Comment.destroy_all

users = []
posts = []

30.times do
	users << User.create(password: '1', name: Faker::Name.name , email: Faker::Internet.email, blog_title: Faker::Book.title, blog_cat: "general")
end

users.each do |user|
	4.times do 
		posts << Post.create(user_id: user.id, title: Faker::Company.catch_phrase, desc: Faker::StarWars.quote ,body: Faker::Hipster.paragraph(10, false, 20), img_url: Faker::Avatar.image("my-img", "400x350"))
		Comment.create(user_id: user.id, post_id: posts.sample.id, body: Faker::Hacker.say_something_smart)
	end
end