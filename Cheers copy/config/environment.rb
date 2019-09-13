require "require_all"
require 'sinatra/activerecord'
require 'pry'

require_all './app'

ActiveRecord::Base.establish_connection({
    :adapter => 'sqlite3', 
    :database => 'db/cheers.db'
})

ActiveRecord::Base.logger = nil