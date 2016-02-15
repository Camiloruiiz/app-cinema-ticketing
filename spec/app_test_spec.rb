describe 'App ticketing cinema' do
  context 'class "RecordsManagement"' do
    it 'is defined' do
      #Assert
      expect(RecordsManagement.new.nil?).to eq(false)
    end

    it 'is initialized whit {0=>"init"}' do
      #Act
      RecordsManagement.new
      #Assert
      expect(RecordsManagement.all).to eq({0=>"init"})
    end

    it 'the id should increase one by one' do
      #Arrange
      test_incremental = RecordsManagement.new
      #Assert
      expect(RecordsManagement.new.get_id).to eq(0)
      test_incremental.increment_id
      expect(RecordsManagement.new.get_id).to eq(1)
      test_incremental.increment_id
      expect(RecordsManagement.new.get_id).to eq(2)
      test_incremental.increment_id
      expect(RecordsManagement.new.get_id).to eq(3)
      test_incremental.increment_id
      expect(RecordsManagement.new.get_id).to eq(4)
      test_incremental.increment_id
      expect(RecordsManagement.new.get_id).to eq(5)
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
      #Act
      RecordsManagement.new.save(params)
      #Assert
      expect(RecordsManagement.all).to eq({0=>"init", 6=>{"name"=>"Name Test", "lastname"=>"LastName Test", "mail"=>"test@test.com", "phone"=>"123456", "list_films"=>"Test."}})
    end
  end

  context 'generate notificaction' do
    it 'the class "Notification" is defined' do
      #Assert
      expect(Notification.new.nil?).to eq(false)
    end
  end
end
