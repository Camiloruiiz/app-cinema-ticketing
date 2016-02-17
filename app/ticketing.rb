class Ticketing
  def purchase(data, storage, mailer)
    ticket = Ticket.new(data)
    id = storage.save(ticket)
    mailer.send(ticket, id,)
  end
end

class Ticket
  def initialize(data)
    @ticket = data
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

class Mailer
  def initialize(hostname)
    @hostname = hostname
  end

  def send(ticket, id, hostname)
    Pony.mail(
      :from => 'noreply@esquemacreativo.com',
      :subject => 'Ticket purchase confirmation ' + ticket[:name],
      :to => ticket[:mail],
      :body => 'Enter the following link: http://' + hostname + '/ticket/' + id.to_s
      )
  end
end
