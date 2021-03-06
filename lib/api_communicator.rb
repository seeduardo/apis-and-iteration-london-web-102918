require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  char_stats = response_hash["results"].select do |char|
    char["name"].downcase == character
  end

  if char_stats == []
    puts "Star Wars character not found! Please check spelling and try again."
  else

    char_films = char_stats[0]["films"]

    char_films.map do |film_link|
      JSON.parse(RestClient.get(film_link))["title"]
    end
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

end

def print_movies(films_array)
  # some iteration magic and puts out the movies in a nice list
  puts "This character appears in these films:"
  films_array.each do |film|
    puts film
  end

end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
    if films_array != nil
    print_movies(films_array)
  end
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
