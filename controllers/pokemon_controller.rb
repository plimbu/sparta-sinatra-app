class PokemonController < Sinatra::Base
    #tricks ruby to make it look for erb in a different file called views
    # sets root as the parent-directory of the current file
    set :root, File.join(File.dirname(__FILE__), '..')
    # sets the view directory correctly
    set :views, Proc.new { File.join(root, "views") }

    configure :development do
      register Sinatra::Reloader
    end

    #index
    get "/" do
      @pokemons = Pokemon.all

      erb :"posts/index"
    end

    #new
    get "/new" do
      pokemon = Pokemon.new
      @pokemon = pokemon
      pokemon.id =""
      pokemon.pokemon =""
      pokemon.body =""
      erb :"posts/new"
    end

    #show
    get "/:id" do
      id = params[:id].to_i
       @pokemon = Pokemon.find(id)
       erb :"posts/show"
     end

    #create
    post "/" do
      pokemon = Pokemon.new
      #set pokemon values
      pokemon.pokemon = params[:pokemon]
      pokemon.body = params[:body]
      pokemon.save
      redirect "/"
    end

    #edit
    get "/:id/edit" do
      id = params[:id].to_i
      @pokemon = Pokemon.find(id)
      erb :"posts/edit"
    end

    #update
    put "/:id" do
      id = params[:id].to_i
      pokemon = Pokemon.find(id)
      pokemon.pokemon = params[:pokemon]
      pokemon.body = params[:body]
      pokemon.save
      redirect "/"
    end

    #delete
    delete "/:id" do
      id = params[:id].to_i
      Pokemon.destroy(id)
      redirect "/"
    end
end
