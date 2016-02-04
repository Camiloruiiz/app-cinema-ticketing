require 'sinatra'
require 'pony'

class TicketPurchase
  @@records = {}
  @@index = 0
  
  def initialize 
    @@records[0] = 'init' unless @@records.keys.nil?
  end
  
  def self.db
    @@records
  end
  
  def get_id
    @@index += 1  
  end
  
  def save_in_db(ticket)
    @@records[get_id] = ticket
  end
  
  def send_mail(ticket, hostname)
    Pony.mail(
      :from => 'noreply@esquemacreativo.com', 
      :subject=> 'Ticket purchase confirmation ' + ticket[:name], 
      :to => ticket[:mail], 
      :body => 'Enter the following link: http://' + hostname + '/ticket/' + @@index.to_s
      )
  end
end

class App < Sinatra::Base
  
  
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
	@site_title = "Cinelandia"
    erb :home
  end 
  
  get'/form' do
	@site_title = "Form"
    erb :form
  end
  
  post '/confirmation' do
    @site_title = "Confirmation"
    ticket = TicketPurchase.new 
    ticket.save_in_db(params)
    
    hostname = request.host_with_port
    ticket.send_mail(params, hostname)
    
    erb :confirmation , :locals => {'ticket' => params}
  end
  
  get '/ticket/:id' do
    erb :ticket, :locals => {'id' => params[:id], 'records' => TicketPurchase.db}
  end
end