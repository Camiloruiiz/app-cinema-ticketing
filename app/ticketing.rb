class Ticketing
  def self.purchase(ticket, ledger, mailer)
    ledger.annotate_sale(ticket)
    mailer.send(ticket)
  end
end

class Ticket
  attr_reader :id, :name , :lastname, :mail, :phone, :list_films

  def initialize(data, repo)
    @id = repo.next_id
    @name, @lastname, @mail, @phone, @list_films = data["name"], data["lastname"], data["mail"], data["phone"], data["list_films"]
  end

  def ==(other)
    self.id == other.id
  end
end

class TicketsRepo
  @@records = {}
  @@id = 0

  def self.reset!
    @@records = {}
    @@id = 0
  end

  def all
    @@records.values
  end

  def self.find(id)
    @@records[id.to_i]
  end

  def annotate_sale(ticket)
    id = ticket.id
    @@records[id] = ticket
  end

  private
  def next_id
    @@id += 1
  end
end

class Mailer
  def initialize(hostname)
    @hostname = hostname
  end

  def send(ticket)
    Pony.mail(
      :from => 'noreply@esquemacreativo.com',
      :subject => 'Ticket purchase confirmation ' + ticket.name,
      :to => ticket.mail,
      :body => 'Enter the following link: http://' + @hostname + '/ticket/' + ticket.id.to_s
      )
  end
end
