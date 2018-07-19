class PokemonController < Sinatra::Base




  #IMPORTANT
  #tricks ruby to make it look for erb in a different file called views
    # sets root as the parent-directory of the current file
    set :root, File.join(File.dirname(__FILE__), '..')

    # sets the view directory correctly
    set :views, Proc.new { File.join(root, "views") }







    configure :development do
      register Sinatra::Reloader
    end



    #INDEX
    get "/" do
    "hello"
    end

    #new
    get "/new" do
      "new route"

    end


    #show
    get "/:id" do
      id = params[:id].to_i
      "you are on #{id}"



    end

    #create
    post "/" do
      redirect "/"

    end


    #edit
    put "/:id/edit" do

      "this is the edit route"

    end

    #update
    post "/:id" do
      redirect "/"
    end

    delete "/:id" do
      id = params[:id].to_i
      redirect "/"
    end








end
