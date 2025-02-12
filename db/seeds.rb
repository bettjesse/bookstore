# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

books = [
  { title: "Weep Not, Child",       author: "Ngũgĩ wa Thiong'o", isbn: "9780435907592" },
  { title: "Damu Nyeusi",      author: "Ken Walibora", isbn: "9780435907608" },
  { title: "The Caucasian Chalk Circle", author: "Bertolt Brecht", isbn: "9780435907622" },
  { title: "Betrayal in the City",        author: "Francis D. Imbuga", isbn: "9780435907615" },
  { title: "Devil on the Cross",      author: "Ngũgĩ wa Thiong'o", isbn: "9780435907646" }
]

books.each do |attrs|
  # Using find_or_create_by! to avoid duplicate entries if seeds are run multiple times
  Book.find_or_create_by!(isbn: attrs[:isbn]) do |book|
    book.title  = attrs[:title]
    book.author = attrs[:author]
  end
end
