require_relative "./config/environment.rb"
require 'sinatra/activerecord/rake'
require 'sqlite3'
require 'csv'


# desc "parse csv"
# task :csv do 
#   db = SQLite3::Database.new("db/cheers.db")
#   db.execute("CREATE TABLE IF NOT EXISTS beers (
#     id INTEGER PRIMARY KEY,
#     name,
#     abv,
#     ibu,
#     description,
#     brewery_id,
#     category_id
#   )")

#   csv_text = File.read("beers_edit.csv")
#   csv = CSV.parse(csv_text, :headers => true)
#   csv.each do |row|
#     db.execute("INSERT INTO beers (
#       name,
#       abv,
#       ibu,
#       description,
#       brewery_id,
#       category_id
#       ) VALUES(?, ?, ?, ?, ?, ?)",
#       row[csv.headers.first], row["abv"], row["ibu"], row["description"], row["brewery_id"], row["category_id"]
#       )
#   end
# end 