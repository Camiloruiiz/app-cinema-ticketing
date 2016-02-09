class Ticketing
  def purchase(data, hostname)
    id = RecordsManagement.new.save(data)
    Notification.new.sendmail(data, id, hostname)
  end
end

class RecordsManagement
  @@records = {}
  @@id = 0

  def initialize
    @@records[0] = 'init' unless @@records.keys.nil?
  end

  def self.all
    @@records
  end

  def get_id
    @@id
  end

  def increment_id
    @@id += 1
  end

  def save(ticket)
    @@records[increment_id] = ticket
    return get_id
  end
end

class Notification
  def sendmail(data, id, hostname)
    Pony.mail(
      :from => 'noreply@esquemacreativo.com',
      :subject => 'Ticket purchase confirmation ' + data[:name],
      :to => data[:mail],
      :body => 'Enter the following link: http://' + hostname + '/ticket/' + id.to_s
      )
  end
end