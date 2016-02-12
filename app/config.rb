
Pony.options = {
  :via => :smtp,
    :via_options => {
      :address => ENV['NOTIFY_ADDRESS'],
      :port => '587',
      :domain => ENV['NOTIFY_DOMAIN'],
      :user_name => ENV['NOTIFY_USERNAME'],
      :password => ENV['NOTIFY_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
