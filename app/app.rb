require 'sinatra'
require 'pony'
require './app/ticketing'
require './app/config'

SITE_DESCRIPTION = "The best cinema"
FILM_OF_THE_WEEK = "Inside Out"

configure :production do
  Pony.options = {
  :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
end

configure :development do
  Pony.options = {
  :via => :smtp,
    :via_options => {
      :address => 'smtp.gmail.com',
      :port => '587',
      :domain => "localhost.localdomain",
      :user_name => 'camilorojas@esquemacreativo.com',
      :password => 'CRojas.92',
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
end

get '/' do
  @site_title = "Cinelandia"
  erb :home
end

get'/form' do
  @site_title = "Form"
  erb :form
end

post '/confirmation' do
  @site_title = "Confirmation"
  Ticketing.new.purchase(params, request.host_with_port)
  erb :confirmation , :locals => {'ticket' => params}
end

get '/ticket/:id' do
  @site_title = "Happy Movie"
  erb :ticket, :locals => {'id' => params[:id], 'records' => RecordsManagement.all}
end
