describe 'App ticketing Cinema' do
  context 'Generating ticket' do
    it 'the class RecordsManagement is defined' do
      expect(RecordsManagement.new.nil?).to eq(false)
    end
    it 'the class RecordsManagement is initialized whit {0=>"init"}' do
      #Arrange
      #Act
      RecordsManagement.new
      #Assert
      expect(RecordsManagement.db).to eq({0=>"init"})
    end

    it 'Save records in the hash' do
      #Arrange
      params = {
        "name"=>"Name Test",
        "lastname"=>"LastName Test",
        "mail"=>"test@test.com",
        "phone"=>"123456",
        "list_films"=>"Test."
      }
      #Act
      RecordsManagement.new
      RecordsManagement.new.save(params)
      #Assert
      expect(RecordsManagement.db).to eq({0=>"init", 1=>{"name"=>"Name Test", "lastname"=>"LastName Test", "mail"=>"test@test.com", "phone"=>"123456", "list_films"=>"Test."}})
    end
  end
end