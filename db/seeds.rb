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
Forem::Category.delete_all
Forem::Forum.delete_all


Forem::Category.create!(:name => 'Administration')
Forem::Category.create!(:name => 'Jeux')
Forem::Category.create!(:name => 'Divers')


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
  forum = Forem::Forum.create(:category_id => Forem::Category.first.id, :name => "Administration et Règlement", :description => "Liste de nos serveurs et bien plus.")
  forum = Forem::Forum.create(:category_id => Forem::Category.first.id, :name => "Nous rejoindre", :description => "")
  forum = Forem::Forum.create(:category_id => Forem::Category.first.id, :name => "Events", :description => "Ici vous trouverez les events Dayz et Globaux mais aussi les tournois League Of Legends.")

  forum = Forem::Forum.create(:category_id => Forem::Category.second.id, :name => "League Of Legends", :description => "")
  forum = Forem::Forum.create(:category_id => Forem::Category.second.id, :name => "DayZ", :description => "Default forem created by install")
  forum = Forem::Forum.create(:category_id => Forem::Category.second.id, :name => "Fifa", :description => "Default forem created by install")
  forum = Forem::Forum.create(:category_id => Forem::Category.second.id, :name => "Star Citizen", :description => "Default forem created by install")
  forum = Forem::Forum.create(:category_id => Forem::Category.second.id, :name => "FPS", :description => "Default forem created by install")
  forum = Forem::Forum.create(:category_id => Forem::Category.second.id, :name => "MMO", :description => "Default forem created by install")

  forum = Forem::Forum.create(:category_id => Forem::Category.third.id, :name => "Autres Jeux", :description => "Envie de partager votre jeu du moment, c'est ici !!!")
  forum = Forem::Forum.create(:category_id => Forem::Category.third.id, :name => "La Taverne", :description => "Ici on boit et on parle !!!")
  forum = Forem::Forum.create(:category_id => Forem::Category.third.id, :name => "Médias", :description => "Stream & Vidéo")

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

  forum = Forem::Forum.create(:title => 'First test forum', :description => 'A test forum, for testing with.')
  topic5 = forum.topics.new(:subject => 'A test topic')
  post5 = topic5.posts.build(:text => 'some content.', :user => user)
  topic5.save
  post5.save

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

comment = article.comments.build({ :user_id => user.id, :body => Faker::Lorem.sentences })
comment.article = article
comment.save!

10.times do
  article.comments.create({
    article_id: article.id,
    user_id: user_id,
    body: Faker::Lorem.sentences
  })
end
