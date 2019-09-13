class User < ActiveRecord::Base
    has_many :reviews
    has_many :beers, through: :reviews
end