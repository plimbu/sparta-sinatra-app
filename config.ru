#main configuration for rack which runs and controlls controllers
#require files

require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development? #runs reloader if development is true
require "sinatra/cookies"
require "pg"
require_relative "models/post.rb"
require_relative "controllers/pokemon_controller.rb"


#run MethodOverride and PostsController
use Rack::MethodOverride
run PokemonController
