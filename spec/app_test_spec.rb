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
end