require 'rubygems'
require 'sinatra'

SITE_TITLE = "Cinelandia"
SITE_DESCRIPTION = "Las mejores Películas del mundo mundial."
PELICULA_DE_LA_SEMANA = "Inside Out"

get '/' do
  erb :form
end 

