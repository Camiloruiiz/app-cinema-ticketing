require 'rubygems'
require 'sinatra'
require 'pony'

SITE_TITLE = "Cinelandia"
SITE_DESCRIPTION = "Las mejores Películas del mundo mundial."
PELICULA_DE_LA_SEMANA = "Inside Out"

class RegisterPurchase
end

get '/' do
  erb :home
end 

get'/compraform' do
  erb :compraform
end

post '/confirmation' do
  name = params[:nombre]
  apellido = params[:apellido]
  correo = params[:correo]
  telefono = params[:telefono]
  listfilms = params[:listfilms]
  
  Pony.mail(:to => correo, :from => 'noreply@cinelandia.com', :subject => 'Confirmación compra de Ticket' + name, :body => 'ingresa al siguiente link:', :via => :smtp)
  
  erb :confirmation , :locals => {'name' => name, 'apellido' => apellido, 'correo' => correo, 'telefono' => telefono, 'film' => listfilms}
end