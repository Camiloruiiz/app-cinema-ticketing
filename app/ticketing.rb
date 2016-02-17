class Ticketing
  def purchase(data, storage, sendmail)
    ticket = Ticket.new.create(data)
    id = storage.save(ticket)
    sendmail.notification(ticket, id)
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

class TicketsMemory
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

class SendMail
  def initialize(hostname)
    @hostname = hostname
  end

  def notification(ticket, id)
    Pony.mail(
      :from => 'noreply@esquemacreativo.com',
      :subject => 'Ticket purchase confirmation ' + ticket[:name],
      :to => ticket[:mail],
      :body => 'Enter the following link: http://' + @hostname + '/ticket/' + id.to_s
      )
  end
end
