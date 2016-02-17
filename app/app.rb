require 'sinatra'
require 'pony'
require 'dotenv'
Dotenv.load

require './app/ticketing'
require './app/config'

SITE_DESCRIPTION = "The best cinema"
FILM_OF_THE_WEEK = "Sin City"

ledger = TicketsRepo.new

get '/' do
  @site_title = "Cinelandia"
  erb :home
end

post '/confirmation' do
  @site_title = "Confirmation"
  sendmail = Mailer.new(request.host_with_port)
  ticket = Ticket.new(params, ledger)
  Ticketing.purchase(ticket, ledger, sendmail)
  erb :confirmation , :locals => {'ticket' => ticket}
end

get '/ticket/:id' do
  ticket = TicketsRepo.find(params[:id])
  @site_title = "Ticket to #{ticket.list_films}"
  erb :ticket, :locals => {'ticket' => ticket}
end
