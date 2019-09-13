require_relative './config/environment'

def start
    cli = Cli.new
    
    cli.display_cheers_logo
    current_user = new_or_returning_user(cli)

    main_menu(cli, current_user)
end

def new_or_returning_user(cli)
    user_type = cli.prompt_for_new_or_returning_user
    if user_type == "New User"
        cli.display_cheers_logo
        username = cli.prompt_for_new_username
        current_user = User.create(name: username)
    elsif user_type == "Returning User"
        cli.display_cheers_logo
        username = cli.prompt_for_returning_username
        current_user = User.find_by(name: username)
    end
end

def main_menu(cli, current_user)
    cli.display_cheers_logo
    puts "#{current_user.name}'s HomePage"
    menu_selection = cli.main_menu_prompt

    case menu_selection
    when "Find a Beer to Review"
        current_beer = find_a_beer_by_name(cli)
        sleep(0.5)
        leave_a_review(cli, current_user, current_beer)
    when "Get a Recommendation"
        recommendations_menu(cli, current_user)
    when "See My Favorites"
        favorites_page(cli, current_user)
    when "See My Past Reviews"
        reviews_page(cli, current_user)
    when "Log Out"
        cli.log_out
        start
    when "Exit App"
        cli.randy_kings_farewell
        exit
    end
end

def find_a_beer_by_name(cli)
    beer_name = cli.prompt_for_beer_name
    beer = Beer.find_by(name: beer_name)
    if beer
        cli.display_beer_info(beer.info_hash)
        beer
    else
        cli.invalid_beer_name
        sleep(2)
        find_a_beer_by_name(cli)
    end
end

def leave_a_review(cli, current_user, beer)
    review_hash = cli.prompt_for_review
    review_hash[:user_id] = current_user.id
    review_hash[:beer_id] = beer.id
    new_review = Review.create(review_hash)
    reviews_page(cli, current_user)
end

def favorites_page(cli, current_user)
    favorites = current_user.reviews.where(is_favorite: 't').uniq
    cli.display_favorites(favorites)
    cli.return_to_main_menu
    main_menu(cli, current_user)
end

def reviews_page(cli, current_user)
    reviews = current_user.reviews
    cli.display_reviews(reviews)
    cli.return_to_main_menu
    main_menu(cli, current_user)
end

def recommendations_menu(cli, current_user)
    system("clear")
    selection = cli.recommendations_menu_prompt
    case selection 
    when "Recommend a Random Beer"
        beer = random_beer(cli)
        after_recommendation_menu(cli, current_user, beer)
    when "Recommend by Category"
        category = recommend_by_x_menu(cli, Category)
        beer = random_beer_by_category(cli, category)
        after_recommendation_menu(cli, current_user, beer)
    when "Recommend by Brewery"
        brewery = recommend_by_x_menu(cli, Brewery)
        beer = random_beer_by_brewery(cli, brewery)
        after_recommendation_menu(cli, current_user, beer)
    when "Return to Main Menu"
        main_menu(cli, current_user)
    end
end

def random_beer(cli)
    system("clear")
    id = rand(Beer.all.count) + 1
    beer = Beer.find(id)
    cli.display_beer_info(beer.info_hash)
    beer
end

def recommend_by_x_menu(cli, class_type)
    system("clear")
    instances = class_type.pluck(:name)
    selection = cli.prompt_for_instances(instances, class_type.name)
    instance = class_type.find_by(name: selection)
end

def random_beer_by_category(cli, category)
    beers_in_category = Beer.where(category_id: category.id)
    beer = beers_in_category[rand(beers_in_category.count)]
    cli.display_beer_info(beer.info_hash)
    beer
end

def random_beer_by_brewery(cli, brewery)
    beers_in_brewery = Beer.where(brewery_id: brewery.id)
    beer = beers_in_brewery[rand(beers_in_brewery.count)]
    cli.display_beer_info(beer.info_hash)
    beer
end

def after_recommendation_menu(cli, current_user, current_beer)
    selection = cli.prompt_after_recommendation
    case selection
    when "Review this Beer"
        leave_a_review(cli, current_user, current_beer)
    when "Return to Recommendations Menu"
        recommendations_menu(cli, current_user)
    when "Return to Main Menu"
        main_menu(cli, current_user)
    end
end

start



