require 'sinatra'
require 'pony'
require "dotenv"
Dotenv.load

require './app/ticketing'
require './app/config'

SITE_DESCRIPTION = "The best cinema"
FILM_OF_THE_WEEK = "Sin City"

get '/' do
  @site_title = "Cinelandia"
  erb :home
end

post '/confirmation' do
  @site_title = "Confirmation"
  Ticketing.new.purchase(params, request.host_with_port)
  erb :confirmation , :locals => {'ticket' => params}
end

get '/ticket/:id' do
  @site_title = "Ticket to #{RecordsManagement.all[params[:id].to_i][:list_films]}"
  erb :ticket, :locals => {'id' => params[:id], 'records' => RecordsManagement.all}
end
