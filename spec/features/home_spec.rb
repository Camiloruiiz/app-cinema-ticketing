require 'spec_helper.rb'

describe 'Ticketing', :type => :feature do

  it 'responds with Home page' do
    visit '/' #Arrange
    #Act
    expect(page).to have_title "Cinelandia" #Assert
  end

  it 'click in the button purchase' do
  	visit '/' #Arrange

  	click_on('buy_tickets') #Act

  	expect(page).to have_content('Book your tickets:')
  end

  it 'film form in /form' do
  	#Arrange
  	Pony.override_options = { :via => :test }
  	visit '/form'

  	#Act
  	fill_in('name', :with => 'Camilo')
  	fill_in('lastname', :with => 'Ruiz')
  	fill_in('mail', :with => 'camilorojas@esquemacreativo.com')
  	select('Inside Out', :from => 'list_films')
  	click_on('send')

  	#Assert
  	expect(page).to have_title "Confirmation"
  	expect(page).to have_content('Hello Camilo Ruiz, your ticket to Inside Out It was successfully generated, you will soon receive an email with the details of your purchase')
  end
end