require 'rubygems'
require 'sinatra'
require 'pony'



class App < Sinatra::Base
  
  SITE_TITLE = "Cinelandia"
  SITE_DESCRIPTION = "Lo mejor del Cine"
  PELICULA_DE_LA_SEMANA = "Inside Out"

  @@records = {}
  @@records[0] = 'init' unless @@records.keys.nil?
  
  def get_id(db)
    @index = @@records.keys.max + 1 
  end
  
  def save_in_db(db)
    @@records[@index] = db
  end
  
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
    
    id = get_id(db)
    save_in_db(db)
    
    Pony.mail(
      :from => 'noreply@esquemacreativo.com', 
      :subject=> 'Confirmación compra de Ticket ' + db[:name], 
      :to => db[:correo], 
      :body => 'Ingresa al siguiente link: http://' + @hostname + '/ticket/' + id.to_s
      )
  
    erb :confirmation , 
    :locals => {
      'name' => db[:name], 
      'apellido' => db[:apellido], 
      'correo' => db[:correo], 
      'telefono' => db[:telefono], 
      'film' => db[:listfilms]
      }
  end
  
  get '/ticket/:id' do
    id = params[:id]
    erb :ticket, :locals => {'id' => id, 'records' => @@records}
  end
  
  after do
    puts @@records
  end
end