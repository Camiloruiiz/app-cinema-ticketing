class RecordsManagement
  @@records = {}
  @@id = 0

  def initialize
    @@records[0] = 'init' unless @@records.keys.nil?
  end

  def self.db
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


class Ticketing
  def purchase(ticket, hostname)

    id = RecordsManagement.new.save(ticket)

    Pony.mail(
      :from => 'noreply@esquemacreativo.com',
      :subject => 'Ticket purchase confirmation ' + ticket[:name],
      :to => ticket[:mail],
      :body => 'Enter the following link: http://' + hostname + '/ticket/' + id.to_s
      )
  end
end


#class Ticketing
#  @@records = {}
#  @@index = 0
#
#  def initialize
#    @@records[0] = 'init' unless @@records.keys.nil?
#  end
#
#  def self.db
#    @@records
#  end
#
#  def get_id
#    @@index += 1
#  end
#
#  def purchase(ticket, hostname)
#
#    @@records[get_id] = ticket
#
#    Pony.mail(
#      :from => 'noreply@esquemacreativo.com',
#      :subject => 'Ticket purchase confirmation ' + ticket[:name],
#      :to => ticket[:mail],
#      :body => 'Enter the following link: http://' + hostname + '/ticket/' + @@index.to_s
#      )
#  end
#end