describe 'App ticketing cinema' do
  context 'class "TicketsRepo"' do
    it 'is initialized' do
      #Act
      repo = TicketsRepo.new
      #Assert
      expect(repo.all).to eq([])
    end

    it 'save records in the hash' do
      #Arrange
      params = {
        "name"=>"Name Test",
        "lastname"=>"LastName Test",
        "mail"=>"test@test.com",
        "phone"=>"123456",
        "list_films"=>"Test."
      }
      ledger = TicketsRepo.new
      ticket = Ticket.new(params, ledger)
      #Act
      repo = TicketsRepo.new
      repo.annotate_sale(ticket)
      #Assert
      expect(repo.all).to eq([ticket])
    end

    it 'the id should increase one by one' do
      #Arrange
      TicketsRepo.reset!
      ledger = TicketsRepo.new
      data_1 = {
        "name"=>"Name Test",
        "lastname"=>"LastName Test",
        "mail"=>"test@test.com",
        "phone"=>"123456",
        "list_films"=>"Test."
      }
      ticket_1 = Ticket.new(data_1, ledger)

      data_2 = {
        "name"=>"Name Test",
        "lastname"=>"LastName Test",
        "mail"=>"test@test.com",
        "phone"=>"123456",
        "list_films"=>"Test."
      }
      ticket_2 = Ticket.new(data_2, ledger)

      #Act
      repo = TicketsRepo.new
      repo.annotate_sale(ticket_1)
      repo.annotate_sale(ticket_2)
      #Assert
      expect(ticket_1.id).to eq(1)
      expect(ticket_2.id).to eq(2)
    end

  end

  context 'class "Mailer"' do
    it 'is initialized' do
      #Assert
      mailer = Mailer.new("localhost:9292")
      expect(mailer).to eq(mailer)
    end
  end
end
