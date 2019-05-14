require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  arr = []
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  hash_results = response_hash["results"]
  

  hash_results.collect do |each_char_hash|
    if each_char_hash["name"] == character_name
      each_char_hash["films"].collect do |each_url|
        response_url = RestClient.get(each_url)
        response_hash_film = JSON.parse(response_url)
        arr << response_hash_film
      end
    end
  end
  arr
end

def print_movies(films_array)

  films_array.each do |film|
    puts film["title"] 
  end
  
  # some iteration magic and puts out the movies in a nice list

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


# binding.pry
# get_character_movies_from_api("Luke Skywalker")


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
