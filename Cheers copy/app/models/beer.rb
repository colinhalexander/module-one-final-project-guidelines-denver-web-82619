class Beer < ActiveRecord::Base
    has_many :reviews    
    has_many :users, through: :reviews
    belongs_to :brewery
    belongs_to :category

    def info_hash
        beer_info = {
            name: self.name,
            abv: self.abv,
            ibu: self.ibu,
            description: self.description,
            brewery: self.brewery.name,
            category: (self.category ? self.category.name : "Uncategorized")
        }
    end
end