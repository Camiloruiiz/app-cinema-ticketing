require 'rubygems'
require 'sinatra'

SITE_TITLE = "Cinelandia"
SITE_DESCRIPTION = "Las mejores Películas del mundo mundial."
PELICULA_DE_LA_SEMANA = "Inside Out"


get '/' do
  erb :home
end 

get'/compraform' do
  erb :compraform
end

post '/confirmation' do
  require 'pony'
  
  name = params[:nombre]
  apellido = params[:apellido]
  correo = params[:correo]
  telefono = params[:telefono]
  listfilms = params[:listfilms]
  id = 165
  
  Pony.mail(
      from: 'noreply@cinelandia.com',
      to: correo,
      subject: 'Confirmación compra de Ticket ' + name,
      body: 'Ingresa al siguiente link: http://127.0.0.1:9393/' + name.gsub(/\s/,'-') + '/' + listfilms.gsub(/\s/,'-') + '/' + id.to_s),
      port: '587',
      via: :smtp,
      via_options: { 
        :address              => 'smtp.sendgrid.net', 
        :port                 => '587', 
        :enable_starttls_auto => true, 
        :user_name            => ENV['SENDGRID_USERNAME'], 
        :password             => ENV['SENDGRID_PASSWORD'], 
        :authentication       => :plain, 
        :domain               => 'heroku.com'
      })
  erb :confirmation , :locals => {'name' => name, 'apellido' => apellido, 'correo' => correo, 'telefono' => telefono, 'film' => listfilms}
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