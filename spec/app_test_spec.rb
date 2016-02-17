describe 'App ticketing cinema' do
  context 'class "TicketsMemory"' do
    it 'is defined' do
      #Assert
      expect(TicketsMemory.new.nil?).to eq(false)
    end

    it 'is initialized whit {0=>"init"}' do
      #Act
      TicketsMemory.new
      #Assert
      expect(TicketsMemory.all).to eq({0=>"init"})
    end

    it 'the id should increase one by one' do
      #Arrange
      data = {
        "name"=>"Name Test",
        "lastname"=>"LastName Test",
        "mail"=>"test@test.com",
        "phone"=>"123456",
        "list_films"=>"Test."
      }
      test_ticket = Ticket.new.create(data)
      2.times{TicketsMemory.new.save(test_ticket)}
      #Assert
      expect(TicketsMemory.all.keys.max).to eq(2)
    end

    it 'save records in the hash' do
      #Arrange
      data = {
        "name"=>"Name Test",
        "lastname"=>"LastName Test",
        "mail"=>"test@test.com",
        "phone"=>"123456",
        "list_films"=>"Test."
      }
      #Act
      TicketsMemory.new.save(data)
      #Assert
      expect(TicketsMemory.all).to eq({
        0=>"init",
        1=>{"name"=>"Name Test", "lastname"=>"LastName Test", "mail"=>"test@test.com", "phone"=>"123456", "list_films"=>"Test."},
        2=>{"name"=>"Name Test", "lastname"=>"LastName Test", "mail"=>"test@test.com", "phone"=>"123456", "list_films"=>"Test."},
        3=>{"name"=>"Name Test", "lastname"=>"LastName Test", "mail"=>"test@test.com", "phone"=>"123456", "list_films"=>"Test."}})
    end
  end

  context 'generate notificaction' do
    xit 'the class "Notification" is defined' do
      #Assert
      expect(SendMail.new.nil?).to eq(false)
    end
  end
end
