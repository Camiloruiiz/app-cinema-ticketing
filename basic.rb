require 'rubygems'
require 'sinatra'
require 'pony'

SITE_TITLE = "Cinelandia"
SITE_DESCRIPTION = "Lo mejor del Cine"
PELICULA_DE_LA_SEMANA = "Inside Out"

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

  @hostname = request.host_with_port
  
  db = {
    :name => params[:nombre],
    :apellido => params[:apellido],
    :correo => params[:correo],
    :telefono => params[:telefono],
    :listfilms => params[:listfilms]
    }

  Pony.mail(:from => 'noreply@esquemacreativo.com', :subject=> 'Confirmación compra de Ticket ' + db[:name], :to => db[:correo], :body => 'Ingresa al siguiente link: http://' + @hostname + '/ticket/' + db[:name].gsub(/\s/,'-') + '/' + db[:listfilms].gsub(/\s/,'-') + '/3')

  erb :confirmation , :locals => {'name' => db[:name], 'apellido' => db[:apellido], 'correo' => db[:correo], 'telefono' => db[:telefono], 'film' => db[:listfilms]}
end

get '/ticket/:name/:listfilms/:id' do
  name = params[:name]
  listfilms = params[:listfilms]
  id = params[:id]
  erb :ticket, :locals => {'name' => name, 'film' => listfilms, 'id' => id}
end

after do
end