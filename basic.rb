require 'rubygems'
require 'sinatra'
require 'pony'

class App < Sinatra::Base
  
  SITE_TITLE = "Cinelandia"
  SITE_DESCRIPTION = "The best cinema"
  FILM_OF_THE_WEEK = "Inside Out"

  @@records = {}
  @@records[0] = 'init' unless @@records.keys.nil?
  
  Customer = Struct.new(:name, :lastname, :mail, :phone, :list_films)
  
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
    
    db = Customer.new(params[:name], params[:lastname], params[:mail], params[:phone], params[:list_films]).to_h
    
    id = get_id(db)
    save_in_db(db)
    
    Pony.mail(
      :from => 'noreply@esquemacreativo.com', 
      :subject=> 'Ticket purchase confirmation ' + db[:name], 
      :to => db[:mail], 
      :body => 'Enter the following link: http://' + @hostname + '/ticket/' + id.to_s
      )
  
    erb :confirmation , 
    :locals => {
      'name' => db[:name], 
      'lastname' => db[:lastname], 
      'mail' => db[:mail], 
      'phone' => db[:phone], 
      'list_films' => db[:list_films]
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