require "tty-prompt"
require "tty-box"
require "paint"
require "pry"

class Cli
    attr_reader :prompt
    
    def initialize
        @prompt = TTY::Prompt.new
    end

    def prompt_for_beer_name
        system("clear")
        prompt.ask('Please enter the name of a beer:')
    end

    def display_beer_info(beer_info)
        system("clear")
        puts "Here is your beer's information:"
        puts "================================="
        puts "Name: #{beer_info[:name]}"
        puts "Brewery: #{beer_info[:brewery]}"
        puts "Category: #{beer_info[:category]}"
        if beer_info[:abv] > 0
            puts "ABV: #{beer_info[:abv]}%"
        else
            puts "ABV: Unavailable"
        end
        puts "IBU: #{beer_info[:ibu]}"
        if beer_info[:description] != nil
            puts "Description: #{beer_info[:description]}"
        else
            puts "Description: Tasty beer!"
        end
        puts "================================="
    end 

    def invalid_beer_name
        puts "Sorry, we can't find your beer in our database."
        puts "Please try again."
    end

    def prompt_for_review
        rating = prompt_for_rating.to_i
        content = prompt_for_content
        if prompt_for_favorite == "yes"
            is_favorite = true
        else 
            is_favorite = false
        end

        review_hash = {
            rating: rating,
            content: content,
            is_favorite: is_favorite
        }
    end

    def prompt_for_favorite
        prompt.select("Would you like to save this beer to your favorites?", %w(yes no))
    end

    def prompt_for_content
        prompt.ask("Please leave a review of your beer:")
    end

    def prompt_for_rating
      choices = %w(1 2 3 4 5)
      prompt.select("Rate your beer:", choices)    
    end

    def display_cheers_logo
        system("clear")
        box = TTY::Box.frame(width: 68, height: 10) do 
            "             _____ _    _ ______ ______ _____   _____ 
            / ____| |  | |  ____|  ____|  __ \\ / ____|
           | |    | |__| | |__  | |__  | |__) | (___  
           | |    |  __  |  __| |  __| |  _  / \\___ \\ 
           | |____| |  | | |____| |____| | \\ \\ ____) |
            \\_____|_|  |_|______|______|_|  \\_\\_____/ 

                       RATE YOUR BEER HERE!
            "
        end
        print box
    end

    def prompt_for_new_or_returning_user
        prompt.select("Are you a new or returning user?", ["Returning User", "New User"])
    end

    def prompt_for_new_username
        prompt.ask("Please enter your new username:")
    end

    def prompt_for_returning_username
        user_names = User.pluck(:name)
        prompt.select("Please select your username", user_names)
    end

    def main_menu_prompt
        menu_options = ["Find a Beer to Review", "Get a Recommendation", "See My Favorites", "See My Past Reviews", "Log Out", "Exit App"]
        prompt.select("What would you like to do?", menu_options)
    end

    def display_favorites(favorites)
        system("clear")
        puts "These are your favorited beers:"
        favorites.each do |favorite| 
            puts "• #{favorite.beer.name}"
        end
    end

    def display_reviews(reviews)
        system("clear")
        puts "These are your past reviews:"
        reviews.each do |review| 
            puts "• #{review.beer.name} - #{review.rating}/5"
        end
    end

    def log_out
        system("clear")
        puts "Logging you out."
        sleep(0.5)
        system("clear")
        puts "Logging you out.."
        sleep(0.5)
        system("clear")
        puts "Logging you out..."
        sleep(0.5)
        puts "Come back soon!"
        sleep(1)
    end

    def recommendations_menu_prompt
        prompt.select("How would you like to get your recommendation?", ["Recommend a Random Beer",
    "Recommend by Category", "Recommend by Brewery", "Return to Main Menu"])
    end

    def prompt_after_recommendation
        prompt.select("What would you like to do?", ["Review this Beer", "Return to Recommendations Menu", "Return to Main Menu"])
    end

    def prompt_for_instances(instances, class_name)
        prompt.select("Which #{class_name.downcase} would you like a recommendation from?", instances)
    end

    def return_to_main_menu
        prompt.select("", ["Return to Main Menu"])
    end

    def randy_king
".===================================================================.
||                                                                 ||
||                            ___                                  ||
||                          .'   '.                                ||
||        See ya!          /       \\           oOoOo               ||
||                        |         |       ,==|||||               ||
||                         \\       /       _|| |||||               ||
||                          '.___.'    _.-'^|| |||||               ||
||                        __/_______.-'     '==HHHHH               ||
||                   _.-'` /                                       ||
||                .-'     /   oOoOo                                ||
||                `-._   / ,==|||||                                ||
||                    '-/._|| |||||                                ||
||                     /  ^|| |||||                                ||
||                    /    '==HHHHH                                ||
||                   /________                                     ||
||                   `\\       `\\                                   ||
||                     \\        `\\   /                             ||
||                      \\         `\\/                              ||
||                      /                                          ||
||                     /                                           ||
||                    /_____                                       ||
||                                                                 ||
'==================================================================='"
    end

    def randy_kings_farewell
        colors = [:blue, :red, :green]
        2.times do 
            colors.each do |color|
                system("clear")
                puts Paint[randy_king, color]
                sleep(0.5)
            end
        end
    end
end