class Pokemon
  #set up our attribute accessor to listen for these parameteres for this class
  #so if we make an object than it will have these parameteres
  attr_accessor :id, :pokemon, :body

  #open up connection to our database
  def self.open_connection
    conn = PG.connect dbname: "pokemon", user: "postgres", password: "Acad3my1"
  end
  #conn is an instance/hash storing all data from pokemon database

  def self.all
    #get connection from database using function and store it in conn
    conn = self.open_connection
    #sql command
    sql = "SELECT * FROM pokemon ORDER BY id"
    #results = whataever sql returns when running sql command
    results = conn.exec(sql)
    #go through database and make post = to it while also hydrating it to get what we want which is :id, :pokemon and :body
    pokemons = results.map do |data|
      self.hydrate data
    end
    #return posts after hydrating our data from the database
    return pokemons
  end

  #hydrate function to get data we want and get rid of things we don't want
  def self.hydrate post_data
    #create an instance of the class and then set it's values to what we got from the parameters
    pokemon = Pokemon.new
    pokemon.id = post_data["id"]
    pokemon.pokemon = post_data["pokemon"]
    pokemon.body = post_data["body"]
    return pokemon
  end

  #find id function to find data that corresponds with id
  def self.find id
    conn = self.open_connection
    #find all from pokemon where there id = the id in the parameter
    sql = "SELECT * FROM pokemon WHERE id = #{id}"
    pokemon = conn.exec(sql)
    #return hydrated data for the id entered in user parameter
    return self.hydrate pokemon[0]
  end

  #save function for update and edit to save data user has entered and insert it into our database
  def save
    conn = Pokemon.open_connection
    #if no id then we are creating else we are updating
    if !self.id
      sql = "INSERT INTO pokemon (pokemon, body) VALUES ('#{self.pokemon}', '#{self.body}')"
    else
      sql = "UPDATE pokemon SET pokemon='#{self.pokemon}', body='#{self.body}' WHERE id = '#{self.id}'"
    end
    #run the sql command by sending it to connection to database
    conn.exec(sql)
  end

  #destroy function
  def self.destroy id
    conn = self.open_connection
    sql ="DELETE FROM pokemon WHERE id = #{id}"
    conn.exec(sql)
  end
end
