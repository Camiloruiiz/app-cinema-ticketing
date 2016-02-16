class Ticketing
  #hacer injection de dependencias

  def purchase(data, hostname)
    ticket = Ticket.new.create(data)
    id = RecordsManagement.new.save(ticket)
    Notification.new.sendmail(ticket, id, hostname)
  end
end

class Ticket
  def initialize
    @ticket = []
  end

  def create(data)
    @ticket = data
    @ticket
  end
end
## dividir en dos
class RecordsManagement
  @@records = {}

  def initialize
    @@records[0] = 'init' unless @@records.keys.nil?
  end

  def self.all
    @@records
  end

  def get_id
    @@records.keys.max
  end

  def save(ticket)
    @@records[(get_id) + 1] = ticket
    return get_id
  end
end

class Notification
  def sendmail(ticket, id, hostname)
    Pony.mail(
      :from => 'noreply@esquemacreativo.com',
      :subject => 'Ticket purchase confirmation ' + ticket[:name],
      :to => ticket[:mail],
      :body => 'Enter the following link: http://' + hostname + '/ticket/' + id.to_s
      )
  end
end
