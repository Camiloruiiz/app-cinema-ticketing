require 'rubygems'
require 'sinatra'
require "sinatra/config_file"
require 'pony'

config_file 'config/application.yml'

SITE_TITLE = "Cinelandia"
SITE_DESCRIPTION = "Las mejores Películas del mundo mundial."
PELICULA_DE_LA_SEMANA = "Inside Out"

db = Hash.new
id = Hash.new

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
  
get '/' do
  erb :home
end 

get'/compraform' do
  erb :compraform
end

post '/confirmation' do

  @hostname = request.host
  
  db = {
    :name => params[:nombre],
    :apellido => params[:apellido],
    :correo => params[:correo],
    :telefono => params[:telefono],
    :listfilms => params[:listfilms]
    }
    
    a = id.map{|k,v| k.max+1}
    id[a] = db
  
  Pony.mail(:from => 'noreply@esquemacreativo.com', :subject=> 'Confirmación compra de Ticket ' + db[:name], :to => db[:correo], :body => 'Ingresa al siguiente link: http://' + @hostname +'/' + db[:name].gsub(/\s/,'-') + '/' + db[:listfilms].gsub(/\s/,'-') + '/')

  erb :confirmation , :locals => {'name' => db[:name], 'apellido' => db[:apellido], 'correo' => db[:correo], 'telefono' => db[:telefono], 'film' => db[:listfilms]}
end

get '/ticket' do
  erb :ticket
end

get '/:name/:listfilms/:id' do
  name = params[:name]
  listfilms = params[:listfilms]
  id = params[:id]
  erb :ticket, :locals => {'name' => name, 'film' => listfilms, 'id' => id}
end