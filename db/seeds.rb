# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Like.delete_all
Comment.delete_all
Article.delete_all
User.delete_all
Transaction.delete_all

# All users have 'password' as their password

u1 = User.create!(email: "test@test.com", username: "user1", reset_password_token: "a",
    reset_password_sent_at: "2023-11-14 22:27:04.475897",
    remember_created_at: "2023-11-14 22:27:04.475897",
    created_at: "2023-11-14 22:27:04.475897",
    updated_at: "2023-11-14 22:27:04.475897",
    password: "password"
)

u2 = User.create!(email: "test2@test.com", username: "user2", reset_password_token: "as",
    reset_password_sent_at: "2023-11-14 22:27:04.475897",
    remember_created_at: "2023-11-14 22:27:04.475897",
    created_at: "2023-11-14 22:27:04.475897",
    updated_at: "2023-11-14 22:27:04.475897",
    password: "password"
)

u3 = User.create!(email: "test3@test.com", username: "user3", reset_password_token: "asd",
    reset_password_sent_at: "2023-11-14 22:27:04.475897",
    remember_created_at: "2023-11-14 22:27:04.475897",
    created_at: "2023-11-14 22:27:04.475897",
    updated_at: "2023-11-14 22:27:04.475897",
    password: "password"
)

p "Created 3 users"

a1 = Article.create!(title: "Article 1", content: "Article 1 content", price: 3, user_id: u1.id, created_at: "2023-11-14 22:27:04.475897", updated_at: "2023-11-14 22:27:04.475897")
a2 = Article.create!(title: "Article 2", content: "Article 2 content", price: 4, user_id: u2.id, created_at: "2023-11-14 22:27:04.475897", updated_at: "2023-11-14 22:27:04.475897")
a3 = Article.create!(title: "Article 3", content: "Article 3 content", price: 5, user_id: u3.id, created_at: "2023-11-14 22:27:04.475897", updated_at: "2023-11-14 22:27:04.475897")
a4 = Article.create!(title: "Article 4", content: "Article 4 content", price: 0, user_id: u3.id, created_at: "2023-11-14 22:27:04.475897", updated_at: "2023-11-14 22:27:04.475897")

p "Created 3 articles"

l1 = Like.create!(user_id: u1.id, article_id: a3.id)
l2 = Like.create!(user_id: u2.id, article_id: a1.id)
l3 = Like.create!(user_id: u3.id, article_id: a2.id)

p "Created 3 likes"

c1 = Comment.create!(article_id: a2.id, user_id: u1.id, content: "comment by test user")
c2 = Comment.create!(article_id: a1.id, user_id: u2.id, content: "test comment111")
c3 = Comment.create!(article_id: a3.id, user_id: u1.id, content: "another test comment")

p "Created 3 comments"