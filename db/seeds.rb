# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email
require 'faker'

Comment.delete_all
Article.delete_all
User.delete_all



Forem::Category.create!(:name => 'Jeux')

user = User.create(
  pseudo: "myzen2",
  nom: Faker::Name.last_name,
  prenom: Faker::Name.first_name,
  email: "admin@example.com",
  password: "admin1234"
)
user.forem_admin = true
user.save!
user.update_attribute(:forem_state, 'approved')

unless user.nil?
  forum = Forem::Forum.create(:category_id => Forem::Category.first.id, :name => "General", :description => "Default forem created by install")

  topic1 = forum.topics.build({ :subject => "Fifa", :posts_attributes => [:text => "Jouez à fifa c'est cool"] })
  topic1.user = user
  topic1.save!

  topic2 = forum.topics.build({ :subject => "LOL", :posts_attributes => [:text => "Super jeu pour faire de l'e-Sport"] })
  topic2.user = user
  topic2.save!

  topic3 = forum.topics.build({ :subject => "Blade and Soul", :posts_attributes => [:text => "C'est super comme jeu."] })
  topic3.user = user
  topic3.save!

  topic4 = forum.topics.build({ :subject => "Day Z", :posts_attributes => [:text => "Tirez sur tout ce qui bouge et sauvez-vous."] })
  topic4.user = user
  topic4.save!

end



50.times do
  user = User.create(
    pseudo: Faker::App.name,
    nom: Faker::Name.last_name,
    prenom: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end


Article.create(
  user_id: user.id,
  titre: Faker::Lorem.sentence,
  contenu: Faker::Lorem.paragraph
)

10.times do
  Article.create(
    user_id: user.id,
    titre: Faker::Lorem.sentence,
    contenu: Faker::Lorem.paragraph()
  )
end

article = Article.create(:user_id => user.id, titre: Faker::Lorem.sentence, contenu: Faker::Lorem.paragraph(2, true, 4))
article.user = user
article.save!

comment = article.comments.build({ :commenter => Faker::Name.name, :body => Faker::Lorem.sentences })
comment.article = article
comment.save!

10.times do
  article.comments.create({
    article_id: article.id,
    commenter: Faker::Name.name,
    body: Faker::Lorem.sentences
  })
end
