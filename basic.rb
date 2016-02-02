require 'rubygems'
require 'sinatra'
require 'pony'

class TicketPurchase
  @@records = {}
  
  def initialize 
    @@records[0] = 'init' unless @@records.keys.nil?
  end
  
  def self.dbs
    @@records
  end
  
  def get_id
    @index = @@records.keys.max + 1 
  end
  
  def save_in_db(ticket)
    @@records[@index] = ticket
  end
  
  def send_mail(ticket, id , hostname)
    Pony.mail(
      :from => 'noreply@esquemacreativo.com', 
      :subject=> 'Ticket purchase confirmation ' + ticket[:name], 
      :to => ticket[:mail], 
      :body => 'Enter the following link: http://' + hostname + '/ticket/' + id.to_s
      )
  end
end

class App < Sinatra::Base
  
  SITE_TITLE = "Cinelandia"
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
  
  get '/' do
    erb :home
  end 
  
  get'/compraform' do
    erb :compraform
  end
  
  post '/confirmation' do
    
    ticket = TicketPurchase.new 
    
    id = ticket.get_id
    
    ticket.save_in_db(params)
    
    hostname = request.host_with_port
    
    ticket.send_mail(params, id, hostname)
    
    erb :confirmation , :locals => {'ticket' => params}
  end
  
  get '/ticket/:id' do
    erb :ticket, :locals => {'id' => params[:id], 'records' => TicketPurchase.dbs}
  end
  
  after do
    puts TicketPurchase.dbs
  end
end