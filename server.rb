require 'sinatra'
require 'CSV'
require 'pry'

def give_me_movies
  movies = {}

  CSV.foreach('movies.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
    movies[row.fields[0]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
  end


  movies = movies.sort_by do |k, v|
    v[:title].to_s
  end
  return movies
end

def get_movie key
  movies = {}
  CSV.foreach('movies.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
    movies[row.fields[0]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
  end
  return movies[key]
end


get '/' do
  @movies = give_me_movies

  erb :index
end

get '/movies/:movie' do

  @this_movie = params[:movie]
  @movie = get_movie @this_movie.to_i

  erb :movies
end
